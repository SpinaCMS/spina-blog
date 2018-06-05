# desc "Explaining what the task does"
# task :spina_blog do
#   # Task goes here
# end

namespace :spina_blog do
  task photo_to_image: :environment do
    Blog::Post.find_each do |post|
      post.update_column :image_id, post.photo.image_id
    end
  end
end
