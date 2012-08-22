class ProcessSyslogTag
  include Sidekiq::Worker
  def perform(tag)
    Rails.logger.info "Processing tag #{tag} start"
    regex = /.*Completed in (\d+)ms \(View: (\d+), DB: (\d+)\) | (\d+ .+?) \[(.+?)\]/
    render_logs = []
    last_i = nil
    syslogs = SystemEvents.where("SysLogTag = ?", tag).order('Message')
    syslogs.each_with_index do |syslog, i|
      if syslog.Message[regex]
        render_log = RenderLog.new
        render_log[:time] = syslog.DeviceReportedTime
        render_log[:completed_time] = syslog.Message[regex, 1].to_i
        render_log[:view_time] = syslog.Message[regex, 2].to_i
        render_log[:db_time] = syslog.Message[regex, 3].to_i
        render_log[:status_code] = syslog.Message[regex, 4]
        render_log[:url] = syslog.Message[regex, 5]
        session_id = nil
        j = i
        while y.nil?
          break if j == 0
          j -= 1
          x = syslogs[j]
          parameters = x.Message[/.*Parameters: (.*)$/, 1]
          session_id = x.Message[/.*Session ID: (.*)$/, 1]
          if parameters
            render_log[:action] = x.Message[/.*\"action\"=>\"(.+?)\".*/, 1]
            render_log[:controller] = x.Message[/.*\"controller\"=>\"(.+?)\".*/, 1]
          elsif session_id
            render_log[:session_id] = session_id
          end
        end
        last_i = i
        render_logs << render_log
      end
    end
    RenderLog.transaction do
      render_logs.each {|log| log.save}
    end
    if last_i
      syslog_ids = syslogs[0..last_i].map {|syslog| syslog.id}
      SystemEvents.delete_all("id in (#{syslog_ids.join(',')})")
    end
    Rails.logger.info "Processing tag #{tag} end"
  end
end
