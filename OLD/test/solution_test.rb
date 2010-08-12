lib_dir = File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'test/unit'
require 'contest'
$LOAD_PATH.unshift lib_dir unless $:.include?(lib_dir)
require 'solution'

module Snape
  
  class SnapeChallengeSolutiionTest < Test::Unit::TestCase
    describe "choose your doom" do

      setup do
        @solution = Solution.new
      end

      test "whether you live or die" do
        assert_live @solution.my_choice.drink
      end

      test "whether you move forward" do
        assert_advance @solution.my_choice.drink
      end
      
    end
  end
end