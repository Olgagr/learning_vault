class ResourcesController < ApplicationController
  before_action :set_resource, only: [ :edit, :update, :destroy ]

  def index
    @resources = Current.user.resources.order(created_at: :desc)
  end

  def new
    @resource = Current.user.resources.new
    @categories = Current.user.categories
  end

  def create
    @resource = Current.user.resources.new(resource_params)

    if @resource.save
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Resource created" }
        format.html { redirect_to resources_path, notice: "Resource created" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Current.user.categories
  end

  def update
    if @resource.update(resource_params)
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Resource updated" }
        format.html { redirect_to resources_path, notice: "Resource updated" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Resource deleted" }
      format.html { redirect_to resources_path, notice: "Resource deleted" }
    end
  end

  private

  def resource_params
    params.require(:resource).permit(
      :name,
      :description,
      :resource_type,
      :progress_status,
      :link,
      :owned,
      category_ids: []
    )
  end

  def set_resource
    @resource = Current.user.resources.find(params[:id])
  end
end
