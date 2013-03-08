class Project < ActiveRecord::Base

  using_access_control

  has_one :SiteContent, :foreign_key => :content_id, :as => :Content, :inverse_of => :Content, :dependent => :destroy
  accepts_nested_attributes_for :SiteContent
  
  belongs_to :GithubAuth, :foreign_key => :github_auth_id
  serialize :GithubAttributes, Hashie::Mash
  
  include SuwaruContent::ContentType
  
  include SuwaruContent::Commentable
  include SuwaruContent::Flaggable
  include SuwaruContent::Taggable
  include SuwaruContent::Categorizable
  
  attr_accessor :icon_image_file, :banner_image_file
  after_validation :update_image_files
  
  def self.ImageDirectory
    dir_path = File.expand_path(File.join(__FILE__, "../../../", "public/images/projects"))
    Dir.mkdir(dir_path, 0777) if !File.exists?(dir_path) && !File.directory?(dir_path)
    
    return dir_path
  end
  
  def SyncWithRepo( aRepo = nil )
    return false if aRepo.nil? 
    
    self.Title            = aRepo.name
    self.Description      = aRepo.description

    self.GithubAttributes = aRepo

    self.GithubSynced     = Time.now

    self.SiteContent.modified_by_id = GithubAuth.find(self.github_auth_id).user_id
    
    return self.save
  end
  def update_image_files
    if @icon_image_file
      filename = @icon_image_file.original_filename
      
      if File.exists?(File.join(Project.ImageDirectory, filename))
        filename = @icon_image_file.original_filename.split(".").join("_" + Time.now.to_i.to_s + ".")
      end
      
      file_obj = File.new(File.join(Project.ImageDirectory, filename), "w+")
      file_obj.write(@icon_image_file.tempfile.read)
      file_obj.close
    
      self.IconImage = filename
    end
    
    if @banner_image_file
      filename = @banner_image_file.original_filename
      
      if File.exists?(File.join(Project.ImageDirectory, filename))
        filename = @banner_image_file.original_filename.split(".").join("_" + Time.now.to_i.to_s + ".")
      end
      
      file_obj = File.new(File.join(Project.ImageDirectory, filename), "w+")
      file_obj.write(@banner_image_file.tempfile.read)
      file_obj.close
    
      self.BannerImage = filename
    end
  end
end
