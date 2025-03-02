require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /search" do
    let!(:article1) do
      create(:article, title: "Techniques pour allaitement", excerpt: "Les meilleures positions pour nourrir bébé")
    end
    let!(:article2) do
      create(:article, title: "Sommeil de bébé", excerpt: "Comment établir une routine de sommeil")
    end
    let!(:article3) do
      create(:article, title: "Alimentation diversifiée", excerpt: "Introduction des solides à 6 mois")
    end
    let!(:article4) do
      create(:article, title: "Poussées dentaires", excerpt: "Soulager les douleurs des premières dents")
    end

    let!(:tag1) { create(:tag, name: "allaitement", slug: "allaitement") }
    let!(:tag2) { create(:tag, name: "sommeil", slug: "sommeil") }

    before do
      article1.tags << tag1
      article2.tags << tag2
    end

    it "returns the last 3 articles" do
      get "/"

      expect(response).to have_http_status(200)
      expect(response.body).not_to include(article1.title)
      expect(response.body).to include(article2.title)
      expect(response.body).to include(article3.title)
      expect(response.body).to include(article4.title)
    end
  end
end
