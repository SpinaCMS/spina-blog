# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Admin Posts', type: :system do
  before { sign_in }

  describe 'listing posts' do
    let!(:posts) { create_list(:spina_blog_post, 3, published_at: Date.today + 1) }

    it 'shows all the posts' do
      visit '/admin/blog/posts'
      expect(page).to have_css 'tbody tr', count: 3
    end
  end

  describe 'creating a post' do
    it 'creates a post', js: true do
      visit '/admin/blog/posts'
      click_on 'New Post'
      fill_in 'Post title', with: 'Title of Blog post'
      find(
        :css, 'trix-editor[input*="content_input"]'
      ).set('Foobar')
      click_on 'Save post'
      within '#header' do
        click_on 'Posts'
      end
      within 'tbody' do
        expect(page).to have_content 'Title of Blog post'
      end
    end
  end
end
