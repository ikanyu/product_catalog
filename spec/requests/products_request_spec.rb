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

  describe "displays product details #show" do
    it "does not have category" do
      category = create(:category)
      product = create(:product, category: category)

      get product_path(product)

      expect(response).to have_http_status :ok
    end

    it "has category" do
      product = create(:product)

      get product_path(product)

      expect(response).to have_http_status :ok
    end
  end

  describe "creates product #create" do
    it "successfully" do
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
      expect(response).to have_http_status 302

      follow_redirect!

      expect(response).to have_http_status :success
    end

    it "unsuccessfully" do
      category = create(:category)

      post products_path, params: {
        product: {
          name: "abc",
          description: "",
          category: category.id
        }
      }

      expect(Product.count).to eq 0
      expect(response).to have_http_status :ok
    end
  end

  describe "updates product #update" do
    it "successfully" do
      category = create(:category)
      product = create(:product)

      put product_path(product.id), params: {
        product: {
          name: "new name",
          category_id: category.id
        }
      }

      expect(product.reload.name).to eq "new name"
      expect(product.category).to eq category
    end

    it "unsuccessfully" do
      category = create(:category)
      product = create(:product)
      product_name = product.name

      put product_path(product.id), params: {
        product: {
          name: nil,
          price: nil,
          category_id: category.id
        }
      }

      expect(product.reload.name).to eq product_name
      expect(response).to have_http_status :ok
    end
  end

  it "deletes product #destroy" do
    create(:category)
    product = create(:product)

    delete product_path(product.id)

    expect(Product.count).to eq 0
    expect(Category.count).to eq 1
  end

  it "displays form #edit" do
    product = create(:product)
    get edit_product_path(product)

    expect(response).to have_http_status :ok
  end
end
