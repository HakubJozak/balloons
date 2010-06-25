class Balloon < Chingu::BasicGameObject

  attr_accessor :x, :y

  trait :velocity
  trait :simple_image, :image => 'ball.png'
  
  include Chingu::Helpers::InputClient

  def initialize(opts = {})
    super(opts)
    @x, @y = 0, 0
  end
  
  def setup
    super
     self.input = { :holding_left => :left, :holding_right => :right }
  end

  def update
     super
    # TODO - velocity = 0
  end

  def left
    @velocity_x = -10
  end

  def right
    @velocity_x = 10
  end

  
  
end
