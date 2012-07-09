class TwitterAuth < Authentication

  def self.AuthenticateUser(aUser = nil, omniauth = nil)
    return nil if aUser.nil? || omniauth.nil?
    
    twitterAuth = aUser.TwitterAuth
    if twitterAuth.nil?
      twitterAuth = TwitterAuth.new({:user_id => aUser.id})
    end
    
    twitterAuth.Token           = omniauth[:credentials][:token]
    twitterAuth.AccountName     = omniauth[:info][:name]
    twitterAuth.AccountNickname = omniauth[:info][:nickname]
    twitterAuth.ProfileURL      = omniauth[:info][:urls][:Github]
    twitterAuth.AvatarURL       = omniauth[:info][:image]
    twitterAuth.AuthAttributes  = omniauth
    
    return twitterAuth
  end
end