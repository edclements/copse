class AddTimeToSystemEvents < ActiveRecord::Migration
  def change
    add_column :SystemEvents, :time, :datetime
  end
end
