class Point

  attr_accessor :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def self.random(bound_x, bound_y)
    Point.new( Random::rand(bound_x), Random::rand(bound_y) )
  end

end

def vec(x,y)
  Point.new(x,y)
end


class Balloon < Chingu::BasicGameObject

  include Chingu::Helpers::InputClient

  def initialize(opts = {})
    super(opts)
  end

  def setup
    @velocity = 10
    sketch_balloon(Random::rand(40) + 40)

    puts options

    #    @p = Point.new(@options[:x], @options[:y])
    @p = Point::random(800, 600)
    @v = Point.new(Random::rand * 0.2,0.0)
  end

  def x
    @p.x
  end

  def y
    @p.y
  end


  def draw
    @image.draw(@p.x, @p.y, 0)
  end

  def update
    @p.x += @v.x
    @p.y += @v.y
  end

  def to_s
    "Balloon(#{@x},#{@y})"
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

  private


  # TODO: chingu raises an exception otherwise investigate when @image
  # is not generated directly - maybe TexPlay just in time drawing issue.
  #
  def sketch_balloon(radius, balloon_color = :random, basket_color = :brown)
    w, h = radius * 2 + 1, radius * 4 + 1
    stub = TexPlay::create_image($window, w*2 ,h * 2)
    @image = Gosu::Image.new( $window, stub, false)

    string_color = [ 0.2, 0.3, 0.3 , 0.5 ]

    return
    @image.paint do
      #fill 0,0, :color => :white

      # radius of the balloon
      r = radius

      # height
      h = 3.5 * r

      # basket size
      b = r / 6

      # string count
      s = 6

      center_x = 20

      # balloon
      circle r - 1 + center_x, r - 1, r, :color => balloon_color, :fill => true
      line 0 + center_x, r, 2*r, r, :color => string_color

      # basket
      rect r - b + center_x, h - b*2 - 1, r + b + center_x, h - 1, :color => basket_color, :fill => true

      # strings
      y = h - b * 2 - 1

      lower = r - b
      lstep = (2.0 * b) / s

      upper = 0
      ustep = (2.0 * r) / s

      (s + 1).times do |i|
        line lower, y, upper, r, :color => string_color
        upper += ustep
        lower += lstep
      end
    end
  end
end
