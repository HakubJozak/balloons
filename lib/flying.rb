class Flying < Chingu::GameState

  trait :viewport

  def initialize(options = {})
    super(options)
    @balloon = Balloon.create( :x => 200, :y => 400)
  end

  def setup
    self.input =  {
      :escape => :exit,
      :holding_d => :camera_right,
      :holding_a => :camera_left
    }

#    self.viewport.game_area = [0,0,1200,1200]
    self.viewport.lag = 0.9
  end

  def camera_right
    self.viewport.x_target += 50
  end

  def camera_left
    self.viewport.x_target -= 50
  end

  def draw
    fill(:from => Gosu::gray, :to => Gosu::black)
    @balloon.draw
    super
  end

  def to_s
    self.viewport.to_s
  end

  def update
#    self.viewport.center_around()
#    viewport
    super
  end

end
