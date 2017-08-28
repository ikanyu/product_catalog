require "rails_helper"

describe Product do
  describe "name" do
    it { should validate_presence_of(:name) }
  end

  describe "price" do
    it { should validate_presence_of(:price) }
  end

  describe "product_category" do
    it { should have_one(:product_category) }
  end

  describe "category" do
    it { should have_one(:category).through(:product_category) }
  end
end

