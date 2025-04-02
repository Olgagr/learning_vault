class CategoriesController < ApplicationController
  before_action :set_category, only: [ :edit, :update, :destroy ]

  def index
    @categories = Current.user.categories.order(created_at: :desc)
  end

  def new
    @category = Current.user.categories.new
  end

  def create
    @category = Current.user.categories.new(category_params)

    if @category.save
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Category created" }
        format.html { redirect_to categories_path, notice: "Category created" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Category updated" }
        format.html { redirect_to categories_path, notice: "Category updated" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @category.destroy

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Category deleted" }
      format.html { redirect_to categories_path, notice: "Category deleted" }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_category
    @category = Current.user.categories.find(params[:id])
  end
end
