class TagsInstaller
  def self.InstallTags
    tag_file = File.join(INSTALLER_DATA_DIR, "tags.txt")
    return false if !File.exists?(tag_file)
    
    file_obj = File.open(tag_file)
    tag_data = file_obj.read
    file_obj.close
    
    return false if tag_data.nil?
    
    tag_names = tag_data.split(" ")
    puts "There are " + (tag_names.nil? ? "NIL" : tag_names.length.to_s) + " tag names."

    count = 0
    tag_names.each do |aTagName|
      aTag = Tag.new({:Name => aTagName})
      if aTag.save
        count += 1
        puts "Saved tag with name: " + aTag.Name
      end
    end

    return (count == tag_names.length)
  end
end