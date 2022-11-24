# Design Recipe for Blog, many-to-many exercise

## 1. Design and create the Table

Skipped this step as table already created.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE posts, tags, posts_tags RESTART IDENTITY;

INSERT INTO posts (title, content) VALUES ('A new day', 'interesting stuff here');
INSERT INTO posts (title, content) VALUES ('Second post', 'less interesting stuff here');
INSERT INTO tags (name) VALUES ('happy');
INSERT INTO tags (name) VALUES ('exciting');
INSERT INTO tags (name) VALUES ('sad');
INSERT INTO posts_tags (post_id, tag_id) VALUES(1,1);
INSERT INTO posts_tags (post_id, tag_id) VALUES(1,2);
INSERT INTO posts_tags (post_id, tag_id) VALUES(2,3);
INSERT INTO posts_tags (post_id, tag_id) VALUES(2,2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
class Tag
end

class TagRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Tag
  attr_accessor :id, :name, :posts 
  def initialize
    @posts = []
  end
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
class TagRepository
  def find_by_post(post_title) #takes post title as arg
    # Executes the SQL query:
    # SELECT tags.id AS tag_id, tags.name, posts.id AS post_id, posts.title AS post_title 
    # FROM tags 
    # JOIN posts_tags ON tags.id = posts_tags.tag_id
    # JOIN posts ON posts.id = posts_tags.post_id
    # WHERE posts.title = $1;

    # returns an array of tags
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# finds all tags related to a post

repo = TagRepository.new 
tags = repo.find_by_post('A new day')

expect(tags.length).to eq(2)
expect(tags.first.name).to eq('happy')

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'many2many_test' })
  connection.exec(seed_sql)
end

describe TagRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
