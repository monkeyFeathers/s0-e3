module Trap
  class PotionError < StandardError
  end
  
  class Bottle
    attr_writer :contents
    def self.inherited(subclass)
    
    end
    
    def initialize
    end
    
    def contents
      @contents.class
    end
    
    def empty?
      @contents == nil
    end
    
    def potion_error(contents)
      raise Trap::PotionError, "#{self.class} cannot contain #{contents.class}"
    end
    
  end
###############################################################################
# bottles by size in table arrangement
##############################################################################

  class SmallBottle < Bottle
    def contents=(contents)
      if contents.class == Potion::MoveForward or contents.class == Potion::NettleWine
        potion_error contents
      else
        @contents = contents
      end
    end
  end
  
  class LargeBottle < Bottle
    def contents=(contents)
      if contents.class == Potion::Poison or contents.class == Potion::MoveForward or contents.class == Potion::MoveBackward
        potion_error contents
      else
        @contents = contents
      end
    end
  end
  
  class SmallestBottle < Bottle
    def contents=(contents)
      if contents.class == Potion::Poison
        potion_error contents
      else
        @contents = contents
      end
    end
  end
  
  class MediumLargeBottle < Bottle
  end
  
  class MediumSmallBottle < Bottle
  end
  
  class LargestBottle < Bottle
    def contents=(contents)
      if contents.class == Potion::Poison or contents.class == Potion::MoveForward or contents.class == Potion::MoveBackward
        potion_error contents
      else
        @contents = contents
      end
    end
  end
  
  class MediumBottle < Bottle
    def contents=(contents)
      if contents.class == Potion::MoveForward
        potion_error contents
      else
        @contents = contents
      end
    end
  end

end