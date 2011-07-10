MAX_X = 5000
MAX_Y = 3000

class Background < Chingu::GameObject

  def setup
    # fill = Magick::HatchFill.new('white','cyan')
    @x = 0
    @y = 0
    @center_x = 0
    @center_y = 0

    fill = Magick::GradientFill.new(0, 0, MAX_X, 0, 'white', 'gray')
    canvas = Magick::Image.new(MAX_X,MAX_Y, fill)
    @image = Gosu::Image.new( $window, canvas, false)
  end
end


class Flying < Chingu::GameState

  trait :viewport


  def setup
    self.input =  { :escape => :exit }

    self.viewport.game_area = [0,0,MAX_X, MAX_Y]
    self.viewport.lag = 0

    Background.create(:zorder => 0)

    @balloons = (1..30).to_a.map do
      Balloon.create(:x => Random::rand(@viewport.game_area.w),
                     :y => Random::rand(@viewport.game_area.h),
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
    super
    @mouse.update
  end

end
