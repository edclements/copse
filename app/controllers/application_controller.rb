class ApplicationController < ActionController::Base
  protect_from_forgery

  if APP_CONFIG['perform_authentication']
    http_basic_authenticate_with :name => APP_CONFIG['name'], :password => APP_CONFIG['password']
  end
end
