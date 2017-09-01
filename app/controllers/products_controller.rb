class ProductsController < ApplicationController
  def index
    @products = Product.all

    @category = CategoryPresenter.new(new)
  end

  def new
    @product = Product.new
    @category = CategoryPresenter.new(Category.new)
  end

  def create
    @product = Product.new(product_params)
    @category = CategoryPresenter.new(Category.new)

    if @product.save
      redirect_to @product, flash: { success: "Product created" }
    else
      @product = CategoryPresenter.new(@product)

      render "new"
    end
  end

  def show
    @product = Product.find(params[:id])

    @category = if @product.category.present?
                  CategoryPresenter.new(@product.category)
                end
  end

  def edit
    @product = Product.find(params[:id])
    @category = CategoryPresenter.new(Category.new)
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      redirect_to @product, flash: { sucess: "Product updated" }
    else
      @category = CategoryPresenter.new(Category.new)

      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      redirect_to products_path, flash: { success: "Product deleted" }
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :category_id
    )
  end
end
