# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spina::Blog::PostsController, type: :controller do
  let!(:account) { ::Spina::Account.create name: 'MySite', theme: 'default' }

  routes { Spina::Engine.routes }

  let(:draft_past_posts) do
    create_list :spina_blog_post, 3, draft: true,
                                     published_at: Time.zone.today - 10
  end
  let(:live_past_posts) do
    create_list :spina_blog_post, 3, draft: false,
                                     published_at: Time.zone.today - 10
  end
  let(:live_future_posts) do
    create_list :spina_blog_post, 3, draft: false,
                                     published_at: Time.zone.today + 10
  end

  describe 'GET #index' do
    subject { get :index }

    before do
      draft_past_posts
      live_past_posts
      live_future_posts
    end

    it do
      subject
      expect(assigns(:posts)).to match_array live_past_posts
    end
  end

  describe 'GET #show' do
    let(:blog_post) { create(:spina_blog_post) }

    subject { get :show, params: { id: blog_post.id } }

    it {
      subject
      expect(assigns(:post)).to eq blog_post
    }
    it { is_expected.to render_template :show }
    it { is_expected.to be_successful }
  end

  describe 'GET #archive' do
    context 'with a year' do
      let(:this_year_posts) do
        create_list :spina_blog_post, 3,
                    draft: false, published_at: Time.zone.today.beginning_of_year
      end
      let(:last_year_posts) do
        create_list :spina_blog_post, 3,
                    draft: false,
                    published_at: Time.zone.today.beginning_of_year - 1
      end
      before do
        this_year_posts
        last_year_posts
      end

      subject { get :archive, params: { year: Time.zone.today.year } }

      it {
        subject
        expect(assigns(:posts)).to match_array this_year_posts
      }
    end

    context 'with a year and a month' do
      let(:this_month_posts) { create_list(:spina_blog_post, 3, draft: false, published_at: Time.zone.today.beginning_of_month) }
      let(:last_month_posts) { create_list(:spina_blog_post, 3, draft: false, published_at: Time.zone.today.beginning_of_month - 1) }

      before do
        this_month_posts
        last_month_posts
      end

      subject { get :archive, params: { year: Time.zone.today.year, month: Time.zone.today.month } }

      it {
        subject
        expect(assigns(:posts)).to match_array this_month_posts
      }
    end
  end
end
