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

  describe 'search functionality' do
    let!(:tag1) { create(:tag, name: 'allaitement', slug: 'allaitement') }
    let!(:tag2) { create(:tag, name: 'sommeil', slug: 'sommeil') }
    let!(:tag3) { create(:tag, name: 'nutrition', slug: 'nutrition') }

    let!(:article1) do
      create(
        :article,
        title: 'Techniques d\'allaitement',
        excerpt: 'Les meilleures positions pour nourrir bébé',
        published_at: 2.days.ago
      )
    end
    let!(:article2) do
      create(
        :article,
        title: 'Sommeil de bébé',
        excerpt: 'Comment établir une routine de sommeil',
        published_at: 1.day.ago
      )
    end
    let!(:article3) do
      create(
        :article,
        title: 'Alimentation diversifiée',
        excerpt: 'Introduction des solides à 6 mois',
        published_at: 3.days.ago
      )
    end

    before do
      article1.tags << tag1
      article2.tags << tag2
      article3.tags << tag3 << tag1
    end

    context 'when searching by title' do
      it 'returns articles matching the search term' do
        results = Article.search_full_text('allaitement')
        expect(results).to include(article1)
        expect(results).not_to include(article2)
      end

      it 'is accent insensitive' do
        results = Article.search_full_text('bebe')
        expect(results).to include(article2)
      end
    end

    context 'when searching by excerpt' do
      it 'returns articles with matching excerpts' do
        results = Article.search_full_text('positions')
        expect(results).to include(article1)
        expect(results).not_to include(article2, article3)
      end
    end

    context 'when searching by tag name' do
      it 'returns articles with matching tags' do
        results = Article.search_full_text('allaitement')
        expect(results).to include(article1, article3)
        expect(results).not_to include(article2)
      end
    end

    context 'when using trigram search' do
      it 'matches similar words with slight misspellings' do
        results = Article.search_full_text('someil')
        expect(results).to include(article2)
      end
    end

    context 'when ordering results' do
      it 'orders by published_at within rank' do
        results = Article.search_full_text('allaitement')
        expect(results.first).to eq(article1)
        expect(results.last).to eq(article3)
      end
    end
  end
end
