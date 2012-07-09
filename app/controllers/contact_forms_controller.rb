class ContactFormsController < ApplicationController
  # GET /contact_forms/1
  # GET /contact_forms/1.xml
  def show
    @contact_form = ContactForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_form }
    end
  end
end
