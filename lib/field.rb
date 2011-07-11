class Field < Chingu::BasicGameObject

  @@max = 1000
  @@min = 0

  def setup
    @arrow = sketch_arrow
    @angle = 0
  end

  def update
    # only for dynamic fields
  end

  def value(x,y)
    [ x - 500 , y*2 - 350  ]
  end

  def intensity_color(value)
    (255 / (@@max - @@min)) * value
  end

  def draw
    (0..768).step(50).each do |y|
      (0..1024).step(50).each do |x|

        vx,vy = value(x,y)
        r = vx^2 + vy^2
        color = Gosu::Color.rgba(intensity_color(r),0,0,255)

        @center_x = 0.5
        @center_y = 0.5
        @zorder = 0

        factor = 1.0

        angle =  (Math::atan2(vy, vx)).radians_to_gosu # Math::PI/2
        @arrow.draw_rot(x, y, @zorder, angle, @center_x, @center_y, factor, factor, color)
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
