require_relative './post'
require_relative './tag'

class PostRepository
  def find_by_tag(tag_name)

    sql = "SELECT posts.id AS post_id, posts.title, tags.id AS tag_id, tags.name AS tag_name 
    FROM posts 
    JOIN posts_tags ON posts.id = posts_tags.post_id
    JOIN tags ON tags.id = posts_tags.tag_id
    WHERE tags.name = $1;"
    sql_params = [tag_name]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    posts = []
    
    result_set.each do |record|
      if record['tag_name'] = tag_name
        post = Post.new 

        post.id = record['post_id']
        post.title = record['title']
        posts << post
      end
    end
    return posts
  end
end