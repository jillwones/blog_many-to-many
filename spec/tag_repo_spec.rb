require 'tag_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'many2many_test' })
  connection.exec(seed_sql)
end

describe TagRepository do
  before(:each) do 
    reset_tables
  end

  it 'finds a tag and returns the relevant posts for that tag' do 
    repo = TagRepository.new 
    posts = repo.find_by_tag('happy')

    expect(posts.length).to eq(2)
    expect(posts.first.title).to eq('A new day')
  end
end