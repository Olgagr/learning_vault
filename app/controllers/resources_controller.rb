class ResourcesController < ApplicationController
  def index
    @resources = Current.user.resources
  end

  def new
    @resource = Current.user.resources.new
    @categories = Current.user.categories
  end

  def create
    @resource = Current.user.resources.new(resource_params)

    if @resource.save
      @resource.categories << Current.user.categories.where(id: params[:resource][:category_ids])
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Resource created successfully" }
        format.html { redirect_to resources_path, notice: "Resource created successfully" }
      end
    else
      render :new, status: :unprocessable_entity
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
      :owned
    )
  end
end
