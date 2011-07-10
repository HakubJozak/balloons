class Background < Chingu::GameObject
  def setup
    # fill = Magick::HatchFill.new('white','cyan')
    @x = 0
    @y = 0

    fill = Magick::GradientFill.new(0, 0, 1200, 0, 'white', 'gray')
    canvas = Magick::Image.new(1200,1200, fill)
    @image = Gosu::Image.new( $window, canvas, false)
  end
end


class Flying < Chingu::GameState

  trait :viewport

  def setup
    self.input =  {
      :escape => :exit,
    }

    self.viewport.game_area = [0,0,1200,1200]
    self.viewport.lag = 0

    puts "area #{self.viewport.game_area}"


    Background.create

    @balloons = (1..20).to_a.map do
      Balloon.create(:x => Random::rand(1200),
                     :y => Random::rand(1200),
                     :z => Random::rand() + 0.2,
                     :balloon_color => Random::palette_color)
    end

    @balloons.sort_by &:z

    @mouse = Mouse.create(:viewport => @viewport)
  end


  def draw
    super
    @mouse.draw
  end

  def to_s
    self.viewport.to_s
  end

  def update
#    @mouse.update
#    @balloons.each { |b| b.update }
    super
  end

end
