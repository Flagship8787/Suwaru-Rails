task :getfriends => :environment do
  aUser = User.find_by_username("flagship8787")
  if aUser.nil? || aUser.FacebookAuth.nil? 
    puts "No User for Flagship8787, or they're not authorized for Facebook.  Damn."
  end 
  
  puts "Facebook user found, and ready for a go!"
  
  fbUser = FbGraph::User.me(aUser.FacebookAuth.Token)
  
  puts "fbUser (" + fbUser.class.to_s + ") name: " + (fbUser.name.nil? ? "NIL" : fbUser.name)
  
  fbFriends = fbUser.friends
  puts "fbUser has " + (fbFriends.nil? ? "NIL" : fbFriends.length.to_s) + " friends."
  
  puts "\n"
  
  count = 1
  fbFriends.each do |fbFriend|
    puts count.to_s + ".) " + fbFriend.name + " (id: " + fbFriend.identifier + ")"
    count += 1
  end
  
  puts "\n"
  
  #Grace WishEarth (id: 25911626)
  graceUser = FbGraph::User.fetch("25911626", :access_token => aUser.FacebookAuth.Token)
  puts "graceUser is " + (graceUser.nil? ? "NIL" : "NOT NIL!") + " she's got " + (graceUser.friends.nil? ? "NIL" : graceUser.fiends.length.to_s) + " friends."
end