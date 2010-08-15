lib_dir = File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'test/unit'
require 'contest'
$LOAD_PATH.unshift lib_dir unless $:.include?(lib_dir)
require 'solution'

module Trap
  class SnapesTrapSolutionTest < Test::Unit::TestCase
  # 
  
    
    describe "these clues four" do
      
      setup do
        @trap = Table.new
      end

      describe "first" do
        test "nettle wine's left side" do
          @trap.bottles.each do |bottle|
            if bottle.contents == Potion::NettleWine
              assert_equal Potion::Poison, @trap.bottles.left_side_of(bottle).contents
            end
          end
        end
      end # first
      
      describe "second" do
        test "different are those that stand at either end" do
          assert_not_equal @trap.bottles.first.contents, @trap.bottles.last.contents
        end
        test "but if you would move onward neither is your friend" do
          assert_not_equal @trap.bottles.first.contents, Potion::MoveForward
          assert_not_equal @trap.bottles.last.contents, Potion::MoveForward
        end 
      end # second
      
      describe "third" do
        test "all are differnt size" do
        end
        
        test "neither dwarf nor giant holds death in their insides" do
          assert_not_equal @trap.bottles.smallest.contents, Potion::Poison
          assert_not_equal @trap.bottles.largest.contents, Potion::Poison
        end
      end # third
      
      describe "fourth" do
        test "twins once you taste them" do
          assert_equal @trap.bottles[1].contents, @trap.bottles[5].contents
        end
      end # fourth
      
    end # these clues four
  end # snapes trap solution test
end # snape