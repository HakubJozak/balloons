class Landscape < Chingu::Parallax

  def initialize(opts = {})
    super(:x => 0, :y => 0, :rotation_center => :top_left)
    add_layer(:image => "background.png", :damping => 20, :repeat_y => false)
    add_layer(:image => "landscape.png", :damping => 5, :repeat_y => false)    
  end

  def setup
    self.input = { :holding_left => :camera_left, :holding_right => :camera_right }
  end

  def camera_left
    self.camera_x -= 7
  end
  
  def camera_right
    self.camera_x += 7
  end

  def draw_relative(x=0, y=0, zorder=0, angle=0, center_x=0, center_y=0, factor_x=0, factor_y=0)
    draw
  end  

end
