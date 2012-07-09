class GithubAuth < Authentication
  
  has_many :Projects, :foreign_key => :github_auth_id, :inverse_of => :GithubAuth
  
  def self.AuthenticateUser(aUser = nil, omniauth = nil)
    return nil if aUser.nil? || omniauth.nil?

    githubAuth = aUser.GithubAuth
    if githubAuth.nil?
      githubAuth = GithubAuth.new({:user_id => aUser.id})
    end

    githubAuth.Token           = omniauth[:credentials][:token]
    githubAuth.AccountName     = omniauth[:info][:name]
    githubAuth.AccountNickname = omniauth[:info][:nickname]
    githubAuth.ProfileURL      = omniauth[:info][:urls][:GitHub]
    githubAuth.AvatarURL       = omniauth[:extra][:raw_info][:avatar_url]
    githubAuth.AuthAttributes  = omniauth

    return githubAuth
  end
  
  def AllGithubRepos
    github_repos = Github::Repos.new({:oauth_token => self.Token})
    return (github_repos.repos.nil? || github_repos.repos.length <= 0 ? nil : github_repos)
  end
  def GituhubRepoWithId( repo_id = nil)
    return nil if repo_id.nil? || repo_id.length <= 0
    
    all_repos = self.AllGithubRepos
    return nil if all_repos.nil?
    
    all_repos.list_repos do |aRepo|
      puts "Checking id for repo: " + aRepo.id.to_s + " against " + repo_id
      return aRepo if aRepo.id.to_s == repo_id.to_s
    end
    
    puts "couldn't find repo with id: " + repo_id
    
    return nil
  end
  
  def SyncedRepo?(repo_id = nil)
    return (repo_id.nil? ? false : Project.exists?({:github_auth_id => self.id, :GithubId => repo_id}))
  end
  
  def SyncRepo(repo_id = nil)
    aRepo = self.GituhubRepoWithId(repo_id)
    return false if aRepo.nil?

    aProject                  = Project.find_or_create_by_github_auth_id_and_GithubId(self.id, aRepo.id)
    
    aProject.Name             = aRepo.name        if aProject.Name.nil?
    aProject.Description      = aRepo.description if aProject.Description.nil?

    aProject.GithubAttributes = aRepo

    aProject.GithubSynced     = Time.now
    
    return aProject.save
  end
  def SyncRepos
    allRepos = self.AllGithubRepos
    return false if allRepos.nil?
    
    count = 0 
    allRepos.list_repos do |aRepo|
      aProject                  = Project.find_or_create_by_github_auth_id_and_GithubId(self.id, aRepo.id)

      aProject.Name             = aRepo.name        if aProject.Name.nil?
      aProject.Description      = aRepo.description if aProject.Description.nil?

      aProject.GithubAttributes = aRepo

      aProject.GithubSynced     = Time.now

      count += 1 if aProject.save
    end
    
    return (count == allRepos.repos.length ? true : false)
  end  
end