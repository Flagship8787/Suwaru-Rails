# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{github_api}
  s.version = "0.4.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Piotr Murach"]
  s.date = %q{2012-04-21}
  s.description = %q{ Ruby wrapper that supports all of the GitHub API v3 methods(nearly 200). It's build in a modular way, that is, you can either instantiate the whole api wrapper Github.new or use parts of it e.i. Github::Repos.new if working solely with repositories is your main concern. }
  s.email = %q{}
  s.files = ["Rakefile", "features/cassettes/errors/repos/create.yml", "features/cassettes/gists/comments/all.yml", "features/cassettes/gists/comments/first.yml", "features/cassettes/gists/gist/first.yml", "features/cassettes/gists/gist.yml", "features/cassettes/gists/gists/public_all.yml", "features/cassettes/gists/gists/user_all.yml", "features/cassettes/pagination/repos/commits/next.yml", "features/cassettes/pagination/repos/commits/sha/next.yml", "features/cassettes/pagination/repos/commits/sha.yml", "features/cassettes/pagination/repos/commits.yml", "features/cassettes/pagination/repos/diff/next.yml", "features/cassettes/pagination/repos/diff.yml", "features/cassettes/pagination/repos/next.yml", "features/cassettes/pagination/repos/per_page/each_page.yml", "features/cassettes/pagination/repos/per_page/first.yml", "features/cassettes/pagination/repos.yml", "features/cassettes/repos/branches.yml", "features/cassettes/repos/tags.yml", "features/error_codes.feature", "features/gists/comments.feature", "features/gists.feature", "features/github_api.feature", "features/options.feature", "features/pagination.feature", "features/README.rdoc", "features/repos.feature", "features/step_definitions/common_steps.rb", "features/step_definitions/github_api_steps.rb", "features/support/env.rb", "features/support/helpers.rb", "features/support/vcr.rb", "lib/github_api/api/actions.rb", "lib/github_api/api.rb", "lib/github_api/api_factory.rb", "lib/github_api/authorization.rb", "lib/github_api/authorizations.rb", "lib/github_api/client.rb", "lib/github_api/compatibility.rb", "lib/github_api/configuration.rb", "lib/github_api/connection.rb", "lib/github_api/constants.rb", "lib/github_api/core_ext/array.rb", "lib/github_api/core_ext/hash.rb", "lib/github_api/core_ext/ordered_hash.rb", "lib/github_api/deprecation.rb", "lib/github_api/error/bad_request.rb", "lib/github_api/error/client_error.rb", "lib/github_api/error/forbidden.rb", "lib/github_api/error/internal_server_error.rb", "lib/github_api/error/invalid_options.rb", "lib/github_api/error/not_found.rb", "lib/github_api/error/required_params.rb", "lib/github_api/error/service_error.rb", "lib/github_api/error/service_unavailable.rb", "lib/github_api/error/unauthorized.rb", "lib/github_api/error/unprocessable_entity.rb", "lib/github_api/error/validations.rb", "lib/github_api/error.rb", "lib/github_api/events.rb", "lib/github_api/filter.rb", "lib/github_api/gists/comments.rb", "lib/github_api/gists.rb", "lib/github_api/git_data/blobs.rb", "lib/github_api/git_data/commits.rb", "lib/github_api/git_data/references.rb", "lib/github_api/git_data/tags.rb", "lib/github_api/git_data/trees.rb", "lib/github_api/git_data.rb", "lib/github_api/issues/comments.rb", "lib/github_api/issues/events.rb", "lib/github_api/issues/labels.rb", "lib/github_api/issues/milestones.rb", "lib/github_api/issues.rb", "lib/github_api/mime_type.rb", "lib/github_api/orgs/members.rb", "lib/github_api/orgs/teams.rb", "lib/github_api/orgs.rb", "lib/github_api/page_iterator.rb", "lib/github_api/page_links.rb", "lib/github_api/page_uri_processor.rb", "lib/github_api/paged_request.rb", "lib/github_api/pull_requests/comments.rb", "lib/github_api/pull_requests.rb", "lib/github_api/ratelimit_status.rb", "lib/github_api/repos/collaborators.rb", "lib/github_api/repos/commits.rb", "lib/github_api/repos/downloads.rb", "lib/github_api/repos/forks.rb", "lib/github_api/repos/hooks.rb", "lib/github_api/repos/keys.rb", "lib/github_api/repos/pub_sub_hubbub.rb", "lib/github_api/repos/watching.rb", "lib/github_api/repos.rb", "lib/github_api/request/basic_auth.rb", "lib/github_api/request/oauth2.rb", "lib/github_api/request.rb", "lib/github_api/response/helpers.rb", "lib/github_api/response/jsonize.rb", "lib/github_api/response/mashify.rb", "lib/github_api/response/raise_error.rb", "lib/github_api/response/xmlize.rb", "lib/github_api/response.rb", "lib/github_api/result.rb", "lib/github_api/s3_uploader.rb", "lib/github_api/users/emails.rb", "lib/github_api/users/followers.rb", "lib/github_api/users/keys.rb", "lib/github_api/users.rb", "lib/github_api/utils/url.rb", "lib/github_api/validation.rb", "lib/github_api/version.rb", "lib/github_api.rb", "spec/coverage_adapter.rb", "spec/fixtures/auths/authorization.json", "spec/fixtures/auths/authorizations.json", "spec/fixtures/events/events.json", "spec/fixtures/gists/comment.json", "spec/fixtures/gists/comments.json", "spec/fixtures/gists/gist.json", "spec/fixtures/gists/gists.json", "spec/fixtures/git_data/blob.json", "spec/fixtures/git_data/blob_sha.json", "spec/fixtures/git_data/commit.json", "spec/fixtures/git_data/reference.json", "spec/fixtures/git_data/references.json", "spec/fixtures/git_data/tag.json", "spec/fixtures/git_data/tree.json", "spec/fixtures/issues/comment.json", "spec/fixtures/issues/comments.json", "spec/fixtures/issues/event.json", "spec/fixtures/issues/events.json", "spec/fixtures/issues/issue.json", "spec/fixtures/issues/issues.json", "spec/fixtures/issues/label.json", "spec/fixtures/issues/labels.json", "spec/fixtures/issues/milestone.json", "spec/fixtures/issues/milestones.json", "spec/fixtures/orgs/members.json", "spec/fixtures/orgs/org.json", "spec/fixtures/orgs/orgs.json", "spec/fixtures/orgs/team.json", "spec/fixtures/orgs/team_repos.json", "spec/fixtures/orgs/teams.json", "spec/fixtures/pull_requests/comment.json", "spec/fixtures/pull_requests/comments.json", "spec/fixtures/pull_requests/commits.json", "spec/fixtures/pull_requests/files.json", "spec/fixtures/pull_requests/merge_failure.json", "spec/fixtures/pull_requests/merge_success.json", "spec/fixtures/pull_requests/pull_request.json", "spec/fixtures/pull_requests/pull_requests.json", "spec/fixtures/repos/branches.json", "spec/fixtures/repos/collaborators.json", "spec/fixtures/repos/commit.json", "spec/fixtures/repos/commit_comment.json", "spec/fixtures/repos/commit_comments.json", "spec/fixtures/repos/commits.json", "spec/fixtures/repos/contributors.json", "spec/fixtures/repos/download.json", "spec/fixtures/repos/download_s3.json", "spec/fixtures/repos/downloads.json", "spec/fixtures/repos/fork.json", "spec/fixtures/repos/forks.json", "spec/fixtures/repos/hook.json", "spec/fixtures/repos/hooks.json", "spec/fixtures/repos/key.json", "spec/fixtures/repos/keys.json", "spec/fixtures/repos/languages.json", "spec/fixtures/repos/repo.json", "spec/fixtures/repos/repo_comments.json", "spec/fixtures/repos/repos.json", "spec/fixtures/repos/tags.json", "spec/fixtures/repos/teams.json", "spec/fixtures/repos/watched.json", "spec/fixtures/repos/watchers.json", "spec/fixtures/users/emails.json", "spec/fixtures/users/followers.json", "spec/fixtures/users/key.json", "spec/fixtures/users/keys.json", "spec/fixtures/users/user.json", "spec/github/api_factory_spec.rb", "spec/github/api_spec.rb", "spec/github/authorization_spec.rb", "spec/github/authorizations_spec.rb", "spec/github/client_spec.rb", "spec/github/core_ext/hash_spec.rb", "spec/github/deprecation_spec.rb", "spec/github/error/client_error_spec.rb", "spec/github/error/invalid_options_spec.rb", "spec/github/error/required_params_spec.rb", "spec/github/events_spec.rb", "spec/github/filter_spec.rb", "spec/github/gists/comments_spec.rb", "spec/github/gists_spec.rb", "spec/github/git_data/blobs_spec.rb", "spec/github/git_data/commits_spec.rb", "spec/github/git_data/references_spec.rb", "spec/github/git_data/tags_spec.rb", "spec/github/git_data/trees_spec.rb", "spec/github/git_data_spec.rb", "spec/github/issues/comments_spec.rb", "spec/github/issues/events_spec.rb", "spec/github/issues/labels_spec.rb", "spec/github/issues/milestones_spec.rb", "spec/github/issues_spec.rb", "spec/github/mime_type_spec.rb", "spec/github/orgs/members_spec.rb", "spec/github/orgs/teams_spec.rb", "spec/github/orgs_spec.rb", "spec/github/page_iterator_spec.rb", "spec/github/page_links_spec.rb", "spec/github/paged_request_spec.rb", "spec/github/pull_requests/comments_spec.rb", "spec/github/pull_requests_spec.rb", "spec/github/repos/collaborators_spec.rb", "spec/github/repos/commits_spec.rb", "spec/github/repos/downloads_spec.rb", "spec/github/repos/forks_spec.rb", "spec/github/repos/hooks_spec.rb", "spec/github/repos/keys_spec.rb", "spec/github/repos/pub_sub_hubbub_spec.rb", "spec/github/repos/watching_spec.rb", "spec/github/repos_spec.rb", "spec/github/request_spec.rb", "spec/github/response/helpers_spec.rb", "spec/github/result_spec.rb", "spec/github/s3_uploader_spec.rb", "spec/github/users/emails_spec.rb", "spec/github/users/followers_spec.rb", "spec/github/users/keys_spec.rb", "spec/github/users_spec.rb", "spec/github/utils/url_spec.rb", "spec/github/validation_spec.rb", "spec/github_spec.rb", "spec/README.rdoc", "spec/spec_helper.rb", "spec/support/authentication.rb", "spec/support/base.rb", "spec/support/file_ops.rb", "README.md", "LICENSE.txt"]
  s.homepage = %q{https://github.com/peter-murach/github}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Ruby wrapper for the GitHub API v3}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hashie>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<faraday>, ["~> 0.7.6"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_runtime_dependency(%q<oauth2>, ["~> 0.5.2"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
      s.add_development_dependency(%q<webmock>, ["~> 1.8.0"])
      s.add_development_dependency(%q<vcr>, ["~> 2.0.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.6.1"])
      s.add_development_dependency(%q<guard>, ["~> 0.8.8"])
      s.add_development_dependency(%q<guard-rspec>, ["= 0.5.7"])
      s.add_development_dependency(%q<guard-cucumber>, ["= 0.7.4"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
    else
      s.add_dependency(%q<hashie>, ["~> 1.2.0"])
      s.add_dependency(%q<faraday>, ["~> 0.7.6"])
      s.add_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_dependency(%q<oauth2>, ["~> 0.5.2"])
      s.add_dependency(%q<nokogiri>, ["~> 1.5.2"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
      s.add_dependency(%q<webmock>, ["~> 1.8.0"])
      s.add_dependency(%q<vcr>, ["~> 2.0.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.6.1"])
      s.add_dependency(%q<guard>, ["~> 0.8.8"])
      s.add_dependency(%q<guard-rspec>, ["= 0.5.7"])
      s.add_dependency(%q<guard-cucumber>, ["= 0.7.4"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
    end
  else
    s.add_dependency(%q<hashie>, ["~> 1.2.0"])
    s.add_dependency(%q<faraday>, ["~> 0.7.6"])
    s.add_dependency(%q<multi_json>, ["~> 1.3"])
    s.add_dependency(%q<oauth2>, ["~> 0.5.2"])
    s.add_dependency(%q<nokogiri>, ["~> 1.5.2"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
    s.add_dependency(%q<webmock>, ["~> 1.8.0"])
    s.add_dependency(%q<vcr>, ["~> 2.0.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.6.1"])
    s.add_dependency(%q<guard>, ["~> 0.8.8"])
    s.add_dependency(%q<guard-rspec>, ["= 0.5.7"])
    s.add_dependency(%q<guard-cucumber>, ["= 0.7.4"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
  end
end
