require_relative './tag'

class TagRepository
  def find_by_post(post_title)
    
    sql = 'SELECT tags.id AS tag_id, tags.name, posts.id AS post_id, posts.title AS post_title 
          FROM tags 
          JOIN posts_tags ON tags.id = posts_tags.tag_id
          JOIN posts ON posts.id = posts_tags.post_id
          WHERE posts.title = $1;'
    sql_params = [post_title]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    tags = []

    result_set.each do |record|
      tag = Tag.new 

      tag.id = record['tag_id']
      tag.name = record['name']

      tags << tag
    end
    return tags
  end
end