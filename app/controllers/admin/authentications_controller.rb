class Admin::AuthenticationsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    
    puts "Auth info from " + params[:provider] + "( " + auth.type.to_s + " )"
    
    auth.each_pair do |aKey, aValue|
      puts aKey + ":\t\t" + aValue.to_s
    end
    
    auth_class = Authentication
    if    params[:provider] == "twitter"
      auth_class = TwitterAuth
    elsif params[:provider] == "facebook"
      #@authentication = FacebookAuth.find_or_create_by_user_id_and_Token(current_user.id, auth[:credentials][:token])
      auth_class = FacebookAuth
    elsif params[:provider] == "github"
      #@authentication = GithubAuth.find_or_create_by_user_id_and_Token(current_user.id, auth[:credentials][:token])
      auth_class = GithubAuth
    else
      puts "Unknown provider: " + params[:provider] + " attempting authentication."
    end

    #@authentication = current_user.AuthenticateWith(params[:provider], params["omniauth.auth"])

    @authentication = auth_class.AuthenticateUser(current_user, auth)

    respond_to do |format|
      if @authentication.save
        format.html { redirect_to(admin_user_path(current_user), :notice => 'Authentication was successfully created.') }
        format.xml  { render :xml => @authentication, :status => :created, :location => @authentication }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @authentication.errors, :status => :unprocessable_entity }
      end
    end
  end
end
