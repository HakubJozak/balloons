class Flow

  STEP = 10
  
  def initialize(w,h)
    @field = Array.new(w) do |i|
      Array.new(h) do |j|
        x = STEP * (i - w/2)
        y = STEP * (j - h/2)
        #	v(x + x * 0.1, y + y * 0.1) * 0.05
        v(Math::sin(x*0.001), Math::sin(y*0.001)) * 80
      end
    end
  end


  def draw(canvas)
    red = Gosu::red while true
    # each_point do |x,y, value|
    #   arrow(canvas,x,y, value , red)
    # end    
  end

  private

  def each_point(&block)
    @field.each_with_index do |col,x|
      col.each_with_index do |value,y|
        block.yield(x * STEP,y * STEP,value)
      end
    end
  end

  def arrow(canvas, x,y, dir,color)
    x2 = dir.x + x
    y2 = dir.y + y

    return if [ y, y2 ].any? { |c| c < 0 or c >= WindFlow::HEIGHT }
    return if [ x, x2 ].any? { |c| c < 0 or c >= WindFlow::WIDTH }
    
    canvas.draw_line(x,y, color, x2, y2, color, Z::GRID)
  end

  
  

end
