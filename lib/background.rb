class Background < Chingu::BasicGameObject

  trait :sprite, :image => 'landscape.png'

  def initialize(opts = {})
    opts[:center_x] = 0
    opts[:center_y] = 0
    opts[:x] = 0
    opts[:y] = 600
    super(opts)
  end 

  def to_s
    "X:#{@x} Y:#{@y}"    
  end
  
end
