# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::PostDecorator
    class PostDecorator < Draper::Decorator
      def published_date
        l model.published_at, format: :long
      end
    end
  end
end
