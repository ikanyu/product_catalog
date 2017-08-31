require "rails_helper"

describe Product do
  describe "name" do
    it { should validate_presence_of(:name) }
  end

  describe "price" do
    it { should validate_presence_of(:price) }
  end

  describe "category" do
    it { should belong_to(:category) }
  end
end

