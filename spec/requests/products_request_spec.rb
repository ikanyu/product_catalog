require 'rails_helper'

describe "Products page request" do
  it "displays all products #index" do
    product = create(:product)

    get products_path

    expect(response).to have_http_status :ok
    expect(response.body).to include product.name
  end

  it "displays form #new" do
    get new_product_path

    expect(response).to have_http_status :ok
  end

  it "displays product details #show" do
    product = create(:product)

    get product_path(product.id)

    expect(response).to have_http_status :ok
  end

  it "creates product #create" do
    category = create(:category)

    post products_path, params: {
      product: {
        name: "abc",
        description: "abc description",
        price: 13.50,
        category: category.id
      }
    }

    expect(Product.first.name).to eq "abc"
  end

  it "updates product #update" do
    category = create(:category)
    product = create(:product)

    put product_path(product.id), params: {
      product: {
        name: "new name",
        category: category.id
      }
    }

    expect(product.reload.name).to eq "new name"
    expect(product.category).to eq category
  end

  it "deletes product #destroy" do
    create(:category)
    product = create(:product)

    delete product_path(product.id)

    expect(Product.count).to eq 0
    expect(Category.count).to eq 1
  end
end
