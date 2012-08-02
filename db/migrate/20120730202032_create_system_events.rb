class CreateSystemEvents < ActiveRecord::Migration
  def change
    create_table :system_events do |t|

      t.timestamps
    end
  end
end
