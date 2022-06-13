# frozen_string_literal: true

def tick(args)
  $game ||= Game.new
  $game.tick(args)
end

class Game
  def tick(args)
    setup(args)

    args.outputs.borders << args.state.cabinet
    
  end

  def setup(args)
    args.state.cabinet.w = 1280
    args.state.cabinet.h = 1440
    args.state.cabinet.x = 0
    args.state.cabinet.y = 0
  end
end
