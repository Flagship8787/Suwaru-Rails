class Admin::SiteContentsController < Admin::AdminController
  
  before_filter :authenticate_user!, :except => :receive_upload
  
  # GET /admin/site_contents
  # GET /admin/site_contents.xml
  def index
    @site_contents = SiteContent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @site_contents }
    end
  end

  def receive_upload
  	dir = SiteContent.image_directory

    upload_obj = params[:Filedata]
    tmpfile_path = upload_obj.tempfile.path
    
    file_obj = File.open(File.join(dir, upload_obj.original_filename), "w+")
    tempfile_obj = File.open(tmpfile_path, "r")

    file_obj.write(tempfile_obj.read)

    file_obj.close
    tempfile_obj.close

    render :json => {:file_url => "/sc_images/" + upload_obj.original_filename, :file_name => upload_obj.original_filename, :file_size => File.size(File.join(dir, upload_obj.original_filename)), :file_uploaded => Time.now.to_s}
  end
end
