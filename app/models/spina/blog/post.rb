require_dependency 'spina/blog'

module Spina
  class Blog::Post < ApplicationRecord
    extend FriendlyId

    friendly_id :title, use: :slugged

    belongs_to :photo
    belongs_to :spina_user, class_name: 'Spina::User'
    belongs_to :category, class_name: 'Spina::Blog::Category', inverse_of: :posts

    validates :title, :content, presence: true

    before_save :set_published_at

    scope :available, -> { where('published_at <= ?', Time.zone.now) }
    scope :future, -> { where('published_at >= ?', Time.zone.now) }
    scope :draft, -> { where(draft: true) }
    scope :live, -> { where(draft: false) }

    private

    def set_published_at
      self.published_at = Time.now if !draft? and published_at.blank?
    end

    def should_generate_new_friendly_id?
      slug.blank? || draft_changed? || super
    end
  end
end
