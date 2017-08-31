class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @category = CategoryPresenter.new(Category.new)
  end

  def create
    @product = Product.new(product_params)
    @category = CategoryPresenter.new(Category.new)

    if @product.save

      flash[:success] = "Product created"

      redirect_to @product
    else
      @product = CategoryPresenter.new(@product)

      render "new"
    end
  end

  def show
    @product = Product.find(params[:id])
    @category = CategoryPresenter.new(@product.category)
  end

  def edit
    @product = Product.find(params[:id])
    @category = CategoryPresenter.new(Category.new)
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      flash[:success] = "Product updated"
      redirect_to @product
    else
      @category = CategoryPresenter.new(Category.new)

      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      flash[:success] = "Product deleted"

      redirect_to products_path
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
