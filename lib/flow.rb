require 'chipmunk'

class Flow

  attr_reader :width, :height

  STEP = 20
  ZERO = CP::Vec2.new(0,0).freeze

  def initialize(w,h, &field_equation)
    raise TypeError.new('Dimensions must be Fixnum') unless Fixnum === w and Fixnum === h
    raise ArgumentError.new('Dimensions has to be positive') unless w>0 and h>0

    @width, @height = w, h

    @cols = Array.new(w) do |x|
      Array.new(h) do |y|
        if field_equation
          field_equation.yield(x,y)
        else
          CP::Vec2.new(0,0)
        end
      end
    end
  end

  def [](x,y)
    raise TypeError, "Expected integer" unless [x,y].all? { |a| Integer === a }

    if x < 0 or y < 0 or x >= @width or y >= @height
      ZERO
    else
      @cols[x][y]
    end
  end


  # To each vector is added a corresponding vector from the second
  # flow.
  #
  def add!(f2, x_offset = 0, y_offset = 0)
    raise TypeError, "Expected another flow" unless f2.kind_of?(Flow)

    # Does not have to check dimensions - see Flow#[] for details.
    x_offset.upto(@width-1) do |x|
      y_offset.upto(@height-1) do |y|
        value = @cols[x][y]
        o = f2[x - x_offset, y - y_offset]
        value.x += o.x
        value.y += o.y
      end
    end
  end

  protected

  attr_reader :cols

  private

  def each_point(&block)
    @cols.each_with_index do |col,x|
      col.each_with_index do |value,y|
        block.yield(x * STEP,y * STEP,value)
      end
    end
  end





end
