class AddIndexSystemEventsSysLogTag < ActiveRecord::Migration
  def up
    add_index :SystemEvents, :SysLogTag, :name => "SysLogTagIndex"
  end

  def down
    remove_index :SystemEvents, :column => :SysLogTag
  end
end
