class Category < ActiveRecord::Base
  
  using_access_control
  
  #has_many :Posts,      :foreign_key => :category_id, :inverse_of => :Category
  #has_many :Projects,   :foreign_key => :category_id, :inverse_of => :Category
  
  has_many :ContentCategories, :foreign_key => :category_id
  
#=begin  
  def Contents
    return nil if self.ContentCategories.empty? || self.ContentCategories.size <= 0
    contents = self.ContentCategories.collect{ |cCategory| cCategory.Content }
    return contents.sort{ |aContent, bContent| bContent.updated_at <=> aContent.updated_at }
  end
#=end
end
