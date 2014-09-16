#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/time_tracker'
require_relative '../install/database_initializer'

class TestTimeTracker < MiniTest::Test

  def setup
    @db = SQLite3::Database.new ":memory:"
    @db.execute "CREATE TABLE IF NOT EXISTS category(id INTEGER PRIMARY KEY, Name TEXT)"
    @db.execute "CREATE TABLE IF NOT EXISTS time_entries(id INTEGER PRIMARY KEY, 
                   name TEXT, 
                   starttime INTEGER, 
                   finishtime INTEGER, 
                   category_id INTEGER,
                   foreign key(category_id) references category(id))"
  end
  def test_initialize
    
    puts "hello"
  end
end
