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

  def edit
    @category = Current.user.categories.find(params[:id])
  end

  def update
    @category = Current.user.categories.find(params[:id])

    if @category.update(category_params)
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Category updated successfully" }
        format.html { redirect_to categories_path, notice: "Category updated successfully" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @category = Current.user.categories.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Category deleted successfully" }
      format.html { redirect_to categories_path, notice: "Category deleted successfully" }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
