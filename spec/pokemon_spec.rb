require_relative "spec_helper"

describe "Pokemon" do
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_migration_sql
    Scraper.new.scrape
  end

  describe "has caught all 151 from scraping" do
    it "has all 151 pokemon" do
      expect(@db.execute("SELECT COUNT(*) FROM pokemon")).to eq(151)
    end

    xit "knows Psyduck is the 54th pokemon" do
      expect(@db.execute("YOUR SQL HERE")).to eq(54)
    end

    xit "knows pokemon with the id 143 is Snorlax" do
      expect(@db.execute("YOUR SQL HERE")).to eq("Snorlax")
    end

    xit "knows Charmander's type is fire" do
      expect(@db.execute("YOUR SQL HERE")).to eq("Fire")
    end
  end

  describe "saving more pokemon to the database" do
    before do
      Pokemon.save("Togepi", "Fairy")
    end

    xit "increases the amount of pokemon" do
      expect(@db.execute("YOUR SQL HERE")).to eq(152)
    end

    xit "has Togepi as the last pokemon" do
      expect(@db.execute("YOUR SQL HERE")).to eq("Togepi")
    end
  end
end