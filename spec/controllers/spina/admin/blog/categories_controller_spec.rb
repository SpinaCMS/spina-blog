require 'rails_helper'

RSpec.describe Spina::Admin::Blog::CategoriesController, type: :controller do
  let(:categories) { FactoryGirl.create_list :spina_blog_category, 3 }
  let(:category) { FactoryGirl.create :spina_blog_category }
  let(:category_attributes) { FactoryGirl.attributes_for :spina_blog_category }

  routes { Spina::Engine.routes }

  context 'signed in as an admin' do
    before { sign_in }

    describe 'GET #index' do
      subject { get :index }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:categories)).to match_array categories
      }
    end

    describe 'GET #new' do
      subject { get :new }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :new }
    end

    describe 'POST #create' do
      subject { post :create, params: { category: category_attributes } }

      it { is_expected.to have_http_status :redirect }
      it {
        subject
        expect(flash[:notice]).to eq 'Category saved'
      }
      it { expect{subject}.to change(Spina::Blog::Category, :count).by(1) }

      context 'with invalid attributes' do
        subject { post :create, params: { category: { name: '' } } }

        it { is_expected.to_not have_http_status :redirect }
        it { expect{subject}.to_not change(Spina::Blog::Category, :count) }
        it { is_expected.to render_template :new }
      end
    end

    describe 'GET #edit' do
      subject { get :edit, params: { id: category.id } }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :edit }
    end

    describe 'PATCH #update' do
      subject { patch :update, params: { id: category.id, category: category_attributes } }

      it { is_expected.to have_http_status :redirect }
      it {
        subject
        expect(flash[:notice]).to eq 'Category saved'
      }
      it { expect{subject}.to change{category.reload.name} }

      context 'with invalid attributes' do
        subject { patch :update, params: { id: category.id, category: { name: '' } } }

        it { is_expected.to_not have_http_status :redirect }
        it { is_expected.to render_template :edit }
        it { expect{subject}.to_not change{category.reload.name} }
      end
    end

    describe 'DELETE #destroy' do
      let!(:category) { FactoryGirl.create :spina_blog_category }

      subject { delete :destroy, params: { id: category.id } }

      it { expect{subject}.to change(Spina::Blog::Category, :count).by(-1) }
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
