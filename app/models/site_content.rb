class SiteContent < ActiveRecord::Base

  using_access_control

  belongs_to  :Content,         :foreign_key => :content_id,      :polymorphic => true
  
  belongs_to  :CreatedBy,       :foreign_key => :created_by_id,   :class_name => "User"
  belongs_to  :ModifiedBy,      :foreign_key => :created_by_id,   :class_name => "User"
  belongs_to  :PublishedBy,     :foreign_key => :published_by_id, :class_name => "User"
  
  belongs_to  :Category,        :foreign_key => :category_id
  
  has_many    :Comments,        :foreign_key => :parent_id,       :inverse_of => :Parent
  
  has_many    :Flags,           :foreign_key => :flagged_id,      :as => :Flagged
  
  has_many    :TaggedContents,  :foreign_key => :site_content_id 
  has_many    :Tags,            :through => :TaggedContents

  before_create :update_publishing
  before_save   :update_publishing

  def self.image_directory
  	dir = File.expand_path(File.join(__FILE__, "../../../public/sc_images"))
  	Dir.mkdir(dir, 0777) if !File.exists?(dir) || !File.directory?(dir)

  	return dir
  end

  def update_publishing
    if self.Published && self.PublishedAt.nil?
      self.PublishedAt = Time.now
    end

    if !self.Published && !self.PublishedAt.nil?
      self.PublishedAt = nil
    end
  end
end
