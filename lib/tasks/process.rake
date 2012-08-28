desc "Process new logs"
task :process => :environment do
  tags = SystemEvents.uniq.pluck(:SysLogTag)
  tags.each do |tag|
    ProcessSyslogTag.perform_async(tag)
  end
end

task :destroy_old_syslogs => :environment do
  old_logs = SystemEvents.where('DeviceReportedTime < ?', Date.today - 1.day)
  SystemEvents.delete_all("ID in (#{old_logs.map {|l| l.id}.join(',')})")
end
