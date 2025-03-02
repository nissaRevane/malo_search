require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    let!(:tag) { create(:tag) }

    it 'validates uniqueness of slug' do
      tag_unique = build(:tag, slug: 'UniqueSlug')
      tag_not_unique = build(:tag, slug: tag.slug)

      expect(tag_unique).to be_valid
      expect(tag_not_unique).not_to be_valid
    end
  end
end
