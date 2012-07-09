class ProjectsInstaller
  def self.InstallProjects
    puts "Projects Installer - Installing projects."
    
    projects_data_file = File.join(INSTALLER_DATA_DIR, "projects.xml")
    return false if !File.exists?(projects_data_file)
    
    file_obj = File.open(projects_data_file, "r")
    xml_obj = Nokogiri::XML(file_obj.read)
    file_obj.close
    
    return false if xml_obj.nil?
    
    project_objs = xml_obj.css("projects-list > project")
    return false if project_objs.nil? || project_objs.length <= 0
    
    count = 0
    project_objs.each do |project_obj|
      aProject = Project.new
      
      aProject.Name = project_obj["name"]
      aProject.Description  = project_obj.at_css("description").content
      
      aProject.tag_names = project_obj["tag_names"]
      
      if aProject.save
        count += 1
        puts "Successfully installed project: " + aProject.Name + "."
      end
    end
    
    puts "Projects Installer successfully created " + count.to_s + " of " + project_objs.length.to_s + " projects." 
    
    return (count == project_objs.length)
  end
end