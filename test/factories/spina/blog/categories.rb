FactoryGirl.define do
  factory :spina_blog_category, class: Spina::Blog::Category do
    sequence(:name) { |n| "Category #{n}" }
  end
end
