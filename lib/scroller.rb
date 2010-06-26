#!/usr/bin/env ruby


class Game < Chingu::Window
  def initialize
    super(800,600, false)
    self.caption = "Balloons prototype"
    switch_game_state(Flying)
  end
end
