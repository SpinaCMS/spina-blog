require 'test_helper'

module Spina
  class Blog::CategoryTest < ActiveSupport::TestCase

    test 'should not save without name' do
      category = Blog::Category.new
      assert_not category.save
    end

    test 'creates a new category with valid attributes' do
      category = build :spina_blog_category
      assert category.save
    end
  end
end
