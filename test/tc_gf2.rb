$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require 'finitefield'

class GF2Test < Test::Unit::TestCase

  def setup
    @field = FiniteField.new(0x11D)
  end
  
  def test_gf2_addition_success
    assert_equal(3, @field.add(0x1, 0x2))
  end

  def test_gf2_subtraction_success
    assert_equal(1, @field.subtract(0x3, 0x2))
  end

end


