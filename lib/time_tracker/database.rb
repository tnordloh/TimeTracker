#!/usr/bin/env ruby
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => './data/timerecords.db'
module DB
  class Time_entries < ActiveRecord::Base
    has_one :Categories
  end
  class Categories < ActiveRecord::Base 
    has_many :Time_entries
  end
end
