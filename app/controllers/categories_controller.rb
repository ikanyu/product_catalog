class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    @category = CategoryPresenter.new(@category)
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category
    else
      @category = CategoryPresenter.new(@category)

      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @category = CategoryPresenter.new(@category)
  end

  def edit
    @category = Category.find(params[:id])

    @category = CategoryPresenter.new(@category)
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      flash[:success] = "Category updated"

      redirect_to @category
    else
      @category = CategoryPresenter.new(@category)

      render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    ChildrenReassignmentService.new(@category).perform

    @category.reload

    if Category.destroy(@category.id)
      flash[:success] = "Category deleted"

      redirect_to categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name,
      :parent_id
    )
  end
end
