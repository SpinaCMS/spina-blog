# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::PostDecorator
    class PostDecorator < Draper::Decorator
      delegate_all

      def published_date
        l model.published_at.to_date, format: :long
      end

      def word_count
        h.strip_tags(content).split.size
      end

      def image_count
        Nokogiri::HTML(content).css('img').size
      end

      def read_time
        ((word_count / (275 / 60.to_f) + (image_count * 12)) / 60).ceil
      end
    end
  end
end
