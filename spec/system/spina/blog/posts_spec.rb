# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Posts', type: :system do
  let!(:account) { ::Spina::Account.create name: 'MySite', theme: 'default' }

  describe 'listing posts' do
    let!(:posts) { create_list(:spina_blog_post, 3, draft: false, published_at: Date.today - 1) }

    it 'shows all the posts' do
      visit '/blog'
      expect(page).to have_css 'li.post', count: 3
    end

    context 'using the atom format' do
      it 'shows the atom feed' do
        visit '/blog.atom'
        expect(page).to have_xpath '//entry', count: 3
      end
    end
  end

  describe 'listing archived posts' do
    let!(:last_year_posts) { create_list(:spina_blog_post, 3, draft: false, published_at: Date.today.beginning_of_year - 1) }

    context 'with a year' do
      it 'shows all the posts' do
        visit "/blog/archive/#{Date.today.year - 1}"
        expect(page).to have_content(Date.today.year - 1)
        expect(page).to have_css 'li.post', count: 3
      end
    end

    context 'with a year and month' do
      it 'shows all the posts' do
        visit "/blog/archive/#{Date.today.year - 1}/12"
        expect(page).to have_content "December #{Date.today.year - 1}"
        expect(page).to have_css 'li.post', count: 3
      end
    end
  end

  describe 'showing a post' do
    let!(:post) { create(:spina_blog_post) }

    it 'shows the post' do
      visit "/blog/posts/#{post.slug}"
      expect(page).to have_css 'h1', text: post.title
      expect(page).to have_content post.content
    end
  end
end
