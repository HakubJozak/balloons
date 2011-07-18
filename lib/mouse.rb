class Mouse < Chingu::BasicGameObject

  def setup
    @viewport = @options[:viewport]
    @scroll_speed = @options[:scroll_speed] || 10
    @zone = 20
    @size = 10

    @green = sketch('green')
    @red = sketch('red')
    super
  end

  def draw
    if $window.button_down? Gosu::MsLeft
      @image = @green
    else
      @image = @red
    end

    @image.draw $window.mouse_x - @size, $window.mouse_y - @size, 10000
  end

  def button_down(key)
    # case key
    # when Gosu::MsLeft then
      # when Gosu::MsRight then @mouse.right_click
      # when Gosu::MsMiddle then @mouse.middle_click

      # when Gosu::KbEscape then close
      # when Gosu::KbSpace then toggle_pause
      # when Gosu::KbReturn then @world.delete_all
      # when Gosu::KbF1 then @world.save_track('track.yml')
      # when Gosu::KbF2 then @world.load_track('track.yml')
      # when Gosu::KbF3 then @world.delete_track
    #end
  end


  def value(_x,_y)
    if $window.button_down? Gosu::MsLeft
      [ (0.002 * (_x - self.x)) , (0.002 * (_y - self.y))  ]
    else
      [ 0 , 0 ]
    end
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

  def sketch(color)
    canvas = Magick::Image.new(2 * @size + 1,2 * @size + 1, Magick::HatchFill.new('transparent','transparent'))
    pen = Magick::Draw.new
    pen.translate 10,10
    pen.stroke(color)
    pen.stroke_width 2
    pen.line 0,10, 10, 0
    pen.line 0,0, 10, 10
    pen.draw(canvas)
    Gosu::Image.new($window, canvas)
  end

end
