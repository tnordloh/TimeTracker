#!/usr/bin/env ruby
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => './data/timerecords.db'
module DB
  class Time_entries < ActiveRecord::Base
    has_one :Category
  end
  class Category < ActiveRecord::Base 
    self.table_name = "Category"
    belongs_to :time_entries ,class_name: "Category",
                              foreign_key: "category_id"
  end
end
