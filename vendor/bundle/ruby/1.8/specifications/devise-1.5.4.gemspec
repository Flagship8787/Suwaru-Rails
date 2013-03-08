# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{devise}
  s.version = "1.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jos\303\251 Valim", "Carlos Ant\303\264nio"]
  s.date = %q{2013-01-26}
  s.description = %q{Flexible authentication solution for Rails with Warden}
  s.email = %q{contact@plataformatec.com.br}
  s.files = [".gitignore", ".travis.yml", "CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE", "README.rdoc", "Rakefile", "app/controllers/devise/confirmations_controller.rb", "app/controllers/devise/omniauth_callbacks_controller.rb", "app/controllers/devise/passwords_controller.rb", "app/controllers/devise/registrations_controller.rb", "app/controllers/devise/sessions_controller.rb", "app/controllers/devise/unlocks_controller.rb", "app/helpers/devise_helper.rb", "app/mailers/devise/mailer.rb", "app/views/devise/confirmations/new.html.erb", "app/views/devise/mailer/confirmation_instructions.html.erb", "app/views/devise/mailer/reset_password_instructions.html.erb", "app/views/devise/mailer/unlock_instructions.html.erb", "app/views/devise/passwords/edit.html.erb", "app/views/devise/passwords/new.html.erb", "app/views/devise/registrations/edit.html.erb", "app/views/devise/registrations/new.html.erb", "app/views/devise/sessions/new.html.erb", "app/views/devise/shared/_links.erb", "app/views/devise/unlocks/new.html.erb", "config/locales/en.yml", "devise.gemspec", "lib/devise.rb", "lib/devise/controllers/helpers.rb", "lib/devise/controllers/internal_helpers.rb", "lib/devise/controllers/rememberable.rb", "lib/devise/controllers/scoped_views.rb", "lib/devise/controllers/shared_helpers.rb", "lib/devise/controllers/url_helpers.rb", "lib/devise/delegator.rb", "lib/devise/encryptors/authlogic_sha512.rb", "lib/devise/encryptors/base.rb", "lib/devise/encryptors/clearance_sha1.rb", "lib/devise/encryptors/restful_authentication_sha1.rb", "lib/devise/encryptors/sha1.rb", "lib/devise/encryptors/sha512.rb", "lib/devise/failure_app.rb", "lib/devise/hooks/activatable.rb", "lib/devise/hooks/forgetable.rb", "lib/devise/hooks/rememberable.rb", "lib/devise/hooks/timeoutable.rb", "lib/devise/hooks/trackable.rb", "lib/devise/mailers/helpers.rb", "lib/devise/mapping.rb", "lib/devise/models.rb", "lib/devise/models/authenticatable.rb", "lib/devise/models/confirmable.rb", "lib/devise/models/database_authenticatable.rb", "lib/devise/models/encryptable.rb", "lib/devise/models/lockable.rb", "lib/devise/models/omniauthable.rb", "lib/devise/models/recoverable.rb", "lib/devise/models/registerable.rb", "lib/devise/models/rememberable.rb", "lib/devise/models/serializable.rb", "lib/devise/models/timeoutable.rb", "lib/devise/models/token_authenticatable.rb", "lib/devise/models/trackable.rb", "lib/devise/models/validatable.rb", "lib/devise/modules.rb", "lib/devise/omniauth.rb", "lib/devise/omniauth/config.rb", "lib/devise/omniauth/url_helpers.rb", "lib/devise/orm/active_record.rb", "lib/devise/orm/mongoid.rb", "lib/devise/param_filter.rb", "lib/devise/path_checker.rb", "lib/devise/rails.rb", "lib/devise/rails/routes.rb", "lib/devise/rails/warden_compat.rb", "lib/devise/schema.rb", "lib/devise/strategies/authenticatable.rb", "lib/devise/strategies/base.rb", "lib/devise/strategies/database_authenticatable.rb", "lib/devise/strategies/rememberable.rb", "lib/devise/strategies/token_authenticatable.rb", "lib/devise/test_helpers.rb", "lib/devise/version.rb", "lib/generators/active_record/devise_generator.rb", "lib/generators/active_record/templates/migration.rb", "lib/generators/active_record/templates/migration_existing.rb", "lib/generators/devise/devise_generator.rb", "lib/generators/devise/install_generator.rb", "lib/generators/devise/orm_helpers.rb", "lib/generators/devise/views_generator.rb", "lib/generators/mongoid/devise_generator.rb", "lib/generators/templates/README", "lib/generators/templates/devise.rb", "lib/generators/templates/markerb/confirmation_instructions.markerb", "lib/generators/templates/markerb/reset_password_instructions.markerb", "lib/generators/templates/markerb/unlock_instructions.markerb", "lib/generators/templates/simple_form_for/confirmations/new.html.erb", "lib/generators/templates/simple_form_for/passwords/edit.html.erb", "lib/generators/templates/simple_form_for/passwords/new.html.erb", "lib/generators/templates/simple_form_for/registrations/edit.html.erb", "lib/generators/templates/simple_form_for/registrations/new.html.erb", "lib/generators/templates/simple_form_for/sessions/new.html.erb", "lib/generators/templates/simple_form_for/unlocks/new.html.erb", "test/controllers/helpers_test.rb", "test/controllers/internal_helpers_test.rb", "test/controllers/sessions_controller_test.rb", "test/controllers/url_helpers_test.rb", "test/delegator_test.rb", "test/devise_test.rb", "test/encryptors_test.rb", "test/failure_app_test.rb", "test/generators/active_record_generator_test.rb", "test/generators/devise_generator_test.rb", "test/generators/install_generator_test.rb", "test/generators/mongoid_generator_test.rb", "test/generators/views_generator_test.rb", "test/helpers/devise_helper_test.rb", "test/indifferent_hash.rb", "test/integration/authenticatable_test.rb", "test/integration/confirmable_test.rb", "test/integration/database_authenticatable_test.rb", "test/integration/http_authenticatable_test.rb", "test/integration/lockable_test.rb", "test/integration/omniauthable_test.rb", "test/integration/recoverable_test.rb", "test/integration/registerable_test.rb", "test/integration/rememberable_test.rb", "test/integration/timeoutable_test.rb", "test/integration/token_authenticatable_test.rb", "test/integration/trackable_test.rb", "test/mailers/confirmation_instructions_test.rb", "test/mailers/reset_password_instructions_test.rb", "test/mailers/unlock_instructions_test.rb", "test/mapping_test.rb", "test/models/authenticatable_test.rb", "test/models/confirmable_test.rb", "test/models/database_authenticatable_test.rb", "test/models/encryptable_test.rb", "test/models/lockable_test.rb", "test/models/recoverable_test.rb", "test/models/rememberable_test.rb", "test/models/serializable_test.rb", "test/models/timeoutable_test.rb", "test/models/token_authenticatable_test.rb", "test/models/trackable_test.rb", "test/models/validatable_test.rb", "test/models_test.rb", "test/omniauth/config_test.rb", "test/omniauth/url_helpers_test.rb", "test/orm/active_record.rb", "test/orm/mongoid.rb", "test/path_checker_test.rb", "test/rails_app/Rakefile", "test/rails_app/app/active_record/admin.rb", "test/rails_app/app/active_record/shim.rb", "test/rails_app/app/active_record/user.rb", "test/rails_app/app/controllers/admins/sessions_controller.rb", "test/rails_app/app/controllers/admins_controller.rb", "test/rails_app/app/controllers/application_controller.rb", "test/rails_app/app/controllers/home_controller.rb", "test/rails_app/app/controllers/publisher/registrations_controller.rb", "test/rails_app/app/controllers/publisher/sessions_controller.rb", "test/rails_app/app/controllers/users/omniauth_callbacks_controller.rb", "test/rails_app/app/controllers/users_controller.rb", "test/rails_app/app/helpers/application_helper.rb", "test/rails_app/app/mailers/users/mailer.rb", "test/rails_app/app/mongoid/admin.rb", "test/rails_app/app/mongoid/shim.rb", "test/rails_app/app/mongoid/user.rb", "test/rails_app/app/views/admins/index.html.erb", "test/rails_app/app/views/admins/sessions/new.html.erb", "test/rails_app/app/views/home/admin_dashboard.html.erb", "test/rails_app/app/views/home/index.html.erb", "test/rails_app/app/views/home/join.html.erb", "test/rails_app/app/views/home/private.html.erb", "test/rails_app/app/views/home/user_dashboard.html.erb", "test/rails_app/app/views/layouts/application.html.erb", "test/rails_app/app/views/users/index.html.erb", "test/rails_app/app/views/users/mailer/confirmation_instructions.erb", "test/rails_app/app/views/users/sessions/new.html.erb", "test/rails_app/config.ru", "test/rails_app/config/application.rb", "test/rails_app/config/boot.rb", "test/rails_app/config/database.yml", "test/rails_app/config/environment.rb", "test/rails_app/config/environments/development.rb", "test/rails_app/config/environments/production.rb", "test/rails_app/config/environments/test.rb", "test/rails_app/config/initializers/backtrace_silencers.rb", "test/rails_app/config/initializers/devise.rb", "test/rails_app/config/initializers/inflections.rb", "test/rails_app/config/initializers/secret_token.rb", "test/rails_app/config/routes.rb", "test/rails_app/db/migrate/20100401102949_create_tables.rb", "test/rails_app/db/schema.rb", "test/rails_app/lib/shared_admin.rb", "test/rails_app/lib/shared_user.rb", "test/rails_app/public/404.html", "test/rails_app/public/422.html", "test/rails_app/public/500.html", "test/rails_app/public/favicon.ico", "test/rails_app/script/rails", "test/routes_test.rb", "test/schema_test.rb", "test/support/assertions.rb", "test/support/helpers.rb", "test/support/integration.rb", "test/support/locale/en.yml", "test/support/webrat/integrations/rails.rb", "test/test_helper.rb", "test/test_helpers_test.rb"]
  s.homepage = %q{http://github.com/plataformatec/devise}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{devise}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Flexible authentication solution for Rails with Warden}
  s.test_files = ["test/controllers/helpers_test.rb", "test/controllers/internal_helpers_test.rb", "test/controllers/sessions_controller_test.rb", "test/controllers/url_helpers_test.rb", "test/delegator_test.rb", "test/devise_test.rb", "test/encryptors_test.rb", "test/failure_app_test.rb", "test/generators/active_record_generator_test.rb", "test/generators/devise_generator_test.rb", "test/generators/install_generator_test.rb", "test/generators/mongoid_generator_test.rb", "test/generators/views_generator_test.rb", "test/helpers/devise_helper_test.rb", "test/indifferent_hash.rb", "test/integration/authenticatable_test.rb", "test/integration/confirmable_test.rb", "test/integration/database_authenticatable_test.rb", "test/integration/http_authenticatable_test.rb", "test/integration/lockable_test.rb", "test/integration/omniauthable_test.rb", "test/integration/recoverable_test.rb", "test/integration/registerable_test.rb", "test/integration/rememberable_test.rb", "test/integration/timeoutable_test.rb", "test/integration/token_authenticatable_test.rb", "test/integration/trackable_test.rb", "test/mailers/confirmation_instructions_test.rb", "test/mailers/reset_password_instructions_test.rb", "test/mailers/unlock_instructions_test.rb", "test/mapping_test.rb", "test/models/authenticatable_test.rb", "test/models/confirmable_test.rb", "test/models/database_authenticatable_test.rb", "test/models/encryptable_test.rb", "test/models/lockable_test.rb", "test/models/recoverable_test.rb", "test/models/rememberable_test.rb", "test/models/serializable_test.rb", "test/models/timeoutable_test.rb", "test/models/token_authenticatable_test.rb", "test/models/trackable_test.rb", "test/models/validatable_test.rb", "test/models_test.rb", "test/omniauth/config_test.rb", "test/omniauth/url_helpers_test.rb", "test/orm/active_record.rb", "test/orm/mongoid.rb", "test/path_checker_test.rb", "test/rails_app/Rakefile", "test/rails_app/app/active_record/admin.rb", "test/rails_app/app/active_record/shim.rb", "test/rails_app/app/active_record/user.rb", "test/rails_app/app/controllers/admins/sessions_controller.rb", "test/rails_app/app/controllers/admins_controller.rb", "test/rails_app/app/controllers/application_controller.rb", "test/rails_app/app/controllers/home_controller.rb", "test/rails_app/app/controllers/publisher/registrations_controller.rb", "test/rails_app/app/controllers/publisher/sessions_controller.rb", "test/rails_app/app/controllers/users/omniauth_callbacks_controller.rb", "test/rails_app/app/controllers/users_controller.rb", "test/rails_app/app/helpers/application_helper.rb", "test/rails_app/app/mailers/users/mailer.rb", "test/rails_app/app/mongoid/admin.rb", "test/rails_app/app/mongoid/shim.rb", "test/rails_app/app/mongoid/user.rb", "test/rails_app/app/views/admins/index.html.erb", "test/rails_app/app/views/admins/sessions/new.html.erb", "test/rails_app/app/views/home/admin_dashboard.html.erb", "test/rails_app/app/views/home/index.html.erb", "test/rails_app/app/views/home/join.html.erb", "test/rails_app/app/views/home/private.html.erb", "test/rails_app/app/views/home/user_dashboard.html.erb", "test/rails_app/app/views/layouts/application.html.erb", "test/rails_app/app/views/users/index.html.erb", "test/rails_app/app/views/users/mailer/confirmation_instructions.erb", "test/rails_app/app/views/users/sessions/new.html.erb", "test/rails_app/config.ru", "test/rails_app/config/application.rb", "test/rails_app/config/boot.rb", "test/rails_app/config/database.yml", "test/rails_app/config/environment.rb", "test/rails_app/config/environments/development.rb", "test/rails_app/config/environments/production.rb", "test/rails_app/config/environments/test.rb", "test/rails_app/config/initializers/backtrace_silencers.rb", "test/rails_app/config/initializers/devise.rb", "test/rails_app/config/initializers/inflections.rb", "test/rails_app/config/initializers/secret_token.rb", "test/rails_app/config/routes.rb", "test/rails_app/db/migrate/20100401102949_create_tables.rb", "test/rails_app/db/schema.rb", "test/rails_app/lib/shared_admin.rb", "test/rails_app/lib/shared_user.rb", "test/rails_app/public/404.html", "test/rails_app/public/422.html", "test/rails_app/public/500.html", "test/rails_app/public/favicon.ico", "test/rails_app/script/rails", "test/routes_test.rb", "test/schema_test.rb", "test/support/assertions.rb", "test/support/helpers.rb", "test/support/integration.rb", "test/support/locale/en.yml", "test/support/webrat/integrations/rails.rb", "test/test_helper.rb", "test/test_helpers_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<warden>, ["~> 1.1"])
      s.add_runtime_dependency(%q<orm_adapter>, ["~> 0.0.3"])
      s.add_runtime_dependency(%q<bcrypt-ruby>, ["~> 3.0"])
    else
      s.add_dependency(%q<warden>, ["~> 1.1"])
      s.add_dependency(%q<orm_adapter>, ["~> 0.0.3"])
      s.add_dependency(%q<bcrypt-ruby>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<warden>, ["~> 1.1"])
    s.add_dependency(%q<orm_adapter>, ["~> 0.0.3"])
    s.add_dependency(%q<bcrypt-ruby>, ["~> 3.0"])
  end
end
