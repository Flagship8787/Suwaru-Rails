class Admin::ContactFormRecipientsController < Admin::AdminController
  # GET /admin/contact_forms/1
  # GET /admin/contact_forms/1.xml
  def show
    @contact_form_recipient = ContactFormRecipient.find(params[:id])

    respond_to do |format|
      format.html { render :partial => "admin/contact_form_recipients/show" }
      format.xml  { render :xml => @contact_forms }
    end
  end

  # GET /admin/contact_form_recipients/new
  # GET /admin/contact_form_recipients/new.xml
  def new
    @contact_form_recipient = ContactFormRecipient.new({:contact_form_id => params[:cfid]})

    respond_to do |format|
      format.html { render :partial => "admin/contact_form_recipients/new" }
      format.xml  { render :xml => @contact_form_recipient }
    end
  end

  # GET /admin/contact_form_recipients/1/edit
  def edit
    @contact_form_recipient = ContactFormRecipient.find(params[:id])

    respond_to do |format|
      format.html{ render :partial => "admin/contact_form_recipients/edit" }
    end
  end

  # POST /admin/contact_form_recipients
  # POST /admin/contact_form_recipients.xml
  def create
    @contact_form_recipient = ContactFormRecipient.new(params[:contact_form_recipient])

    respond_to do |format|
      if @contact_form_recipient.save
        format.html { redirect_to(admin_contact_form_recipient_path(@contact_form_recipient), :notice => 'Contact form was successfully created.') }
        format.xml  { render :xml => @contact_form_recipient, :status => :created, :location => @contact_form_recipient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact_form_recipient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/contact_form_recipients/1
  # PUT /admin/contact_form_recipients/1.xml
  def update
    @contact_form_recipient = ContactFormRecipient.find(params[:id])

    respond_to do |format|
      if @contact_form_recipient.update_attributes(params[:contact_form_recipient])
        format.html { redirect_to(admin_contact_form_recipient_path(@contact_form_recipient), :notice => 'Contact form was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact_form_recipient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/contact_form_recipients/1
  # DELETE /admin/contact_form_recipients/1.xml
  def destroy
    @contact_form_recipient = ContactFormRecipient.find(params[:id])
    @contact_form_recipient.destroy

    respond_to do |format|
      if request.xhr?
        format.html { render :text => "Ok" }
      else
        format.html { redirect_to(admin_contact_forms_url) }
      end
      format.xml  { head :ok }
    end
  end
end
