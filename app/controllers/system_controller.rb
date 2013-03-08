class SystemController < ApplicationController

  def silverblog
  
    flash[:notice] = "Silverblog layout notice!"
  
    respond_to do |format|
      format.html { render :template => "system/silverblog" }
    end
  end

  def home
    @contents = SiteContent.with_permissions_to(:read).page(params[:hpage]).per(5)
    
    respond_to do |format|
      format.html { render :template => "system/home", :layout => "home" }
    end
  end

=begin
  def workshop
    @projects = Project.page(params[:workshop_page]).per(5)
    
    respond_to do |format|
      format.html{ render "system/workshop" }
    end
  end
  def blog
    @posts = Post.page(params[:blog_page]).per(5)
    
    respond_to do |format|
      format.html{ render "system/blog" }
    end
  end
=end  

  def archive
    @contents = SiteContent.page(params[:archive_page]).per(5)
    
    respond_to do |format|
      format.html{ render "system/archive" }
    end
  end
  
  def contact_us
    @contact_form = ContactForm.find(1)
    
    respond_to do |format|
      format.html { render :template => "contact_forms/show" }
    end
  end
  
  def archives
    respond_to do |format|
      format.html { render :template => "system/archives" }
    end
  end
end
