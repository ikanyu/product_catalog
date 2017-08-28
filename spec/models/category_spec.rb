require "rails_helper"

describe Category do
  describe "name" do
    it { should validate_presence_of(:name) }
  end

  describe "products" do
    it { should have_many(:product_categories).dependent(:destroy) }
  end

  describe "product_categories" do
    it { should have_many(:products).through(:product_categories) }
  end
end
