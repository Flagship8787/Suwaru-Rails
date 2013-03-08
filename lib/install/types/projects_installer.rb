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
      
      aProject.Title = project_obj["title"]
      aProject.Description  = project_obj.at_css("description").content
      
      aProject.tag_names = project_obj["tag_names"]
      aProject.category_name = project_obj["category_name"]
      
      aProject.SiteContent = SiteContent.new({:content_type => aProject.class.to_s})
      aProject.SiteContent.CreatedBy = User.find_by_username(project_obj["created_by"])
      aProject.SiteContent.ModifiedBy = User.find_by_username(project_obj["modified_by"])
      
      if aProject.save
        count += 1
        puts "Successfully installed project: " + aProject.Title + "."

        # => Now we install this post's comments      
        comment_objs = project_obj.css("comments > comment")
        if !comment_objs.nil? && comment_objs.length > 0
          cCount = 0
          comment_objs.each do |comment_obj|
            aComment            = Comment.new
            
            aComment.Parent     = aProject.SiteContent
            aComment.Poster     = User.find_by_username(comment_obj["poster"])
            aComment.Body       = comment_obj.content
            
            cCount += 1 if aComment.save
          end
          puts "Created " + cCount.to_s + " of " + comment_objs.length.to_s + " comments for project."
        end
      end
    end
    
    return (count == project_objs.length ? true : false)
  end
end