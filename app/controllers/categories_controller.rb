class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
     assign_to_parent

      redirect_to @category
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])

    @category = CategoryPresenter.new(@category)
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      assign_to_parent

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
      :name
    )
  end

  def assign_to_parent
    category_parent_id = params[:category][:parent_id]

    if !category_parent_id.empty?
      category_parent = Category.find(category_parent_id)

      @category.move_to_child_of(category_parent)
    end
  end
end
