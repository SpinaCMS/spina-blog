require 'rails_helper'

RSpec.feature "Admin Posts", type: :feature do

  describe 'listing posts' do
    let!(:posts) { create_list(:spina_blog_post, 3, published_at: Date.today + 1) }
    before { sign_in }

    it 'shows all the posts' do
      visit '/admin/blog/posts'
      expect(page).to have_css 'tbody tr', count: 3
    end
  end
end
