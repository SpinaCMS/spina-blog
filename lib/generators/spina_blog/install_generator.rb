module SpinaBlog
  class InstallGenerator < Rails::Generators::Base

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
