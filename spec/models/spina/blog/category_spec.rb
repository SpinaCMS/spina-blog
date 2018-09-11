require 'rails_helper'

module Spina::Blog
  RSpec.describe Category, type: :model do
    let(:category) { build(:spina_blog_category) }

    subject { category }

    it { is_expected.to be_valid }
    it { expect{category.save}.to change(Spina::Blog::Category, :count).by(1) }

    context 'with invalid attributes' do
      let(:category) { build(:invalid_spina_blog_category) }

      it { is_expected.to_not be_valid }
      it { expect{category.save}.to_not change(Spina::Blog::Category, :count) }
    end
  end
end
