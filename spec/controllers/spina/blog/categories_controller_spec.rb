require 'rails_helper'

RSpec.describe Spina::Blog::CategoriesController, type: :controller do
  routes { Spina::Engine.routes }

  let(:category) { create(:spina_blog_category) }
  let(:other_category_posts) { create_list(:spina_blog_post, 3, draft: false, published_at: Date.today - 10) }
  let(:draft_past_posts) { create_list(:spina_blog_post, 3, draft: true, published_at: Date.today - 10, category: category) }
  let(:live_past_posts) { create_list(:spina_blog_post, 3, draft: false, published_at: Date.today - 10, category: category) }
  let(:live_future_posts) { create_list(:spina_blog_post, 3, draft: false, published_at: Date.today + 10, category: category) }

  describe 'GET #show' do
    subject { get :show, params: { id: category.id } }

    before do
      other_category_posts
      draft_past_posts
      live_past_posts
      live_future_posts
    end

    it {
      subject
      expect(assigns(:posts)).to match_array live_past_posts
    }
    it { is_expected.to render_template :show }
    it { is_expected.to be_successful }
  end
end
