
desc "Process new logs"
task :process => :environment do
  regex = /.*Completed in (\d+)ms \(View: (\d+), DB: (\d+).*/
  tag = SystemEvents.first.SysLogTag
  syslogs = SystemEvents.where("SysLogTag = ?", tag).order('Message')
  syslogs.each_with_index do |syslog, i|
    if syslog.Message[regex]
      render_log = RenderLog.new
      render_log[:time] = syslog.DeviceReportedTime
      render_log[:completed_time] = syslog.Message[regex, 1].to_i
      render_log[:view_time] = syslog.Message[regex, 2].to_i
      render_log[:db_time] = syslog.Message[regex, 3].to_i
      y = nil
      j = i
      while y.nil?
        break if j == 0
        j -= 1
        x = syslogs[j]
        y = x.Message[/.*Parameters: (.*)$/, 1]
        if y
          render_log[:action] = x.Message[/.*\"action\"=>\"(.+?)\".*/, 1]
          render_log[:controller] = x.Message[/.*\"controller\"=>\"(.+?)\".*/, 1]
        end
      end
      last_i = i
      render_log.save
    end
  end
  syslogs[0..last_i].each {|l| l.delete} if last_i
end
