task :githubtest => :environment do
  res = Github::Repos.new.repos( :user => 'flagship8787', :per_page => 10 )
  puts "Fetched repos.  There are " + res.length.to_s + " of them."
  
  res.each_page do |page|
    page.each do |repo|
      puts "Repo: " + repo.name
    end
  end
  
  github = Github.new(:login => "flagship8787", :password => "sms87871414")
  puts "Using main github object we see " + github.repos.repos.length.to_s + " repos."
  
  count = 0
  github.repos.repos.each do |repo|
    count += 1
    puts "Repo " + count.to_s + "). " + repo.name 
  end
end