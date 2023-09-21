module Spina
  module Blog
    class ArchivedPostsWidgetComponent < Spina::ApplicationComponent

      PostsYear = Struct.new(
        :year,
        :count,
        keyword_init: true
      ) do
        include Spina::Engine.routes.url_helpers

        def path
          blog_archive_posts_path(year)
        end

      end

      def initialize
        @posts_years =
          ActiveRecord::Base.connection.execute(query).map do |result|
            PostsYear.new(year: result['published_at_year'], count: result['count'])
          end
      end

      def query
        <<~SQL
        select cast(extract('Year' from published_at) as text) as published_at_year, count(extract('Year' from published_at))
        from spina_blog_posts
        where draft=false
        group by published_at_year
        SQL
      end

    end
  end
end
