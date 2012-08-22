desc "Process new logs"
task :process => :environment do
  tags = SystemEvents.uniq.pluck(:SysLogTag)
  tags.each do |tag|
    ProcessSyslogTag.perform_async(tag)
  end
end

task :destroy_old_syslogs => :environment do
  id = SystemEvents.order('ID desc').limit(500).last.id
  SystemEvents.delete_all("ID in (#{(1..id).to_a.join(',')})")
end
