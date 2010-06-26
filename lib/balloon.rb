class Balloon < Chingu::GameObject

  trait :velocity
  trait :sprite, :image => lambda { draw_ball }
  
  include Chingu::Helpers::InputClient

  def initialize(opts = {})
    super(opts)
    keys = [ :left, :right, :up, :down ]
    self.input = Hash[*keys.zip(keys).flatten]
  end

 
  def left
    @velocity_x = -2.5
  end

  def right
    @velocity_x = 2.5
  end

  def up
    @velocity_y = 5    
  end

  def down
    @velocity_y = -5    
  end

  private
  
  def self.draw_ball
    r = 40
    image = TexPlay.create_image($window, r*2, r*2)
    image.paint { circle(r,r,r, :color => :white, :fill => true) }
    image
  end
  

end
