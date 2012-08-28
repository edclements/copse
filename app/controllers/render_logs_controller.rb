class RenderLogsController < ApplicationController

  def index
    action = params[:selected_action]
    controller = params[:selected_controller]
    limit = params[:limit]
    order_by = params[:order_by]
    order_dir = params[:order_dir]
    session_id = params[:session_id]
    limit ||= 20
    if order_by
      order_dir ||= 'asc'
      order = order_by + ' ' + order_dir
      @logs = RenderLog.order(order).limit(limit)
    elsif session_id
      @logs = RenderLog.where('session_id = ?', session_id).limit(limit)
    else
      @logs = RenderLog.where('action = ? and controller = ?', action, controller).limit(limit)
    end
    render :json => @logs.to_json
  end

end
