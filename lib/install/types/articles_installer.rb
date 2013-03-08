class ArticlesInstaller
  def self.InstallArticles
    puts "Articles Installer - Installing articles."
    
    articles_data_file = File.join(INSTALLER_DATA_DIR, "articles.xml")
    return false if !File.exists?(articles_data_file)
    
    file_obj = File.open(articles_data_file, "r")
    xml_obj = Nokogiri::XML(file_obj.read)
    file_obj.close
    
    return false if xml_obj.nil?
    
    article_objs = xml_obj.css("articles-list > article")
    return false if article_objs.nil? || article_objs.length <= 0
    
    count = 0
    article_objs.each do |article_obj|
      aArticle = Article.new
      
      aArticle.Title = article_obj["title"]
      aArticle.Body  = article_obj.at_css("body").content
      
      aArticle.tag_names = article_obj["tag_names"]
      aArticle.category_name = article_obj["category_name"]
      
      aArticle.SiteContent = SiteContent.new({:content_type => aArticle.class.to_s})
      aArticle.SiteContent.CreatedBy = User.find_by_username(article_obj["created_by"])
      aArticle.SiteContent.ModifiedBy = User.find_by_username(article_obj["modified_by"])
      
      if aArticle.save
        count += 1
        puts "Successfully installed article: " + aArticle.Title + "."

        # => Now we install this post's comments      
        comment_objs = article_obj.css("comments > comment")
        if !comment_objs.nil? && comment_objs.length > 0
          cCount = 0
          comment_objs.each do |comment_obj|
            aComment            = Comment.new
            
            aComment.Parent     = aArticle.SiteContent
            aComment.Poster     = User.find_by_username(comment_obj["poster"])
            aComment.Body       = comment_obj.content
            
            cCount += 1 if aComment.save
          end
          puts "Created " + cCount.to_s + " of " + comment_objs.length.to_s + " comments for article."
        end
      end
    end
    
    return (count == article_objs.length ? true : false)
  end
end