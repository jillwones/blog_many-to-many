require_relative 'lib/database_connection'
require_relative 'lib/tag_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('many2many')

repo = TagRepository.new 

posts = repo.find_by_tag('coding')

posts.each do |post|
  puts "* #{post.id} #{post.title}"
end

# the above outputs:

# * 1 How to use Git
# * 2 Ruby classes
# * 3 Using IRB
# * 7 SQL basics