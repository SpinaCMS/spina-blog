# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::Category
    class Category < ApplicationRecord
      extend FriendlyId

      friendly_id :name, use: :slugged

      has_many :posts, class_name: 'Spina::Blog::Post', inverse_of: :category
      validates :name, presence: true

      def to_s
        name
      end
    end
  end
end
