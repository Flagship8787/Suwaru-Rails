task :reinstall do
  puts "Rake's remigrating'"
  Rake::Task["remigrate"].invoke
  
  puts "Running installers"
  Rake::Task["reinstall_users"].invoke
end

task :reinstall_users => :environment do
  require File.join(INSTALLER_DIR, "installer.rb")
  
  Installer.PerformInstallion
end
