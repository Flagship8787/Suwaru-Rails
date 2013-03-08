class Admin::AdminController < ApplicationController

  	before_filter :authenticate_user!
	protect_from_forgery

	layout :layout_by_resource

	def layout_by_resource
		return "admin/layouts/application" if !request.xhr?
		return ((params.key?(:overlay) && params[:overlay].to_i == 1) ? "overlay" : false)
	end
end