# Blog - many-to-many relationship

Task:

Setup a new project `blog` for this exercise.

Test-drive and implement Model and Repository classes for the table `posts`, with the method `PostRepository#find_by_tag` having the behaviour described below.


```ruby
post_repository = PostRepository.new 

posts = post_repository.find_by_tag('coding')

# The array `posts` should contain the following Post objects:
#
#  * 1	How to use Git
#  * 2	Ruby classes
#  * 3	Using IRB
#  * 7  SQL basics
```

| Method      |Job| Arguments | SQL query                                     | Returns  |
| ----------- |----|-----------| ----------------------------------------------|----------|
| `find_by_tag` |Find all posts for the given tag| A tag (string) | `SELECT ... JOIN ` | Array of `Post` |

