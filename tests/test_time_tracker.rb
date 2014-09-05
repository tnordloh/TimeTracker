#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/time_tracker'

class TestRomanNumerals < MiniTest::Test

  def setup
    tt = TimeTracker.new()
   }
  end

  def test_enter_time
  end

  def test_report_time
    (1...(@list.size)).each {|i|
      assert_equal @list[i], @rn.to_roman(i) 
    }
  end
end
