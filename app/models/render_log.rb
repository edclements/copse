class RenderLog < ActiveRecord::Base
  attr_accessible :action, :completed_time, :controller, :db_time, :time, :view_time
end
