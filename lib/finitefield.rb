
class FiniteField
  attr_reader :polynomial
  
  def initialize(polynomial)
    @polynomial = polynomial
  end
  
  def add(lhs, rhs)
    lhs ^ rhs
  end  
  
  class Util
    def degree
      deg = -1 # TODO
      temp = @polynomial
      while(temp != 0)
        deg += 1
        temp >>= 1
      end
      return deg
    end
  end
  
end
