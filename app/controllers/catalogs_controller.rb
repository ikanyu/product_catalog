class CatalogsController < ApplicationController
  def index
    @products = Product.all

    @categories = Category.all
  end

  def search
    byebug
  end
end
