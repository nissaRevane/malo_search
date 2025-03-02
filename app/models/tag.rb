class Tag < ApplicationRecord
  validates :slug, uniqueness: true
end
