# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Suwaru::Application.load_tasks

task :routest => :environment do
  puts "'Application.routes' is a " + Suwaru::Application.routes.class.to_s
end