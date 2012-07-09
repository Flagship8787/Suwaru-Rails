class UsersInstaller
  def self.InstallUsers
    users_data_file = File.join(INSTALLER_DATA_DIR, "users.xml")
    return false if !File.exists?(users_data_file)
    
    file_obj = File.open(users_data_file, "r")
    xml_obj = Nokogiri::XML(file_obj.read)
    file_obj.close
    
    return false if xml_obj.nil?
    
    user_objs = xml_obj.css("users-list > user")
    return false if user_objs.nil? || user_objs.length <= 0
    
    count = 0
    user_objs.each do |user_obj|
      aUser = User.new
      
      aUser.username                = user_obj["username"]
      aUser.email                   = user_obj["email"]
      aUser.password                = user_obj["password"]
      aUser.password_confirmation   = user_obj["password"]
      
      aUser.Role                    = Role.find_by_Name(user_obj["role"])
      
      if aUser.save
        count += 1
        puts "Successfully installed user: " + aUser.username + "."
      end
    end
    
    puts "users Installer successfully created " + count.to_s + " of " + user_objs.length.to_s + " users." 
    
    return (count == user_objs.length)
  end
end