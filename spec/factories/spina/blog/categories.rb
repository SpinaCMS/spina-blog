# frozen_string_literal: true

FactoryBot.define do
  factory :spina_blog_category, class: Spina::Blog::Category do
    sequence(:name) { |n| "Category #{n}" }

    factory :invalid_spina_blog_category do
      name { nil }
    end
  end
end
