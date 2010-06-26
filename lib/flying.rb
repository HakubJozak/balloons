class Flying < Chingu::GameState

  trait :viewport, :x => 0, :y => 600,:game_area => [0,0,7000,600], :lag => 0.95 
    
  def initialize(options = {})
    super
    @balloon = Balloon.create( :x => 200, :y => 200)
    @background = Background.create
  end

  def setup
    self.input =  { :escape => :exit, :holding_d => :camera_right, :holding_a => :camera_left  }    
  end

  def camera_right
    self.viewport.x_target += 50
  end

  def camera_left
    self.viewport.x_target -= 50    
  end

  def update
    self.viewport.center_around(@balloon)
    super
  end
  
end
