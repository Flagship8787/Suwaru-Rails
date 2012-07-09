class Post < ActiveRecord::Base
  
  #using_access_control
  
  belongs_to  :CreatedBy,         :foreign_key => :created_by_id,   :class_name => "User"
  belongs_to  :ModifiedBy,        :foreign_key => :modified_by_id,  :class_name => "User"

  has_many    :ContentCategories, :foreign_key => :content_id,  :as => :Content
  has_many    :Categories,        :through => :ContentCategories
  
  has_many    :Comments,          :foreign_key => :parent_id,   :as => :Parent
    
  has_many    :TaggedContents,    :foreign_key => :content_id,  :as => :Content
  has_many    :Tags,              :through => :TaggedContents
    
  has_many    :Flags,             :foreign_key => :flagged_id,  :as => :Flagged 
  
  attr_writer :tag_names, :category_names
  after_save  :assign_tags, :assign_categories
  
  def tag_names
    @tag_names || self.Tags.map(&:Name).join(' ')
  end
  def category_names
    @category_names || self.Categories.map(&:Name).join(' ')
  end

private
  def assign_tags
    if @tag_names
      @tag_names.split(/\s+/).each do |name|
        aTag = Tag.find_or_create_by_Name(name)
        self.TaggedContents << TaggedContent.new({:Content => self, :Tag => aTag}) if !self.TaggedContents.exists?({:tag_id => aTag.id})
      end
    end
  end
  def assign_categories
    if @category_names
      @category_names.split(/\s+/).each do |name|
        aCategory = Category.find_or_create_by_Name(name)
        self.ContentCategories << ContentCategory.new({:Content => self, :Category => aCategory}) if !self.ContentCategories.exists?({:category_id => aCategory.id})
      end
    end
  end
end
