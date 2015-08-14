

##Gotta Scrape 'Em All
We've found all 151 pokemon! They're in the `pokemon_index.html`, but if we want to catch them then we have to get them into our database then we're going to have to do some [scraping](http://ruby.bastardsbook.com/chapters/html-parsing/).  The other thing we're going to need is a database.

###Database Scraping
To make a database we're going to do so in the `db/` directory.  This is where all sql files should go.  Inside `db/` is a file called `schema_migration.sql`.  There you will write your sql statements to create a table with the proper schema.  The schema should have an id column, name column, and a type column. The latter two should have the [datatype](http://www.sqlite.org/datatype3.html) `text` and the former an integer.

###Inserting Into the Database
When you use sql to insert into a database you write out the values by hand and insert them into the database.  However, when you insert your pokemon into the database you don't want to insert them into the query via string interpolation because of potential [dangerous consequences](http://xkcd.com/327/).  Instead we need to [sanitize](http://stackoverflow.com/questions/9614236/escaping-strings-for-ruby-sqlite-insert) the data that goes into the query string you need to [execute](http://rdoc.info/github/luislavena/sqlite3-ruby).

If you're still having trouble executing commands take a peek into the SQLRunner class.

###Scraping
Once the schema is set up we then need can start scraping, and catching our pokemon. However, we still need methods to save our pokemon to the database.  Now we have to decide whose job is it save information about the pokemon to the database.  Is it the scraper, who is grabbing all the data? Or is it the pokemon themselves?  For our purposes, it is the pokemon.  What happens if we decide to add, remove, or even change something about the pokemon? The scraper just shouldn't be responsible about knowing information about the pokemon.  Therefore, we'll need to create a `save` method for the class pokemon that will take the name and the types and insert them into the database using [raw sql](http://www.sqlite.org/lang.html).

One thing we want to make sure is that our pokemon are getting saved with the right index number.  On the `pokemon_index.html` every pokemon is in the correct order and has an id.  Bulbasaur is the first and starts at one.  Luckily, our sqlite database will have [auto incrementing](http://www.sqlite.org/faq.html#q1) based id system that starts at one too!  That means if we scrape starting from Bulbasaur every other pokemon will have an id that is created when they are inserted into the database.  But beware, if you create and delete a row that id number will forever be used, and the next id will be the id following the deleted one.

###Getting Started
- Fork this repo, and clone your fork.
- `bundle install` (if that doesn't work run `bundle update`)
- Follow the pending RSPEC tests to get your sense of direction.

###BONUS
Now that we got every pokemon we want to get them ready to fight. (Did you really think you and Arel weren't going to have a battle after capturing every pokemon?) But if they battle we need to keep track of their hp (health power).  And the only way to do that is to alter the database.  What would be perfect is a sql query that adds an `hp` column and default value of 60 to every row.  That sql command should be put into a migration file in `db/`.

Once the `hp` column is set up there should be an instance method called `alter_hp` that will allow us to change a specific pokemon's health to a new hp.  It will need to take a new health power as a parameter. 

Follow the pending specs for more information.
