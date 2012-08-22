class RenderLogsController < ApplicationController

  def index
    action = params[:selected_action]
    controller = params[:selected_controller]
    limit = params[:limit]
    limit ||= 50
    @logs = RenderLog.where('action = ? and controller = ?', action, controller).limit(limit)
    render :json => @logs.to_json
  end

end
