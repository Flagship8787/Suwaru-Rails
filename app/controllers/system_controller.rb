class SystemController < ApplicationController

  def silverblog
  
    flash[:notice] = "Silverblog layout notice!"
  
    respond_to do |format|
      format.html { render :template => "system/silverblog" }
    end
  end

  def home
    puts "'params' array is " + (params.nil? ? "NIL" : "NOT NIL")
    
    respond_to do |format|
      format.html { render "system/home" }
    end
  end
  
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
end
