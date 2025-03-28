class CategoriesController < ApplicationController
  def index
    @categories = Current.user.categories
  end

  def new
    @category = Current.user.categories.new
  end

  def create
    @category = Current.user.categories.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category created successfully"
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
