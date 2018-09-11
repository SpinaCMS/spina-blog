require 'rails_helper'

module Spina::Blog
  RSpec.describe Post, type: :model do
    let(:post) { build(:spina_blog_post) }

    subject { post }

    it { is_expected.to be_valid }
    it { expect{post.save}.to change(Spina::Blog::Post, :count).by(1) }

    context 'with invalid attributes' do
      let(:post) { build(:invalid_spina_blog_post) }

      it { is_expected.to_not be_valid }
      it { expect{post.save}.to_not change(Spina::Blog::Post, :count) }
    end
  end
end
