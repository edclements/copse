desc "Process new logs"
task :process => :environment do
  tags = SystemEvents.uniq.pluck(:SysLogTag)
  tags.each do |tag|
    ProcessSyslogTag.perform_async(tag)
  end
end
