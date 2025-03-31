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
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Category created successfully" }
        format.html { redirect_to categories_path, notice: "Category created successfully" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
