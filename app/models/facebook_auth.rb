class FacebookAuth < Authentication
  def self.AuthenticateUser(aUser = nil, omniauth = nil)
    return nil if aUser.nil? || omniauth.nil?
    
    facebookAuth = aUser.FacebookAuth
    if facebookAuth.nil?
      facebookAuth = FacebookAuth.new({:user_id => aUser.id})
    end
    
    facebookAuth.Token           = omniauth[:credentials][:token]
    facebookAuth.AccountName     = omniauth[:info][:name]
    facebookAuth.AccountNickname = omniauth[:info][:nickname]
    facebookAuth.ProfileURL      = omniauth[:info][:urls][:Facebook]
    facebookAuth.AvatarURL       = omniauth[:info][:image]
    facebookAuth.AuthAttributes  = omniauth
    
    return facebookAuth
  end
end