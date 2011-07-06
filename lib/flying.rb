class Flying < Chingu::GameState

#  trait :viewport

  def setup
    self.input =  {
      :escape => :exit,
      :holding_d => :camera_right,
      :holding_a => :camera_left
    }

#    self.viewport.game_area = [0,0,1200,1200]
 #   self.viewport.lag = 0.9

    @balloons = (1..10).to_a.map do
      Balloon.new( { :x => 100, :y => 100 })
    end
  end

  def camera_right
#    self.viewport.x_target += 50
  end

  def camera_left
   # self.viewport.x_target -= 50
  end

  def draw
    fill(:from => Gosu::white, :to => Gosu::gray)
    @balloons.each { |b| b.draw }
    super
  end

  def to_s
    # self.viewport.to_s
  end

  def update
    # self.viewport.center_around()
    # viewport
    @balloons.each { |b| b.update }
    super
  end

end
