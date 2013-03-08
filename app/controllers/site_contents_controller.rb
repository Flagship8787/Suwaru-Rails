class SiteContentsController < ApplicationController

  # GET /site_contents
  # GET /site_contents.xml
  def index
    @site_contents = SiteContent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @site_contents }
    end
  end
end
