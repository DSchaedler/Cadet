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
    args.state.cabinet ||= args.state.new_entity :cabinet, w: 1280, h: 1440, x: 0, y: 0
  end
end
