module Z
  GRID = 100
end

class WindFlow < Gosu::Window

  include Singleton

  WIDTH = 640
  HEIGHT = 480
  
  def initialize
    super(WIDTH, HEIGHT, false)
    @flow = Flow.new(self, WIDTH/Flow::STEP, HEIGHT/Flow::STEP)

    f2 = Flow.new(self, WIDTH/Flow::STEP, HEIGHT/Flow::STEP) do |x,y|      
      v(x,y)
    end

    @flow.add(f2)
      
    #  v(x + x * 0.1, y + y * 0.1) * 0.05
    #  v(Math::sin(x*0.001), Math::sin(y*0.001)) * 80
  end
  
  def button_down(key)
    close if key == Gosu::KbEscape
  end
  
  def draw
    c = Gosu::white
    draw_quad(0,0,c,
              WIDTH,0,c,
              WIDTH, HEIGHT, c,
              0,HEIGHT,c)

    clip_to(0,0,WIDTH,HEIGHT) do
      @flow.draw(self)
    end
  end


end
