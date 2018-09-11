require 'rails_helper'

RSpec.describe Spina::Admin::Blog::PostsController, type: :controller do
  let(:posts) { FactoryGirl.create_list :spina_blog_post, 3 }
  let(:blog_post) { FactoryGirl.create :spina_blog_post }
  let(:draft_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: true }
  let(:live_posts) { FactoryGirl.create_list :spina_blog_post, 3, draft: false }
  let(:post_attributes) { FactoryGirl.attributes_for :spina_blog_post }

  routes { Spina::Engine.routes }

  context 'signed in as an admin' do
    before { sign_in }

    describe 'GET #index' do
      subject { get :index }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:posts)).to match_array posts
      }
    end

    describe 'GET #live' do
      subject { get :live }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:posts)).to match_array live_posts
      }
      it {
        subject
        expect(assigns(:posts)).to_not match_array draft_posts
      }
    end

    describe 'GET #draft' do
      subject { get :draft }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:posts)).to match_array draft_posts
      }
      it {
        subject
        expect(assigns(:posts)).to_not match_array live_posts
      }
    end

    describe 'GET #future' do
      let(:past_posts) { FactoryGirl.create_list :spina_blog_post, 3, published_at: Date.today - 10 }
      let(:future_posts) { FactoryGirl.create_list :spina_blog_post, 3, published_at: Date.today + 10 }

      subject { get :future }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:posts)).to match_array future_posts
      }
      it {
        subject
        expect(assigns(:posts)).to_not match_array past_posts
      }
    end

    describe 'GET #new' do
      subject { get :new }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :new }
    end

    describe 'POST #create' do
      subject { post :create, params: { post: post_attributes } }

      it { is_expected.to have_http_status :redirect }
      it {
        subject
        expect(flash[:notice]).to eq 'Post saved'
      }
      it { expect{subject}.to change(Spina::Blog::Post, :count).by(1) }

      context 'with invalid attributes' do
        subject { post :create, params: { post: { content: 'foo' } } }

        it { is_expected.to_not have_http_status :redirect }
        it { expect{subject}.to_not change(Spina::Blog::Post, :count) }
        it { is_expected.to render_template :new }
      end
    end

    describe 'GET #edit' do
      subject { get :edit, params: { id: blog_post.id } }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :edit }
    end

    describe 'PATCH #update' do
      subject { patch :update, params: { id: blog_post.id, post: post_attributes } }

      it { is_expected.to have_http_status :redirect }
      it {
        subject
        expect(flash[:notice]).to eq 'Post saved'
      }
      it { expect{subject}.to change{blog_post.reload.title} }

      context 'with invalid attributes' do
        subject { patch :update, params: { id: blog_post.id, post: { title: '' } } }

        it { is_expected.to_not have_http_status :redirect }
        it { is_expected.to render_template :edit }
        it { expect{subject}.to_not change{blog_post.reload.title} }
      end
    end

    describe 'DELETE #destroy' do
      let!(:blog_post) { FactoryGirl.create :spina_blog_post }

      subject { delete :destroy, params: { id: blog_post.id } }

      it { expect{subject}.to change(Spina::Blog::Post, :count).by(-1) }
    end
  end

  context 'signed out' do
    describe 'GET #index' do
      subject { get :index }
      it { is_expected.to have_http_status :redirect }
      it { is_expected.to_not render_template :index }
    end
  end
end
