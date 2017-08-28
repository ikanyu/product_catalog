class CatalogsController < ApplicationController
  def index
    category_ids = ProductCategory.pluck(:category_id).uniq
    product_ids = ProductCategory.pluck(:product_id)

    @categories = Category.where(id: category_ids)
    @products = Product.where(id: product_ids)
  end

  def show
    category_ids = ProductCategory.pluck(:category_id).uniq

    category = Category.find(params[:id])

    result_ids = category.self_and_descendants.pluck(:id)

    @categories = Category.where(id: category_ids)
    @product_categories = ProductCategory.where(category_id: result_ids)
  end
end
