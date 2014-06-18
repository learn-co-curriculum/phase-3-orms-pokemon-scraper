require_relative "spec_helper"

describe "Pokemon" do
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_schema_migration_sql
    scraper = Scraper.new(@db)
    scraper.scrape
  end

  describe "has caught all 151 from scraping" do
    it "has all 151 pokemon" do
      expect(@db.execute("SELECT COUNT(*) FROM pokemon")).to eq([[151]])
    end

    it "knows all the information about Horsea" do
      expect(@db.execute("SELECT * FROM pokemon WHERE name = 'Horsea'")).to eq([[116, "Horsea", "Water"]])
    end

    it "knows Psyduck is the 54th pokemon" do
      expect(@db.execute("SELECT id FROM pokemon WHERE name = 'Psyduck'")).to eq([[54]])
    end

    it "knows pokemon with the id 143 is Snorlax" do
      expect(@db.execute("SELECT name FROM pokemon WHERE id = 143")).to eq([["Snorlax"]])
    end

    it "knows Charmander's type is fire" do
      expect(@db.execute("SELECT type FROM pokemon WHERE name = 'Charmander'")).to eq([["Fire"]])
    end
  end

  describe "saving more pokemon to the database" do
    before do
      Pokemon.save("Togepi", "Fairy", @db)
    end

    it "knows the pokemon count increases" do
      expect(@db.execute("SELECT COUNT(*) FROM pokemon")).to eq([[152]])
    end

    it "has Togepi as the last pokemon" do
      expect(@db.execute("SELECT name FROM pokemon ORDER BY id DESC LIMIT 1")).to eq([["Togepi"]])
    end
  end

  describe "BONUS" do
    before do
      @sql_runner.execute_create_hp_column
    end
    
    it "knows that a pokemon have a default hp of 60" do
      expect(@db.execute("SELECT hp FROM pokemon WHERE id = 1")).to eq([[60]])
    end

    # So Arel and you have decided to battle.  He chose Magikarp (rookie mistake), and you chose Pickachu.
    # He used splash. It wasn't very effective, it did one damage.
    it "alters Pickachu's hp to 59" do
      expect(Pokemon.alter_hp("Pickachu", 59, @db)).to eq(true)
      expect(@db.execute("SELECT hp FROM pokemon WHERE name = 'Pickachu'")).to eq([[59]])
    end
    
    # You have Pikachu use thunder shock. It's super effective. Magicarp took 60 damage.
    # Uh oh, looks like we mispelled Magikarp
    it "knows that there was an error when the pokemon's name is mispelled" do
      expect(Pokemon.alter_hp("Magicarp", 0, @db)).to eq(false)
    end

    # Now we use the correct name with `alter_hp`
    it "correctly alters Magikarp's hp" do
      expect(Pokemon.alter_hp("Magikarp", 0, @db)).to eq(true)
      expect(@db.execute("SELECT hp FROM pokemon WHERE name = 'Magikarp'")).to eq([[0]])
    end

    # The pokemon battle has now been won, and you are the Pokemon and SQL Master!

  end
end