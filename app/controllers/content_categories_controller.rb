class ContentCategoriesController < ApplicationController
  # GET /content_categories
  # GET /content_categories.xml
  def index
    @content_categories = ContentCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @content_categories }
    end
  end

  # GET /content_categories/1
  # GET /content_categories/1.xml
  def show
    @content_category = ContentCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content_category }
    end
  end

  # GET /content_categories/new
  # GET /content_categories/new.xml
  def new
    @content_category = ContentCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content_category }
    end
  end

  # GET /content_categories/1/edit
  def edit
    @content_category = ContentCategory.find(params[:id])
  end

  # POST /content_categories
  # POST /content_categories.xml
  def create
    @content_category = ContentCategory.new(params[:content_category])

    respond_to do |format|
      if @content_category.save
        format.html { redirect_to(@content_category, :notice => 'Content category was successfully created.') }
        format.xml  { render :xml => @content_category, :status => :created, :location => @content_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /content_categories/1
  # PUT /content_categories/1.xml
  def update
    @content_category = ContentCategory.find(params[:id])

    respond_to do |format|
      if @content_category.update_attributes(params[:content_category])
        format.html { redirect_to(@content_category, :notice => 'Content category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /content_categories/1
  # DELETE /content_categories/1.xml
  def destroy
    @content_category = ContentCategory.find(params[:id])
    @content_category.destroy

    respond_to do |format|
      format.html { redirect_to(content_categories_url) }
      format.xml  { head :ok }
    end
  end
end
