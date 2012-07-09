class PostsInstaller
  def self.InstallPosts
    puts "Posts Installer - Installing posts."
    
    posts_data_file = File.join(INSTALLER_DATA_DIR, "posts.xml")
    return false if !File.exists?(posts_data_file)
    
    file_obj = File.open(posts_data_file, "r")
    xml_obj = Nokogiri::XML(file_obj.read)
    file_obj.close
    
    return false if xml_obj.nil?
    
    post_objs = xml_obj.css("posts-list > post")
    return false if post_objs.nil? || post_objs.length <= 0
    
    count = 0
    post_objs.each do |post_obj|
      aPost = Post.new
      
      aPost.Title = post_obj["title"]
      aPost.Body  = post_obj.at_css("body").content
      
      aPost.CreatedBy = User.find_by_username(post_obj["created_by"])
      aPost.ModifiedBy = User.find_by_username(post_obj["modified_by"])
      
      aPost.tag_names = post_obj["tag_names"]
      aPost.category_names = post_obj["category_names"]
      
=begin      
      cat_str = post_obj["category"]
      aCategory = nil
      
      if(cat_str.nil? || cat_str.length <= 0)
        aCategory = Category.find_or_create_by_Name("Miscellaneous")
      else
        aCategory = Category.find_or_create_by_Name(cat_str)
      end
      
      if aPost.ContentCategory.nil?
        aPost.ContentCategory = ContentCategory.new({:Content => self})
      end
      
      aPost.ContentCategory.Category = aCategory
=end
      if aPost.save
        count += 1
        puts "Successfully installed post: " + aPost.Title + "."

        # => Now we install this post's comments      
        comment_objs = post_obj.css("comments > comment")
        if !comment_objs.nil? && comment_objs.length > 0
          cCount = 0
          comment_objs.each do |comment_obj|
            aComment            = Comment.new
            
            aComment.Parent     = aPost
            aComment.CreatedBy  = User.find_by_username(comment_obj["created_by"])
            aComment.Body       = comment_obj.content
            
            cCount += 1 if aComment.save
          end
          puts "Created " + cCount.to_s + " of " + comment_objs.length.to_s + " comments for post."
        end
      end
    end
    
    puts "Posts Installer successfully created " + count.to_s + " of " + post_objs.length.to_s + " posts." 
    
    return (count == post_objs.length)
  end
end