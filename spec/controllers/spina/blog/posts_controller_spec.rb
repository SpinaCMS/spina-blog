require 'rails_helper'

RSpec.describe Spina::Blog::PostsController, type: :controller do
  let!(:account) { ::Spina::Account.create name: 'MySite', theme: 'default' }

  routes { Spina::Engine.routes }

  let(:draft_past_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: true, published_at: Date.today - 10 }
  let(:live_past_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: false, published_at: Date.today - 10 }
  let(:live_future_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: false, published_at: Date.today + 10 }

  describe 'GET #index' do
    subject { get :index }

    before do
      draft_past_posts
      live_past_posts
      live_future_posts
    end

    it {
      subject
      expect(assigns(:posts)).to match_array live_past_posts
    }

    # context 'when signed in' do
    #   before { sign_in }
    #
    #   it {
    #     subject
    #     expect(assigns(:posts)).to match_array(draft_past_posts + live_past_posts)
    #   }
    # end
  end

  describe 'GET #show' do
    let(:blog_post) { FactoryGirl.create :spina_blog_post }

    subject { get :show, params: { id: blog_post.id } }

    it {
      subject
      expect(assigns(:post)).to eq blog_post
    }
    it { is_expected.to render_template :show }
    it { is_expected.to have_http_status :success }
  end

  describe 'GET #archive' do
    context 'with a year' do
      let(:this_year_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: false, published_at: Date.today.beginning_of_year }
      let(:last_year_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: false, published_at: Date.today.beginning_of_year - 1 }

      before do
        this_year_posts
        last_year_posts
      end

      subject { get :archive, params: { year: Date.today.year } }

      it {
        subject
        expect(assigns(:posts)).to match_array this_year_posts
      }
    end

    context 'with a year and a month' do
      let(:this_month_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: false, published_at: Date.today.beginning_of_month }
      let(:last_month_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: false, published_at: Date.today.beginning_of_month - 1 }

      before do
        this_month_posts
        last_month_posts
      end

      subject { get :archive, params: { year: Date.today.year, month: Date.today.month } }

      it {
        subject
        expect(assigns(:posts)).to match_array this_month_posts
      }
    end
  end
end
