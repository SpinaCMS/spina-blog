# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Admin Posts', type: :system do
  before { sign_in }

  describe 'listing posts' do
    let!(:posts) { create_list(:spina_blog_post, 3, published_at: Date.today + 1) }

    it 'shows all the posts' do
      visit '/admin/blog/posts'
      expect(page).to have_content "Blog Post"
    end
  end

  describe 'creating a post' do
    it 'creates a post', js: true do
      visit '/admin/blog/posts'
      find(:css, 'a[href="/admin/blog/posts/new"]').click
      fill_in 'Post title', with: 'Title of Blog post'
      find(
        :css, 'trix-editor[input*="content_input"]'
      ).set('Foobar')
      click_on 'Save post'
      within 'nav[data-controller="navigation"]' do
        click_on 'Posts'
      end
      expect(page).to have_content 'Title of Blog post'
    end
  end
end
