require "potion"
require "bottle"

class TrapArrangement < Array
  
  def smallest
    smallest_bottle = ""
    self.each do |bottle|
      if bottle.class == Trap::SmallestBottle
        smallest_bottle = bottle
      end
    end
    smallest_bottle
  end
  
  def largest
    largest_bottle = ""
    self.each do |bottle|
      if bottle.class == Trap::LargestBottle
        largest_bottle = bottle
      end
    end
    largest_bottle
  end
  
  def left_side_of(bottle)
    left = self.index(bottle) -1
    self[left]
  end
  def right_side_of(bottle)
    right = self.index(bottle) + 1
    self[right]
  end
end

module Trap
  
  class Table
    attr_accessor :bottles, :potions
    
    class NettleWinesLeftError < StandardError
    end
    
    def initialize
      @potions =  [Potion::Poison.new,
                  Potion::Poison.new,
                  Potion::Poison.new,
                  Potion::MoveForward.new, 
                  Potion::MoveBackward.new, 
                  Potion::NettleWine.new,
                  Potion::NettleWine.new]
      
      @bottles =  TrapArrangement.new
      bottles =   [Trap::SmallBottle.new,
                  Trap::LargeBottle.new,
                  Trap::SmallestBottle.new,
                  Trap::MediumLargeBottle.new,
                  Trap::MediumSmallBottle.new,
                  Trap::LargestBottle.new,
                  Trap::MediumBottle.new]
              
      bottles.each do |bottle|
        @bottles << bottle
      end
      
      pour_potions @bottles, @potions.dup
      
      until nettle_wines_left_side?
        nettle_wine
      end
      
    end # initialize
    
    def pour_potions(bottles, potions)
      # while any_bottles_empty?
        bottles.each do |bottle|
          if bottle.empty?
            potions.each do |potion|
              begin
                bottle.contents = potion
                potions.delete potion
                break
              rescue Trap::PotionError
                next
              end # begin
            end # each potion
          else
            next
          end
        end # each bottle
      # end
    end
    
    def any_bottles_empty?
      empties = false
      @bottles.each do |bottle|
        unless bottle.contents
          empties = true
        end
      end
      empties
    end
    
    def nettle_wines_left_side?
      nettle_wines = []
      @bottles.each do |bottle|
        if bottle.contents == Potion::NettleWine
          nettle_wines << bottle
        end
      end
      @bottles.left_side_of(nettle_wines[0]).contents == Potion::Poison and @bottles.left_side_of(nettle_wines[1]).contents == Potion::Poison
    end
    
    def nettle_wine
      @potions << @potions.shift
      potions = @potions.dup
      @bottles.first.contents
      bottles = @bottles[1..6]
      
      potions.each do |potion|
        if potion.class == @bottles.first.contents
          potions.delete potion
          break
        end
      end
      
      bottles.each do |bottle|
        bottle.empty
      end
      pour_potions bottles, potions
    end
    
    def twins
    end
    
  end
  
end