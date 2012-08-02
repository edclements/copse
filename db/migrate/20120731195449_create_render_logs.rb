class CreateRenderLogs < ActiveRecord::Migration
  def change
    create_table :render_logs do |t|
      t.integer :completed_time
      t.integer :view_time
      t.integer :db_time
      t.string :action
      t.string :controller
      t.datetime :time

      t.timestamps
    end
  end
end
