require_relative "spec_helper"

describe "Pokemon" do
  let(:pokemon) {Pokemon.new(1, "Pikachu", "fire", "something")}

  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_migration_sql
    scraper = Scraper.new(@db)
    scraper.scrape
  end

  describe ".initialize" do
    it 'is initialized with a name, type and db' do
      expect(pokemon).to respond_to(:name)
      expect(pokemon).to respond_to(:type)
      expect(pokemon).to respond_to(:db)
    end
  end

  describe ".save" do
    it 'saves and instance of a pokemon with the correct id' do
      #test here
    end
  end

  describe ".find" do
    it 'finds an instance of a pokemon' do
      #test here
    end
  end


end
