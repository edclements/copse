class HomeController < ApplicationController

  def index
    # @logs = SystemEvents.where("SysLogTag = 'rails[10941]:'").order('Message').limit(200)
    # @logs = SystemEvents.where("SysLogTag = 'rails[10941]:'").order('ReceivedAt').limit(200)
    @logs = RenderLog.order('time')
  end

end
