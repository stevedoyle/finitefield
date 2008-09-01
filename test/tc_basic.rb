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
  
end


