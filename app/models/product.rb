class Product < ApplicationRecord
  belongs_to :category, optional: true

  validates :name, presence: true
  validates :price, presence: true
end
