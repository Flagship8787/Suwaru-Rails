class Admin::SystemController < Admin::AdminController
  def dashboard
    
  end
  
  def upload_file
    Dir.mkdir(UPLOAD_FILE_DIR, 0777) if !File.exists?(UPLOAD_FILE_DIR) || !File.directory?(UPLOAD_FILE_DIR)
    
    filename = params[:Filename]
    filedata = params[:Filedata]
    
    puts "Saving " + filename + " in directory " + UPLOAD_FILE_DIR
    
    filepath = File.join(UPLOAD_FILE_DIR, filename)
    
    file_obj = File.new(filepath)
    file_obj.write(filedata.tempfile.read)
    file_obj.close
    
    respond_to do |format|
      format.html { render :text => "1" }
    end
  end
end 