class CatalogsController < ApplicationController
  def index
    if params[:id].nil?
      @categories = Category.where(id: category_ids_with_product)
      @products = Product.all
    else
      category = Category.find(params[:id])
      result_ids = category.self_and_descendants.pluck(:id)

      @categories = Category.where(id: category_ids_with_product)
      @products = Product.where(category_id: result_ids)
    end
  end

  private

  def category_ids_with_product
    category_ids = Category.pluck(:id)
    product_category_ids = Product.pluck(:category_id).uniq

    category_ids & product_category_ids
  end
end
