$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require 'finitefield'

class BasicTest < Test::Unit::TestCase

  def setup
    @field = FiniteField.new(8, 0x11D)
  end
  
  def test_get_polynomial
    assert_equal(0x11D, @field.polynomial)
  end

  def test_degree
    assert_equal(8, @field.degree(0x11D))
  end
  
  def test_binary_mul
    assert_equal(0xa95, @field.binary_mul(0x53, 0x23))
  end
  
  def test_binary_div
    assert_equal([5, 4], @field.binary_div(0x11b, 0x53))
  end
end


