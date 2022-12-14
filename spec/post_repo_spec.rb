require 'post_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'many2many_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_tables
  end

  it 'returns all the posts associated with a tag' do 
    repo = PostRepository.new 
    posts = repo.find_by_tag('happy')

    expect(posts.length).to eq(2)
    expect(posts.first.title).to eq('A new day')
  end
end