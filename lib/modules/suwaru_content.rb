module SuwaruContent  
  module ContentType
    attr_accessor :BannerImage, :ThumbImage
    
    def self.included(base)
      base.after_initialize :initialize_site_content
      base.after_find :load_attributes
      base.after_create :save_creator
    end

  private
    def initialize_site_content
      self.SiteContent = SiteContent.new if self.SiteContent.nil?
      self.SiteContent.content_type = self.class.to_s if self.SiteContent.content_type.nil?
    end
    def save_creator
      self.SiteContent.created_by_id = self.SiteContent.modified_by_id
    end
    def load_attributes
      # => loading banner image
      if self.SiteContent.nil? || self.SiteContent.Banner_file_name.nil?
        self.BannerImage = nil
      else
        self.BannerImage = File.join(SiteContent.image_directory, self.SiteContent.Banner_file_name)
      end

      # => loading banner image
      if self.SiteContent.nil? || self.SiteContent.Thumb_file_name.nil?
        self.ThumbImage = nil
      else
        self.ThumbImage = File.join(SiteContent.image_directory, self.SiteContent.Thumb_file_name)
      end 
    end
  end
  module Commentable
    def self.included(base)
      base.after_create :auto_comment
    end
    def Commentable?
      return true
    end

  private
    def auto_comment
      self.SiteContent.Comments << Comment.new({:Body => "Hello you " + self.class.to_s + "! This is the first comment on you!"})
      self.SiteContent.Comments << Comment.new({:Body => "Hello you " + self.class.to_s + "! This is the second comment on you!"})
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
      @tag_names || self.SiteContent.Tags.map(&:Name).join(' ')
    end
  
  private
    def assign_tags
      
      puts "Assigning tags for " + self.class.to_s + ": " + (@tag_names ? @tag_names : "NIL")
      
      if @tag_names
        @tag_names.split(/\s+/).each do |name|
          aTag = Tag.find_or_create_by_Name(name)
          if !self.SiteContent.TaggedContents.exists?({:tag_id => aTag.id})
            self.SiteContent.TaggedContents << TaggedContent.new({:SiteContent => self.SiteContent, :Tag => aTag})
          end
        end
      end
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
      @category_name || (self.SiteContent.Category ? self.SiteContent.Category.Name : nil)
    end
    
    def Categorizable?
      return true
    end
  
  private
    def assign_category
      puts "Assigning categories for " + self.class.to_s + ": " + (@category_name ? @category_name : "NIL")
      
      if @category_name
        self.SiteContent.update_attribute("category_id", Category.find_or_create_by_Name(@category_name).id)
      elsif self.SiteContent.category_id.nil?
        self.SiteContent.update_attribute("category_id", Category.find_or_create_by_Name("Miscellaneous").id) 
      end
    end
  end
end