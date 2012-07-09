class FlagsController < ApplicationController
  # GET /flags
  # GET /flags.xml
  def index
    @flags = Flag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flags }
    end
  end

  # GET /flags/1
  # GET /flags/1.xml
  def show
    @flag = Flag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flag }
    end
  end

  # GET /flags/new
  # GET /flags/new.xml
  def new
    
    request_ip = request.env["REMOTE_ADDR"]
    if request_ip.class == Array
      
      request_ip.each do |aIP|
        puts "Request Ip: " + aIP.to_s
      end
      
      request_ip = request_ip[0].to_s
    else
      puts "Request IP: " + request_ip.to_s
    end
    
    @flag = Flag.new({:FlaggedByIP => request_ip, :Flagged => Kernel.const_get(params[:ftype]).find(params[:fid])})

    respond_to do |format|
      if request.xhr?
        format.html { render :template => "flags/ajax/new" }
      else
        format.html # new.html.erb
      end
      format.xml  { render :xml => @flag }
    end
  end

  # GET /flags/1/edit
  def edit
    @flag = Flag.find(params[:id])
  end

  # POST /flags
  # POST /flags.xml
  def create
    @flag = Flag.new(params[:flag])

    respond_to do |format|
      if @flag.save
        if request.xhr?
          format.html { render :text => params[:flag][:flagged_type] + " successfully flagged." }
        else
          format.html { redirect_to(@flag, :notice => 'Flag was successfully created.') }
        end
        format.xml  { render :xml => @flag, :status => :created, :location => @flag }
      else
        if request.xhr?
          format.html { render :template => "flags/ajax/new", :status => :unprocessable_entity }
        else
          format.html { render :action => "new" }
        end
        format.xml  { render :xml => @flag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flags/1
  # PUT /flags/1.xml
  def update
    @flag = Flag.find(params[:id])

    respond_to do |format|
      if @flag.update_attributes(params[:flag])
        format.html { redirect_to(@flag, :notice => 'Flag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flags/1
  # DELETE /flags/1.xml
  def destroy
    @flag = Flag.find(params[:id])
    @flag.destroy

    respond_to do |format|
      format.html { redirect_to(flags_url) }
      format.xml  { head :ok }
    end
  end
end
