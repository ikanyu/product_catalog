require "rails_helper"

describe Category do
  describe "name" do
    it { should validate_presence_of(:name) }
  end

  describe "products" do
    it { should have_many(:products) }
  end
end
