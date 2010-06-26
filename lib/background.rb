class Background < Chingu::BasicGameObject
  trait :sprite, :image => 'landscape.png'

  def initialize(opts = {})

    opts[:center_x] = 0
    opts[:center_y] = 1.0
    opts[:y] = 1200
    super(opts)    
  end


end
