class CategoriesInstaller
  def self.InstallCategories
    puts "Categories Installer - Installing categories."
    
    categories_data_file = File.join(INSTALLER_DATA_DIR, "categories.xml")
    return false if !File.exists?(categories_data_file)
    
    file_obj = File.open(categories_data_file, "r")
    xml_obj = Nokogiri::XML(file_obj.read)
    file_obj.close
    
    return false if xml_obj.nil?
    
    category_objs = xml_obj.css("categories-list > category")
    return false if category_objs.nil? || category_objs.length <= 0
    
    count = 0
    category_objs.each do |category_obj|
      aCategory = Category.new
      
      aCategory.Name = category_obj["name"]
      aCategory.Description  = category_obj.content
      
      if aCategory.save
        count += 1
        puts "Successfully installed category: " + aCategory.Name + "."
      end
    end
    
    puts "Categories Installer successfully created " + count.to_s + " of " + category_objs.length.to_s + " categories." 
    
    return (count == category_objs.length)
  end
end