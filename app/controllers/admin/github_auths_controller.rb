class Admin::GithubAuthsController < ApplicationController
  def sync
    @github_auth = GithubAuth.find(params[:id])
    
    respond_to do |format|
      if @github_auth.SyncRepo(params[:repo_id])
        format.html { render :partial => "/admin/authentications/github/show" }
      else
        format.html { render :text => "Failed to sync repo", :status => :unprocessable_entity }
      end
    end
  end
  def sync_all
    @github_auth = GithubAuth.find(params[:id])
    
    respond_to do |format|
      if @github_auth.SyncRepos
        format.html { render :partial => "/admin/authentications/github/show" }
      else
        format.html { render :text => "Failed to sync repos", :status => :unprocessable_entity }
      end
    end
  end
end
