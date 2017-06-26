module Spina
  module Blog
    module PostsHelper
      def formatted_date(year, month)
        if month
          date = Date.new year.to_i, month.to_i
          return date.strftime("%B %Y")
        else
          date = Date.new year.to_i
          return date.strftime("%Y")
        end
      end
    end
  end
end
