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
    @image = sketch_balloon 100 # Random::rand(40) + 40

    @p = Point.new(@options[:x], @options[:y])
    # @p = Point::random(200,200)
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
  def sketch_balloon(radius, balloon_color = 'orange', basket_color = 'brown')
    w, h = radius * 2 + 1, radius * 4 + 1

    pen = Magick::Draw.new

    string_color = 'gray'

    # radius of the balloon
    r = radius

    # height
    h = 3.5 * r

    # basket size
    b = r / 6

    # string count
    s = 6

    # balloon
    pen.stroke_width(2)
    pen.stroke('black')
    pen.fill(balloon_color)
    pen.circle r - 1, r - 1, r, 2

    # basket
    pen.stroke('gray')
    pen.stroke_width(1)
    pen.fill(basket_color)
    pen.roundrectangle r - b, h - b*2 - 1, r + b, h - 1, 5, 5

    # upper string
    pen.line 0, r, 2*r, r

    y = h - b * 2 - 1
    lower = r - b
    lstep = (2.0 * b) / s
    upper = 0
    ustep = (2.0 * r) / s

    # vertical strings
    (s + 1).times do |i|
      pen.line lower, y, upper, r
      upper += ustep
      lower += lstep
    end

    canvas = Magick::Image.new(2*r, h, Magick::HatchFill.new('transparent','transparent'))
    canvas.background_color = 'red'
    pen.draw(canvas)

    Gosu::Image.new( $window, canvas, false)
  end
end
