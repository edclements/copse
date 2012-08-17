desc "Process new logs"
task :process => :environment do
  if SystemEvents.count > 20
    tags = SystemEvents.uniq.pluck(:SysLogTag)
    tags.each do |tag|
      ProcessSyslogTag.perform_async(tag)
    end
  end
end
