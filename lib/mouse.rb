class Mouse < Chingu::BasicGameObject

  def setup
    @viewport = @options[:viewport]
    @scroll_speed = @options[:scroll_speed] || 10
    @size = 10
    @zone = 20
    @image = sketch(@size)
    super
  end

  def draw
    @image.draw $window.mouse_x - @size, $window.mouse_y - @size, 10000
  end

  def update
    # puts $window.mouse_x, $window.mouse_y
    #    puts $window.width, $window.height
    scroll(:left)  if x < @zone
    scroll(:right) if x > $window.width -  @zone
    scroll(:up)    if y < @zone
    scroll(:down)  if y > $window.height -  @zone
  end

  def x; $window.mouse_x end
  def y; $window.mouse_y end

  private

  def scroll(dir)
    amount = @scroll_speed

    moves = {
      :left  => [ -amount, 0 ],
      :right => [  amount, 0 ],
      :up    => [ 0, -amount ],
      :down  => [ 0,  amount ]
    }

    @viewport.x += moves[dir][0] # if @viewport.game_area.collide_point?(@viewport.x @viewport.y)
    @viewport.y += moves[dir][1] # if @viewport.game_area.collide_point?(@viewport.x @viewport.y)
  end

  def sketch(length)
    canvas = Magick::Image.new(2 * length + 1,2 * length + 1, Magick::HatchFill.new('transparent','transparent'))
    pen = Magick::Draw.new
    pen.translate 10,10
    pen.stroke 'red'
    pen.stroke_width 2
    pen.line 0,10, 10, 0
    pen.line 0,0, 10, 10
    pen.draw(canvas)
    Gosu::Image.new($window, canvas)
  end

end
