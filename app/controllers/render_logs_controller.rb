class RenderLogsController < ApplicationController

  def index
    action = params[:selected_action]
    controller = params[:selected_controller]
    @logs = RenderLog.where('action = ? and controller = ?', action, controller)
    render :json => @logs.to_json
  end

end
