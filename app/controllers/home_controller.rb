class HomeController < ApplicationController

  def index
    @logs = RenderLog.order('time').limit(50)
  end

  def graph
    @logs = RenderLog.order('time').limit(50)
    @data = @logs.map {|l| ["#{l.time}", l.completed_time]}
  end

  def list
    @logs = RenderLog.order('completed_time DESC').limit(50)
  end

  def syslog_list
    @logs = SystemEvents.order('Message').limit(50)
  end

  def candlestick
    start_time = RenderLog.order('time').first.time
    end_time = RenderLog.order('time').last.time
    period = 3.hours
    n = ((end_time - start_time)/3.hours).floor
    start_times = (1..n).to_a.map {|x| start_time+x*period}
    @data = []
    start_times.each do |time|
      logs = RenderLog.order('time').where('time > ? and time < ?', time, time+period)
      open = logs.first.completed_time
      close = logs.last.completed_time
      values = logs.map {|l| l.completed_time}.sort
      x = (values.length/50).to_i
      values = values[x..values.length-x]
      high = values.last
      low = values.first
      @data << ["#{time.strftime('%F - %T')}",low,open,close,high]
    end
  end

end
