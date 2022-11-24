require_relative './post'
require_relative './tag'

class TagRepository
  def find_by_tag(tag_name)

    sql = "SELECT posts.id AS post_id, posts.title, tags.id AS tag_id, tags.name AS tag_name 
    FROM posts 
    JOIN posts_tags ON posts.id = posts_tags.post_id
    JOIN tags ON tags.id = posts_tags.tag_id
    WHERE tags.name = $1;"
    sql_params = [tag_name]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    first_record = result_set[0]

    tag = Tag.new 
    tag.id = first_record['tag_id']
    tag.name = first_record['tag_name']

    result_set.each do |record|
      post = Post.new 

      post.id = record['post_id']
      post.title = record['title']
      tag.posts << post
    end
    return tag.posts
  end
end