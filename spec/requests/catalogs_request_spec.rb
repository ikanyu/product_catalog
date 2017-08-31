require 'rails_helper'

describe "Products page request" do
  it "displays all products #index when no id is provided" do
    category = create(:category)
    product = create(:product, category: category)

    get catalogs_path

    expect(response).to have_http_status :ok
    expect(response.body).to include product.name
    expect(response.body).to include category.name
  end

  it "displays product with category_id procided" do
    category = create(:category)
    product = create(:product, category: category)
    product1 = create(:product, name: "Soap")

    get catalogs_path(category)

    expect(response).to have_http_status :ok
    expect(response.body).to include product.name
    expect(response.body).to_not include product1.name
    expect(response.body).to include category.name
  end
end
