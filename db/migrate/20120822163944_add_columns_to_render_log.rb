class AddColumnsToRenderLog < ActiveRecord::Migration
  def change
    add_column :render_logs, :status_code, :string
    add_column :render_logs, :url, :string
    add_column :render_logs, :session_id, :string
  end
end
