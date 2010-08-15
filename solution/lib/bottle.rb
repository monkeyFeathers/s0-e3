module Trap
  class PotionError < StandardError
  end
  
  class Bottle
    attr_writer :contents
    
    def initialize
    end
    
    def contents
      @contents.class
    end
    
    def empty?
      @contents == nil
    end
    
    def empty
      @contents = nil
    end
    
    def potion_error(contents)
      raise Trap::PotionError, "#{self.class} cannot contain #{contents.class}"
    end
    
    def what_cannot_be(contents, *forbidden_potions)
      forbidden_potions.each do |potion|
        if contents.class == potion
          potion_error contents
        end
      end
      @contents = contents
    end
    
  end
###############################################################################
# bottles by size in table arrangement
##############################################################################

  class SmallBottle < Bottle
    def contents=(contents)
      what_cannot_be contents, Potion::MoveForward, Potion::NettleWine
    end
  end
  
  class LargeBottle < Bottle
    def contents=(contents)
      what_cannot_be contents, Potion::MoveForward, Potion::MoveBackward
    end
  end
  
  class SmallestBottle < Bottle
    def contents=(contents)
      what_cannot_be contents, Potion::Poison
    end
  end
  
  class MediumLargeBottle < Bottle
  end
  
  class MediumSmallBottle < Bottle
  end
  
  class LargestBottle < Bottle
    def contents=(contents)
      what_cannot_be contents, Potion::Poison, Potion::MoveForward, Potion::MoveBackward
    end
  end
  
  class MediumBottle < Bottle
    def contents=(contents)
      what_cannot_be contents, Potion::MoveForward
    end
  end

end