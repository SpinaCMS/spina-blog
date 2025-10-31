# frozen_string_literal: true

require 'rails_helper'

module Spina
  module Blog
    RSpec.describe Post, type: :model do
      let(:post) { build(:spina_blog_post) }

      subject { post }

      it { is_expected.to be_valid }
      it { expect { post.save }.to change(Spina::Blog::Post, :count).by(1) }

      context 'with invalid attributes' do
        let(:post) { build(:invalid_spina_blog_post) }

        it { is_expected.to_not be_valid }
        it { expect { post.save }.to_not change(Spina::Blog::Post, :count) }
      end

      describe '.featured' do
        let!(:post) { create(:spina_blog_post, featured: true) }
        let!(:unfeatured) { create(:spina_blog_post) }

        it 'returns 1 result' do
          expect(Spina::Blog::Post.featured).to match_array [post]
        end
      end

      describe '.unfeatured' do
        let!(:post) { create(:spina_blog_post, featured: true) }
        let!(:unfeatured) { create(:spina_blog_post) }

        it 'returns 1 result' do
          expect(Spina::Blog::Post.unfeatured).to match_array [unfeatured]
        end
      end
    end
  end
end
