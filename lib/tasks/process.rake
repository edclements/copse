
desc "Process new logs"
task :process => :environment do
  Rails.logger.info "Start: Process new logs"
  regex = /.*Completed in (\d+)ms \(View: (\d+), DB: (\d+).*/
  tags = SystemEvents.uniq.pluck(:SysLogTag)
  last_i = nil
  render_logs = []
  tags.each do |tag|
    Rails.logger.info "Processing syslogs with tag: #{tag}"
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
        # render_log.save
        render_logs << render_log
      end
    end
    RenderLog.transaction do
      render_logs.each {|log| log.save}
    end
    Rails.logger.info "Deleting processed syslogs"
    # syslogs[0..last_i].each {|l| l.delete} if last_i
    if last_i
      syslog_ids = syslogs[0..last_i].map {|syslog| syslog.id}
      SystemEvents.delete_all("id in (#{syslog_ids.join(',')})")
    end
  end
  Rails.logger.info "End: Process new logs"
end
