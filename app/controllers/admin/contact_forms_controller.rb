class Admin::ContactFormsController < Admin::AdminController
  
  # GET /admin/contact_forms
  # GET /admin/contact_forms.xml
  def index
    @contact_forms = ContactForm.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contact_forms }
    end
  end
  
  # GET /admin/contact_forms/1
  # GET /admin/contact_forms/1.xml
  def show
    @contact_form = ContactForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_forms }
    end
  end

  # GET /admin/contact_forms/new
  # GET /admin/contact_forms/new.xml
  def new
    @contact_form = ContactForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact_form }
    end
  end

  # GET /admin/contact_forms/1/edit
  def edit
    @contact_form = ContactForm.find(params[:id])
  end

  # POST /admin/contact_forms
  # POST /admin/contact_forms.xml
  def create
    @contact_form = ContactForm.new(params[:contact_form])

    respond_to do |format|
      if @contact_form.save
        format.html { redirect_to(@contact_form, :notice => 'Contact form was successfully created.') }
        format.xml  { render :xml => @contact_form, :status => :created, :location => @contact_form }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact_form.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/contact_forms/1
  # PUT /admin/contact_forms/1.xml
  def update
    @contact_form = ContactForm.find(params[:id])

    respond_to do |format|
      if @contact_form.update_attributes(params[:contact_form])
        format.html { redirect_to(admin_contact_forms_path, :notice => 'Contact form was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact_form.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/contact_forms/1
  # DELETE /admin/contact_forms/1.xml
  def destroy
    @contact_form = ContactForm.find(params[:id])
    @contact_form.destroy

    respond_to do |format|
      format.html { redirect_to(contact_forms_url) }
      format.xml  { head :ok }
    end
  end
end
