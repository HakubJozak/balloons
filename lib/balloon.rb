class Balloon < Chingu::BasicGameObject

  trait :sprite, :image => 'balloon-small.png'

  include Chingu::Helpers::InputClient

  def initialize(opts = {})
    super(opts)
    values = [ :left, :right, :up, :down ]
    keys = values.map { |v| "holding_#{v.to_s}".to_sym }
    self.input = Hash[*keys.zip(values).flatten]
    @speed = 10
  end

  def to_s
    "X:#{@x} Y:#{@y}"
  end

  def left
    @x -= @speed
  end

  def right
    @x += @speed
  end

  def up
    @y -= @speed
  end

  def down
    @y += @speed
  end

end
