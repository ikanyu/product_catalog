class Product < ApplicationRecord
  has_one :product_category
  has_one :category, through: :product_category

  validates_presence_of :name, :price
end
