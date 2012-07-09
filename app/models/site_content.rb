class SiteContent < ActiveRecord::Base

  belongs_to  :Content,      :foreign_key => :content_id,      :polymorphic => true
  
  belongs_to  :CreatedBy,    :foreign_key => :created_by_id,   :class_name => "User"
  belongs_to  :ModifiedBy,   :foreign_key => :created_by_id,   :class_name => "User"
  belongs_to  :PublishedBy,  :foreign_key => :published_by_id, :class_name => "User"
  
  belongs_to  :Category,     :foreign_key => :categoryid
  
  has_many    :Comments,     :foreign_key => :parent_id,       :inverse_of => :Parent
  
  has_many    :ContentFlags, :foreign_key => :flagged_id,      :as => :Flagged 
  has_many    :Flags,        :through => :ContentFlags
  
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
