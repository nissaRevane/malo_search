require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    let!(:article) { create(:article) }

    it 'validates uniqueness of slug' do
      article_unique = build(:article, uuid: SecureRandom.uuid)
      article_not_unique = build(:article, uuid: article.uuid)

      expect(article_unique).to be_valid
      expect(article_not_unique).not_to be_valid
    end
  end
end
