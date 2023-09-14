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
          Spina::Blog::Post
            .live
            .pluck(:published_at)
            .map(&:year)
            .tally
            .map do |year, count|
              PostsYear.new(year: year, count: count)
            end
      end

    end
  end
end
