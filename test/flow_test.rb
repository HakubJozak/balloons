require './test/test_helper'
require './lib/flow.rb'

class CP::Vec2
  def ==(other)
    x == other.x and y == other.y
  end
end

module Kernel
  def v(x,y)
    CP::Vec2.new(x,y)
  end
end



class FlowTest <  MiniTest::Unit::TestCase
  
  def setup
    @flow = Flow.new(20,20) do |x,y|
      CP::Vec2.new(x,y)
    end
  end

  def test_zero_flow
    f = Flow.new(5,6)
    assert_equal 5, f.width
    assert_equal 6, f.height
  end

  def test_invalid_flow
    assert_raises(ArgumentError) { Flow.new(-1, 5) }
  end

  def test_normal_access
    assert_raises(TypeError) { @flow[:bottom, 0] }
    assert_raises(TypeError) { @flow[0, 0.2] }
  end

  def test_flawless_borders
    zero = CP::Vec2.new(0,0)
    assert_equal zero, @flow[-2,10]
    assert_equal zero, @flow[-2,-10]
    assert_equal zero, @flow[32,30]
  end

  # TODO - shoulda and context with two fields
  def test_adding_flow
    f1 = Flow.new(10,5) { v(1,1) }
    f2 = Flow.new(2,2) { v(2,4) }
    f1.add!(f2)
    assert_equal v(3,5), f1[0,0]
    assert_equal v(1,1), f1[5,4]
  end

  def test_adding_flow_with_offset
    f1 = Flow.new(10,5) { v(1,1) }
    f2 = Flow.new(2,2) { v(2,4) }
    f1.add!(f2, 9, 4)
    assert_equal v(1,1), f1[0,0]
    assert_equal v(0,0), f1[10,5]
    assert_equal v(3,5), f1[9,4]
  end


end
