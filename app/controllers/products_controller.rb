class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    find_and_assign_category

    if @product.save
      flash[:success] = "Product created"

      redirect_to @product
    else
      render "new"
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      find_and_assign_category

      flash[:success] = "Product updated"
      redirect_to @product
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      flash[:success] = "Product deleted"

      redirect_to @products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price
    )
  end

  def find_and_assign_category
    category = Category.find(params[:product][:category])
    @product.category = category
  end
end
