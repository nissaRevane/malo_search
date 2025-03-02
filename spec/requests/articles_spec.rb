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

    context "when a search query is provided" do
      it "returns articles matching the query in the title" do
        get "/articles/search", params: { query: "allaitement" }

        expect(response).to have_http_status(200)
        expect(response.body).to include(article1.title)
        expect(response.body).not_to include(article2.title)
        expect(response.body).not_to include(article3.title)
        expect(response.body).not_to include(article4.title)
      end

      it "returns articles matching the query in the excerpt" do
        get "/articles/search", params: { query: "routine" }

        expect(response).to have_http_status(200)
        expect(response.body).to include(article2.title)
        expect(response.body).not_to include(article1.title)
        expect(response.body).not_to include(article3.title)
        expect(response.body).not_to include(article4.title)
      end

      it "returns articles matching the query in tags" do
        get "/articles/search", params: { query: "sommeil" }

        expect(response).to have_http_status(200)
        expect(response.body).to include(article2.title)
        expect(response.body).not_to include(article1.title)
        expect(response.body).not_to include(article3.title)
        expect(response.body).not_to include(article4.title)
      end

      it "returns articles with similar words using trigram search" do
        get "/articles/search", params: { query: "alaitment" }

        expect(response).to have_http_status(200)
        expect(response.body).to include(article1.title)
      end

      it "returns empty results when no matches found" do
        get "/articles/search", params: { query: "vacances" }

        expect(response).to have_http_status(200)
        expect(response.body).not_to include(article1.title)
        expect(response.body).not_to include(article2.title)
        expect(response.body).not_to include(article3.title)
        expect(response.body).not_to include(article4.title)
      end
    end

    context "when no search query is provided" do
      it "returns the last 3 articles" do
        get "/articles/search"

        expect(response).to have_http_status(200)
        expect(response.body).not_to include(article1.title)
        expect(response.body).to include(article2.title)
        expect(response.body).to include(article3.title)
        expect(response.body).to include(article4.title)
      end

      it "returns the last 3 articles when query is empty" do
        get "/articles/search", params: { query: "" }

        expect(response).to have_http_status(200)
        expect(response.body).not_to include(article1.title)
        expect(response.body).to include(article2.title)
        expect(response.body).to include(article3.title)
        expect(response.body).to include(article4.title)
      end
    end
  end
end
