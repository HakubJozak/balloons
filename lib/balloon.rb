class Point
  attr_accessor :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end
end

def vec(x,y)
  Point.new(x,y)
end


class Balloon < Chingu::BasicGameObject

  attr_accessor :x, :y

  include Chingu::Helpers::InputClient

  def initialize(opts = {})
    super(opts)
    values = [ :left, :right, :up, :down ]
    keys = values.map { |v| "holding_#{v.to_s}".to_sym }
    self.input = Hash[*keys.zip(values).flatten]

    @velocity = 10

    @radius = 30
    @p = vec(0.0,0.0)
    @v = vec(0.0,0.0)


    stub = EmptyImageStub.new(60,120)
    @image = Gosu::Image.new($window,stub,true)

    string_color = [ 0.2, 0.3, 0.3 , 0.5 ]
    balloon_color = :red # :random

    @image.paint do
      fill 0,0, :color => :white

      # radius of the balloon
      r = 30

      # height
      h = 3.5 * r

      # basket size
      b = 5

      # string count
      s = 5

      circle r - 1, r - 1, r, :color => balloon_color, :fill => true
      rect r - b, h - b*2 - 1, r + b, h - 1, :color => balloon_color, :fill => true

      right = vec( r + b, h - b * 2 - 1 )
      left = vec( r - b, h - b * 2 - 1 )



      s.times do

      end
      line left.x, left.y, 0, r, :color => string_color
      line right.x, right.y, 2*r - 1, r, :color => string_color
    end
  end


  def draw
    @image.draw(@p.x, @p.y, 0)
  end

  def update
  end

  def to_s
    "X:#{@x} Y:#{@y}"
  end

  def left
    @x -= @vx
  end

  def right
    @x += @vx
  end

  def up
    @y -= @velocity
  end

  def down
    @y += @velocity
  end

end
