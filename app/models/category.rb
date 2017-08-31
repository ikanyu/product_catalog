class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true

  acts_as_nested_set
end
