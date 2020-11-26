# frozen_string_literal: true

module SpinaBlog
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def create_initializer_file
      return if Rails.env.production?

      template 'config/initializers/spina_blog.rb'
    end

    def copy_migrations
      return if Rails.env.production?

      rake 'spina_blog:install:migrations'
    end

    def run_migrations
      rake 'db:migrate'
    end

    def feedback
      puts
      puts '    Spina Blog has been succesfully installed! '
      puts
      puts '    Restart your server and visit http://localhost:3000 in your browser!'
      puts "    The admin backend is located at http://localhost:3000/#{Spina.config.backend_path}."
      puts
    end
  end
end
