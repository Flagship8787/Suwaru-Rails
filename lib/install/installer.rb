class Installer
  
  require File.join(INSTALLER_TYPES_DIR, "roles_installer.rb") 
  require File.join(INSTALLER_TYPES_DIR, "users_installer.rb") 
  require File.join(INSTALLER_TYPES_DIR, "categories_installer.rb") 
  require File.join(INSTALLER_TYPES_DIR, "posts_installer.rb")  
  require File.join(INSTALLER_TYPES_DIR, "projects_installer.rb") 
  require File.join(INSTALLER_TYPES_DIR, "contact_forms_installer.rb")
  require File.join(INSTALLER_TYPES_DIR, "tags_installer.rb")
  
  require File.join(DECL_AUTH_HOME, "lib", "declarative_authorization", "maintenance.rb")
  def self.PerformInstallion
    Authorization::Maintenance.without_access_control do
      RolesInstaller.InstallRoles  
      UsersInstaller.InstallUsers
      CategoriesInstaller.InstallCategories
      PostsInstaller.InstallPosts
      ProjectsInstaller.InstallProjects
      ContactFormsInstaller.InstallContactForms
      TagsInstaller.InstallTags
    end
  end
end