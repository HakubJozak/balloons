class Random
  def self.palette_color
    Balloon::COLORS[ Random::rand(4) ]
  end


  def self.color
    c = (1..3).to_a.map { rand(100) }
    "rgba(#{c[0]}%,#{c[1]}%,#{c[2]}%,100%)"
  end
end


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


class Balloon < Chingu::GameObject

  trait :velocity, :debug => true

  include Chingu::Helpers::InputClient

  attr_accessor :x, :y, :z

  COLORS = [ '#FF2222', "#E4A544","#EB5B12","#555086","#779FDC","#D57D36"].freeze


  def setup
    @@sketches ||= COLORS.map do |color|
      Balloon::sketch_balloon(35, color)
    end.freeze

    @image = @@sketches[Random::rand(@@sketches.size - 1)]

    # z coordinate "origin" is 1.0 (it is in fact scale factor)
    @z = @options[:z] || 1.0

    super
  end

  def draw
    @zorder = @factor_x = @factor_y = @z
    super
  end

  def update
    super
  end

  def to_s
    "Balloon(#{@x},#{@y})"
  end

  private

  def self.contours_pen(r, balloon_color, basket_color)
    pen = Magick::Draw.new
    # TODO: translate x,y

    string_color = 'gray'

    # height
    h = 3.5 * r

    # basket size
    b = r / 6

    # string count
    s = 6

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

    pen
  end


  # TODO: chingu raises an exception otherwise investigate when @image
  # is not generated directly - maybe TexPlay just in time drawing issue.
  #
  def self.sketch_balloon(r, balloon_color, basket_color = 'black')
    w, h = r * 2, r * 4

    mask = Magick::Image.new(w, h)  { |i| i.background_color = 'black' }
    p = Magick::Draw.new
    p.stroke_width(0)
    p.stroke('none')
    p.fill('white')
    p.circle r, r, r, 2
    p.draw(mask)

    c = r / 2
    fill = Magick::GradientFill.new(c,c,c,c , balloon_color, 'transparent')
    grad = Magick::Image.new(2*r, 2*r, fill) { |i| i.background_color = 'transparent' }
    canvas = Magick::Image.new(2*r, h) { |i| i.background_color = 'transparent' }

    canvas.add_compose_mask(mask)
    canvas.composite! grad, 0,0, Magick::HardLightCompositeOp
    canvas.delete_compose_mask

    contours_pen(r, balloon_color, basket_color).draw(canvas)
    Gosu::Image.new( $window, canvas, false)
  end
end
