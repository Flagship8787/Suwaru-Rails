class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter { |c| Authorization.current_user = c.current_user }

  layout :layout_by_resource
  
  def layout_by_resource
    return "application" if !request.xhr?
    return ((params.key?(:overlay) && params[:overlay].to_i == 1) ? "overlay" : false)
  end

protected
  def permission_denied
    redirect_to(root_url, :alert => "Sorry, you are not allowed to access that page.")
  end
end
