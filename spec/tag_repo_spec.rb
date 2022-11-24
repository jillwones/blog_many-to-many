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

  it 'returns all the posts associated with a tag' do 
    repo = TagRepository.new 
    tags = repo.find_by_post('A new day')

    expect(tags.length).to eq(2)
    expect(tags.first.name).to eq('happy')
  end
end