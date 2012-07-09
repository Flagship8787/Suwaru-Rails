module SuwaruContent  
  module ContentType
    attr_accessor :Published
    
    def self.included(base)
      base.after_initialize :initialize_site_content
      base.after_save :assign_publishing
    end
    
    def Published
      return @Published if !@Published.nil?
      return false if self.SiteContent.nil?
      return (self.SiteContent.Published.nil? ? false : true)
    end
    
    def Published?
      self.Published
    end
    
  private
    def initialize_site_content
      self.SiteContent = SiteContent.new if self.SiteContent.nil?
    end
    def assign_publishing
      if self.SiteContent.Published.nil? && @Published == true
        puts "Publishing " + self.class.to_s
        self.SiteContent.update_attribute("Published", Time.now)
      end  
      if !self.SiteContent.Published.nil? && @Published == false
        puts "Un-Publishing " + self.class.to_s
        self.SiteContent.update_attribute("Published", nil)
      end  
    end
  end
  module Commentable
    def Commentable?
      return true
    end
  end
  module Taggable
    
    attr_accessor :tag_names
    
    def self.included(base)
      base.after_save :assign_tags  
    end
    
    def Taggable?
      return true
    end 
    
    def tag_names
      @tag_names# || self.SiteContent.Tags.map(&:Name).join(' ')
    end
  
  private
    def assign_tags
=begin
      if @tag_names
        @tag_names.split(/\s+/).each do |name|
          aTag = Tag.find_or_create_by_Name(name)
          self.Content.TaggedContents << TaggedContent.new({:Content => self, :Tag => aTag}) if !self.TaggedContents.exists?({:tag_id => aTag.id})
        end
      end
=end
      puts "Assigning tags for " + self.class.to_s
    end
  end
  module Flaggable
    def Flaggable?
      return true
    end
  end
  module Categorizable
    attr_writer :category_name
    
    def self.included(base)
      base.after_save  :assign_category
    end
    
    def category_name
      @category_name# || self.SiteContent.Category.Name
    end
    
    def Categorizable?
      return true
    end
  
  private
    def assign_category
      if @category_name
        self.SiteContent.update_attribute("category_id", Category.find_or_create_by_Name(@category_name).id)
      end
    end
  end
end