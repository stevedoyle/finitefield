
# Finite fields of characteristic 2

class FiniteField
  attr_reader :polynomial
  
  def initialize(polynomial)
    @polynomial = polynomial
  end
  
  # Adds two finite field elements and returns the result.
  def add(lhs, rhs)
    # In characteristic two fields, addition is the xor operation.
    lhs ^ rhs
  end  
  
  # Subtracts the second argument from the first and return the
  # result. In fields of characteristic two this is the same as 
  # the add method.
  def subtract(lhs, rhs)
    add(lhs, rhs)
  end

  # Find the degree of the polynomial representing the input field
  # element v.  This takes O(degree(v)) operations. 
  def degree(v)
    if v
      result = -1
      while v != 0
        v >>= 1
        result += 1
      end
      return result
    end
    return 0
  end
  
end
