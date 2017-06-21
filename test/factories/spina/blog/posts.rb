FactoryGirl.define do
  factory :spina_blog_post, class: Spina::Blog::Post do
    sequence(:title) { |n| "Blog Post #{n}" }
    content "Some content for my post"
  end
end
