class Product < ApplicationRecord
  belongs_to :category, optional: true

  validates_presence_of :name, :price
end
