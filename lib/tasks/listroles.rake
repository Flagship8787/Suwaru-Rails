task :listroles => :environment do
  User.all.each do |aUser|
    puts aUser.username + " has role: " + aUser.role_symbols[0].to_s
  end
end