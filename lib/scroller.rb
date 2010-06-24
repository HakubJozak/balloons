#!/usr/bin/env ruby


class Balloon < Chingu::GameObject

  attr_accessor :x, :y
  
  trait :velocity
  trait :timer

  def setup
    @velocity_x = 10
    # every(300) do
    #   @velocity_x = 100 * Math::sin(Gosu::milliseconds * 0.01)
    #   # @velocity_y = 10 * Math::cos(Gosu::milliseconds())
    # end
  end
  
  def draw
    $window.draw_circle(@x,@y,20, Gosu::red)
  end

  def draw_relative(x=0, y=0, zorder=0, angle=0, center_x=0, center_y=0, factor_x=0, factor_y=0)
    $window.draw_circle(@x,@y,20, Gosu::red)    
  end

  def draw_at(x, y)
    $window.draw_circle(@x,@y,20, Gosu::red)    
  end
  
  
end



class Flying < Chingu::GameState

  trait :viewport
  
    
  def initialize(options = {})
    super
    # @parallax = Chingu::Parallax.create(:x => 0, :y => 0, :rotation_center => :top_left)
    # @parallax.add_layer(:image => "background.png", :damping => 20, :repeat_y => false)
    # @parallax.add_layer(:image => "landscape.png", :damping => 5, :repeat_y => false)

    @baloon = Balloon.create( :x => 200, :y => 200)
  end

  def setup
    self.input =  { :holding_left => :camera_left, 
                    :holding_right => :camera_right, 
                    :escape => :exit  }

    self.viewport.lag = 0                           # 0 = no lag, 0.99 = a lot of lag.
    self.viewport.game_area = [0, 0, 1000, 1000]    # Viewport restrictions, full "game world/map/area"  
#    self.viewport.center_around(@baloon)
  end

  
  def camera_left
    @parallax.camera_x -= 7
  end
  
  def camera_right
    @parallax.camera_x += 7
  end  
  
end



class Game < Chingu::Window
  def initialize
    super(800,600)
    self.caption = "Chingu::Parallax example. Scroll with left/right arrows. Space for new parallax example!"
    switch_game_state(Flying)
  end
end
