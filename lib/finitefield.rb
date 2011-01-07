# = finitefield.rb - Finite Field Arithmetic
#
# Copyright (C) 2008  Stephen Doyle
#
# == Features
# finitefield.rb currently supports arithmetic in finite fields of characteristic 2.
#
# The following operations are supported:
# * Addition
# * Subtraction
# * Multiplication
# * Division
# * Inverse
# * Reduction
# * Binary multiplication
# * Binary division
#
# == Example
#
#  # Create a field
#  field = FiniteField.new(8, 0x169)  # <== F(2^8) with polynomial: 0x169
#  # Addition
#  result = field.add(7, 8)
#  # Subtraction
#  result = field.subtract(8, 5)
#  # Multiplication
#  result = field.multiply(9, 87)
#  # Division
#  result = field.divide(87, 9)   # <==  result = 87/9
#  # Inverse
#  result = field.inverse(31)
#

class FiniteField
  attr_reader :polynomial
  
  # Create a field of GF(2^n) using the specified generator polynomial
  def initialize(n, polynomial)
    @polynomial = polynomial
    @n = n
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
  
  # Multiplies two field elements, modulo the generator polynomial
  # and returns the result.
  def multiply(a, b)
    m = multiplyWithoutReducing(a, b)
    reduce(m)
  end
  
  # Multiply two field exlements without modulo with the generator 
  # polynomial.
  def multiplyWithoutReducing(a, b)
    result = 0
    mask = 1
    i = 0
    
    while i <= @n
      if mask & b != 0
        result ^= a
      end
      a <<= 1
      mask <<= 1
      i += 1
    end
    
    return result
  end
  
  # Reduce the input value by modulo with the generator polynomial, i.e. result = a % polynomial.
  def reduce(a)
    result = 0
    i = degree(a)
    mask = 1 << i
    
    while i >= @n
      if mask & a != 0
        result ^=  1 << (i - @n)
        a = subtract(a, @polynomial << (i - @n))
      end
      i -= 1
      mask >>= 1
    end
    return a
  end
  
  # Computes the multiplicative inverse of the element and returns 
  # the result.
  def inverse(a)
    remainder = [0,0,0]
    quotient = [0,0,0]
    auxillary = [0,0,0]
    
    remainder[1] = @polynomial
    remainder[2] = a
    auxillary[1] = 0
    auxillary[2] = 1
    i = 2
    
    while(remainder[i] > 1)
      i += 1
      result = binary_div(remainder[i-2], remainder[i-1])
      remainder[i] = result[1]
      quotient[i] = result[0]
      auxillary[i] = binary_mul(quotient[i], auxillary[i-1]) ^ auxillary[i-2]
    end
    
    return auxillary[i]
  end
  
  # Division of two field elements (lhs/rhs). This is the same as
  # lhs * rhs^-1 i.e. multiply(lhs, inverse(rhs))
  def divide(lhs, rhs)
    multiply(lhs, inverse(rhs))
  end

  # Find the degree of the polynomial representing the input field
  # element v.  This takes O(degree(v)) operations. 
  #
  # Example: degree(0x141) = 8  ==> 0x141 = x^8 + x^6 + 1
  def degree(v)
    if v != 0
      result = -1
      while v != 0
        v >>= 1
        result += 1
      end
      return result
    end
    return 0
  end
  
  # Binary multiplication. Or more explicitly - multiplication over a binary field.
  def binary_mul(lhs, rhs)
    result = 0
    a = [degree(lhs), degree(rhs)].max
    0.upto(a) do |i|
      if lhs & (1 << i) != 0
        result ^= rhs
      end
      rhs <<= 1
    end
    return result
  end

  # Binary division. Or more explicitly - division over a binary field.
  def binary_div(lhs, rhs)
    q = 0
    r = lhs
    p1 = degree(lhs)
    p2 = degree(rhs)
    
    (p1 - p2 + 1).downto(0) do |i|
      q <<= 1
      if r & (1 << (p2+i)) != 0
        q |= 1
        r ^= (rhs << i)
      end
    end
    return [q, r]
  end

end

