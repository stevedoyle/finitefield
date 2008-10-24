$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require 'finitefield'

class GF2Test < Test::Unit::TestCase

  def setup
    @field = FiniteField.new(8, 0x11D)
  end
  
  def test_gf2_addition_success
    assert_equal(3, @field.add(0x1, 0x2))
  end

  def test_gf2_subtraction_success
    assert_equal(1, @field.subtract(0x3, 0x2))
  end
  
  def test_gf2_multiplication_success
    assert_equal(0x6 , @field.multiply(0x3, 0x2))
    assert_equal(0xc9 , @field.multiply(0xab, 0x11))
    assert_equal(0x01, @field.multiply(0x8c, 0x53))
  end

  def test_gf2_inverse_success
    f = FiniteField.new(8, 0x11B)
    assert_equal(0xca, f.inverse(0x53))
    assert_equal(0x8c, @field.inverse(0x53))
  end

  def test_gf2_division_success
    assert_equal(0x11 , @field.divide(0xc9, 0xab))
  end

end


