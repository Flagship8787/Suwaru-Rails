class RolesInstaller
  def self.InstallRoles
    puts "Role Installer - Installing Roles"
    
    roles_data_file = File.join(INSTALLER_DATA_DIR, "roles.xml")
    return false if !File.exists?(roles_data_file)
    
    file_obj = File.open(roles_data_file, "r")
    xml_obj = Nokogiri::XML(file_obj.read)
    file_obj.close
    
    return false if xml_obj.nil?
    
    role_objs = xml_obj.css("roles-list > role")
    return false if role_objs.nil? || role_objs.length <= 0
    
    count = 0
    role_objs.each do |role_obj|
      aRole = Role.new
      
      aRole.Name = role_obj["name"]
      aRole.Description = role_obj.content
      
      if aRole.save
        count += 1
        puts "Successfully installed role: " + aRole.Name + "."
      end
    end
    
    puts "Roles Installer successfully created " + count.to_s + " of " + role_objs.length.to_s + " roles." 
    
    return (count == role_objs.length)
  end
end