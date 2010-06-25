#!/usr/bin/env ruby




class Flying < Chingu::GameState

  trait :viewport
    
  def initialize(options = {})
    super
    @baloon = Balloon.create( :x => 200, :y => 200)
  end

  def setup
    self.input =  { :escape => :exit  }
    self.viewport.lag = 0.1                           # 0 = no lag, 0.99 = a lot of lag.
    self.viewport.game_area = [0, 0, 1000, 1000]    # Viewport
  end
  
end


class Game < Chingu::Window
  def initialize
    super(800,600)
    self.caption = "Chingu::Parallax example. Scroll with left/right arrows. Space for new parallax example!"
    switch_game_state(Flying)
  end
end
