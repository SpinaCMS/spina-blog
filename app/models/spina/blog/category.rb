require_dependency 'spina/blog'

module Spina
  class Blog::Category < ApplicationRecord
    extend FriendlyId

    friendly_id :name, use: :slugged

    has_many :posts, class_name: 'Spina::Blog::Post', inverse_of: :category
    validates :name, presence: true
  end
end
