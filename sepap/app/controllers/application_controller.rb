class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "Acceso DENEGADO"
  end
end
