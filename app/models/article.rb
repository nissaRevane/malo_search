class Article < ApplicationRecord
  has_and_belongs_to_many :tags

  validates :uuid, uniqueness: true
end
