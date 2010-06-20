module Kernel
  def v(x,y)
    CP::Vec2.new(x,y)
  end  
end


module Z
  GRID = 100
end

class WindFlow < Gosu::Window

  include Singleton

  WIDTH = 640
  HEIGHT = 480
  
  def initialize
    super(WIDTH, HEIGHT, false)
    @flow = Flow.new(WIDTH/Flow::STEP, HEIGHT/Flow::STEP)
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
