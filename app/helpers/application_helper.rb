module ApplicationHelper
  def render_update_flashes_stream
    turbo_stream.update "flashes" do
      render "shared/flash"
    end
  end
end
