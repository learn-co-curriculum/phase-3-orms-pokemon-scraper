##Objectives:
1. Set up a `SQLite` database
2. Scrape and save data into your database
3. Use data to make ruby objects

###Overview
In this lab you will set up your schema, scrape data, insert it into your db and then build out methods to manipulate your data.

For our purposes the `Pokemon` class is responsible for saving, adding, removing, or changing anything about each pokemon. Your scraper shouldn't be responsible for knowing anything about them.  

###A Note On Scraping
One thing we want to make sure is that our pokemon are getting saved with the right index number.  On the `pokemon_index.html` every pokemon is in the correct order and has an `id`.  Bulbasaur is the first and starts at one.  Luckily, our sqlite database will have [auto incrementing](http://www.sqlite.org/faq.html#q1) based `id` system that starts at one too! But beware, if you create and delete a row that `id` number will forever be used, and the next `id` will be the `id` following the deleted one.

###Part 1: Create Our Database
Take a look in `db/schema_migration.sql`, this is where we are going to set up our database. Here you will write your `sql` statements to create a table with the proper schema. The schema should have an `id` column, `name` column, and a `type` column. The latter two should have the [datatype](http://www.sqlite.org/datatype3.html) `text` and the former an `integer`.

###Part 2: Create Our Pokemon Class
Our `Pokemon` class can be found in `lib/pokemon.rb`.
This is where you will build methods to insert, save and retrieve your data.

###A Note On Inserting Into the Database
When you use sql to insert into a database you write out the values by hand and insert them into the database.  However, when you insert your pokemon into the database you don't want to insert them into the query via string interpolation because of potential [dangerous consequences](http://xkcd.com/327/).  Instead we need to [sanitize](http://stackoverflow.com/questions/9614236/escaping-strings-for-ruby-sqlite-insert) the data that goes into the query string you need to [execute](http://rdoc.info/github/luislavena/sqlite3-ruby).


###Getting Started
- Fork this repo, and clone your fork.
- `bundle install` (if that doesn't work run `bundle update`)
- Follow the pending RSPEC tests to get your sense of direction.

###BONUS
Now that we got every pokemon we want to get them ready to fight. But if they battle we need to keep track of their hp (health power).  And the only way to do that is to alter the database.  What would be perfect is a `sql` query that adds an `hp` column and default value of 60 to every row.  That sql command should be put into a migration file in `db/`.

Once the `hp` column is set up there should be an instance method called `alter_hp` that will allow us to change a specific pokemon's health to a new hp.  It will need to take a new health power as a parameter.

Follow the pending specs for more information.
