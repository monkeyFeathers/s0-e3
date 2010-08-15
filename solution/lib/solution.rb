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
      
      pour_potions @bottles, @potions
    end # initialize
    
    def pour_potions(bottles,potions)
      bottles.each do |bottle|
        potions.each do |potion|
          begin
            bottle.contents = potion
            potions.delete potion
            break
          rescue Trap::PotionError
            next
          end
        end
      end
    end
    
  end
  
end