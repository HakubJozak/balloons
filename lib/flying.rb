class Flying < Chingu::GameState

  trait :viewport

  def initialize(options = {})
    super(options)
    @balloon = Balloon.create( :x => 200, :y => 400)
    @background = Background.create
  end

  def setup
    self.input =  {
      :escape => :exit,
      :holding_d => :camera_right,
      :holding_a => :camera_left
    }

    self.viewport.game_area = [0,0,1200,1200]
    self.viewport.lag = 0.9
  end

  def camera_right
    self.viewport.x_target += 50
  end

  def camera_left
    self.viewport.x_target -= 50
  end

  def draw
    fill(:from => Gosu::white, :to => Gosu::black)
    super
  end

  def to_s
    self.viewport.to_s
  end

  def update
    self.viewport.center_around(@balloon)
    super
  end

end
