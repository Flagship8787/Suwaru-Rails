class PostsController < ApplicationController

  filter_resource_access

  # GET /posts
  # GET /posts.xml
  def index
    @contents = SiteContent.with_permissions_to(:read).where({:content_type => Post.to_s}).page(params[:bpage]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    #@post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  def comment
    @comment = Comment.new({:Parent => Post.find(params[:id])})
    respond_to do |format|
      format.html
    end
  end
end
