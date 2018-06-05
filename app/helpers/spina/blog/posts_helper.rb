# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::PostsHelper
    module PostsHelper
      def formatted_date(year, month)
        if month
          date = Date.new year.to_i, month.to_i
          date.strftime('%B %Y')
        else
          date = Date.new year.to_i
          date.strftime('%Y')
        end
      end
    end
  end
end
