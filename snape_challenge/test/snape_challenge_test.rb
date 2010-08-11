lib_dir = File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'test/unit'
require 'contest'
$LOAD_PATH.unshift lib_dir unless $:.include?(lib_dir)
require 'snape_challenge'

module Snape
  
  class SnapeChallengeTest < Test::Unit::TestCase
  
    describe "these clues four:" do
  
      setup do
        @snape_challenge = SnapeChallenge.new
        @snape_challenge.snape_mode = true
        @bottles = @snape_challenge.bottles
      end
  
      teardown do
        @snape_challenge.snape_mode = false
      end
      describe "First, however slyly the poison tries to hide/ You will always find some on nettle wine's left side" do
        
      
        test "nettle wine's left side" do
          @bottles.each do |bottle|
            if bottle.contains? NettleWine
              assert bottle.left.contains? Poison
            end
        end
        
      end
      
      describe "Second, different are those who stand at either end/ But if you would move onward, neither is your friend" do
      
        test "different are those who stand at either end" do
          assert_different @bottles.last.contents, @bottles.first.contents
        end
      
        test "But if you would move onward, neither is your friend" do
          assert_different @bottles.last.contents, Key
          assert_different @bottles.first.contents, Key
        end
        
      end
      
      describe "Third as you see clearly, all are different size/ Neither dwarf nor giant hold death in their insides;" do
      
        test "all are different size" do
          @bottles.each do |bottle|
            assert_unique bottle.size
          end
        end
        
        test "Neither dwarf nor giant hold death in their insides" do
          assert_different @bottles.smallest, Poison
          assert_different @bottles.largest, Poison
        end
      
      end
      
      describe "Fourth, the second left and the second on the right/ Are twins once you taste them, though different at first sight." do
        
        test "the second left and the second on the right/ Are twins" do
          assert_same @bottles.first.left, @bottles.last.right
        end
        
      end
      
    end
  
  end
  
  
  
end