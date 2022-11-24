require_relative 'lib/database_connection'
require_relative 'lib/post_repository'
require_relative 'lib/tag_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('many2many')

post_repo = PostRepository.new 

posts = post_repo.find_by_tag('coding')

posts.each do |post|
  puts "* #{post.id} #{post.title}"
end

# the above outputs:

# * 1 How to use Git
# * 2 Ruby classes
# * 3 Using IRB
# * 7 SQL basics

tag_repo = TagRepository.new 

tags = tag_repo.find_by_post('A foodie week in Spain')

tags.each do |tag|
  puts "* #{tag.id} #{tag.name}"
end

# the above outputs:

# * 2 travel
# * 3 cooking

# As these 2 tags are associated with the post with the title 'A foodie week in Spain'

tags_2 = tag_repo.find_by_post('SQL basics')

tags_2.each do |tag|
  puts "* #{tag.id} #{tag.name}"
end

# the above outputs:

# * 1 coding
# * 5 sql

# As these 2 tags are associated with the post with the title 'SQL basics'
