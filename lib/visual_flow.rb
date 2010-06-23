class VisualFlow

  attr_accessor :flow, window
  
  def initialize(window, flow)
    @window, @flow = window, flow
  end


  def draw(canvas)
    red = Gosu::red
    @flow.each_point do |x,y, value|
      arrow(canvas,x,y, value , red)
    end    
  end

  
  def arrow(canvas, x,y, dir,color)
    x2 = dir.x + x
    y2 = dir.y + y

    return if [ y, y2 ].any? { |c| c < 0 or c >= WindFlow::HEIGHT }
    return if [ x, x2 ].any? { |c| c < 0 or c >= WindFlow::WIDTH }

    l = dir.length
    canvas.draw_line(x,y, color, x2, y2, color, Z::GRID)

    if (l > 0)
      scale = l *0.05
      @arrow_img.draw_rot( x2, y2, Z::GRID,
                           (dir.to_angle + Math::PI/2).radians_to_gosu,
                           0.5,0.5,scale,scale,color)
      end
  end
  
end
