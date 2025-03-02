class Article < ApplicationRecord
  has_and_belongs_to_many :tags

  validates :uuid, uniqueness: true

  include PgSearch::Model

  pg_search_scope :search_full_text,
                  against: [ :title, :excerpt ],
                  associated_against: {
                    tags: [ :name ]
                  },
                  using: {
                    tsearch: {
                      dictionary: "french"
                    },
                    trigram: { threshold: 0.1 }
                  },
                  order_within_rank: "articles.published_at DESC",
                  ignoring: :accents
end
