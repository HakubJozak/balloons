class Chingu::Viewport
  def w
    $window.width
  end

  def h
    $window.height
  end


  def x_range
    (@x..(@x + w))
  end

  def y_range
    (@y..(@y + h))
  end

end


class Field < Chingu::BasicGameObject

  @@max = 100
  @@min = 0

  def setup
    @viewport = @options[:viewport]
    @arrow = sketch_arrow
    @angle = 0
  end

  def update
    # only for dynamic fields
  end

  def value(x,y)
    [ (0.002 * (x - 1000)) , (0.002 * (y - 600))  ]
  end

  def intensity_color(value)
    i = (255 / (@@max - @@min)) * value
    i = i > 255 ? 255 : i
    i = i < 1 ? 0 : 1
  end

  def draw
    @viewport.apply do
      @viewport.y_range.step(50).each do |y|
        @viewport.x_range.step(50).each do |x|
          vx,vy = value(x,y)
          r = vx * vx + vy * vy
          color = Gosu::gray # Gosu::Color.rgba(intensity_color(r),0,0,255)

          @center_x = 0.5
          @center_y = 0.5
          @zorder = 0

          factor = 1.0

          angle = if vx == 0  && vy  == 0
                    0
                  else
                    (Math::atan2(vy, vx) - Math::PI/2).radians_to_gosu
                  end

          @arrow.draw_rot(x, y, @zorder, angle, @center_x, @center_y, factor, factor, color)
        end
      end
    end
  end

  private


  def sketch_arrow
    canvas = Magick::Image.new(21, 11)  { |i| i.background_color = 'transparent' }
    gc = Magick::Draw.new

    gc.stroke('white')
    gc.stroke_width(2)
    gc.line(0,5,20,5)
    gc.line(15,0, 20,5)
    gc.line(15,10,20,5)
    gc.draw(canvas)

    Gosu::Image.new($window, canvas, false)
  end


end
