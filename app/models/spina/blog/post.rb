# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::Post
    class Post < ApplicationRecord
      extend FriendlyId

      friendly_id :title, use: :slugged

      belongs_to :image, optional: true,  class_name: 'Spina::Image'

      belongs_to :user
      belongs_to :category, inverse_of: :posts

      validates :title, :content, presence: true

      before_save :set_published_at

      # Create a 301 redirect if the slug changed
      after_save :rewrite_rule, if: -> { saved_change_to_slug? }, on: :update

      scope :available, -> { where('published_at <= ?', Time.zone.now) }
      scope :future, -> { where('published_at >= ?', Time.zone.now) }
      scope :draft, -> { where(draft: true) }
      scope :live, -> { where(draft: false) }
      scope :featured, -> { where(featured: true) }
      scope :unfeatured, -> { where(featured: false) }

      private

      def set_published_at
        self.published_at = Time.now if !draft? && published_at.blank?
      end

      def should_generate_new_friendly_id?
        slug.blank? || draft_changed? || super
      end

      def rewrite_rule
        ::Spina::RewriteRule.create(
          old_path: "/blog/posts/#{slug_before_last_save}",
          new_path: "/blog/posts/#{slug}"
        )
      end
    end
  end
end
