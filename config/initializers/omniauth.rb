Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  'dmQEiRu5wAWnHVopmZgrAg', 'gOJmM40S4ke2ZzCdqLnvXTTVOzoQsNSAoVN9ZF9Inrs'
  provider :facebook, '335487819856081',        '77ce1b300ad05721fe2463b219e17645',           :scope => "publish_actions,publish_stream,publish_checkins,user_about_me,friends_about_me,user_relationships,friends_relationships,read_friendlists,friends_online_presence"
  provider :github,   'e8a2df43d988ac42c8f2',   '3a6d6bcaabe9568dea5c729630cb95d260af770c',   :scope => "user,repo,gist"
end