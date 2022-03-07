# frozen_string_literal: true

FactoryBot.define do
  factory :spina_blog_post, class: Spina::Blog::Post do
    sequence(:title) { |n| "Blog Post #{n}" }
    content { 'Some content for my post' }
    association :category, factory: :spina_blog_category
    association :user, factory: :spina_user

    seo_title { 'Some title for SEO' }
    description { 'Some description for SEO' }

    factory :invalid_spina_blog_post do
      title       { nil }
      content     { nil }
      user_id     { nil }
      category_id { nil }
    end
  end
end
