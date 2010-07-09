
class Game < Chingu::Window
  def initialize
    super(800,600, false)
    self.caption = "Balloons prototype"
    push_game_state(Flying)
    push_game_state(Chingu::GameStates::Debug)
  end


end
