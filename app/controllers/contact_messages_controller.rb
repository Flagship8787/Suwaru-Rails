class ContactMessagesController < ApplicationController
  
  # GET /contact_messages
  # GET /contact_messages.xml
  def index
    @contact_messages = ContactMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contact_messages }
    end
  end

  # GET /contact_messages/1
  # GET /contact_messages/1.xml
  def show
    @contact_message = ContactMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_message }
    end
  end

  # GET /contact_messages/new
  # GET /contact_messages/new.xml
  def new
    @contact_message = ContactMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact_message }
    end
  end

  # GET /contact_messages/1/edit
  def edit
    @contact_message = ContactMessage.find(params[:id])
  end

  # POST /contact_messages
  # POST /contact_messages.xml
  def create
    params[:contact_message][:sender_id] = (current_user.nil? ? nil : current_user.id)
    @contact_message = ContactMessage.new(params[:contact_message])

    respond_to do |format|
      if @contact_message.save
        format.html { redirect_to(@contact_message, :notice => 'Contact message was successfully created.') }
        format.xml  { render :xml => @contact_message, :status => :created, :location => @contact_message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contact_messages/1
  # PUT /contact_messages/1.xml
  def update
    @contact_message = ContactMessage.find(params[:id])

    respond_to do |format|
      if @contact_message.update_attributes(params[:contact_message])
        format.html { redirect_to(@contact_message, :notice => 'Contact message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_messages/1
  # DELETE /contact_messages/1.xml
  def destroy
    @contact_message = ContactMessage.find(params[:id])
    @contact_message.destroy

    respond_to do |format|
      format.html { redirect_to(contact_messages_url) }
      format.xml  { head :ok }
    end
  end
end
