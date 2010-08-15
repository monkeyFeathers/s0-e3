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
    
    def twins
      # check if second left and second from the right are the same
      # if not, make them the same
      if @bottles[1] != @bottles[5]
        # g
        bottles = @bottles[2..6]
        potions = []
        bottles.each do |bottle|
          potions << bottle.contents.new
        end
        potions.each do |potion|
          if potion.class == @bottles[1].contents
            @bottles[5].contents = potion
            potions.delete(potion)
            break
          end
        end
        # set bottles to be the remaining bottles
        bottles = @bottles[2..4]
        bottles << @bottles[6]
        
        # find homes for the rest
        pour_potions bottles, potions
      end
    end
    
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