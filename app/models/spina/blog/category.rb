require_dependency 'spina/blog'

module Spina
  class Blog::Category < ApplicationRecord
    validates :name, presence: true
  end
end
