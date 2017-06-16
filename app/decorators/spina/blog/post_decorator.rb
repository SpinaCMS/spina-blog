module Spina
  class Blog::PostDecorator < Draper::Decorator

    def published_date
      l model.published_at, format: :long
    end
  end
end
