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
    cabinet = args.state.cabinet
    cabinet.w = 1280
    cabinet.h = 1440
    cabinet.x = 0
    cabinet.y = 0
  end
end
