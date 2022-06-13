# frozen_string_literal: true

def tick(args)
  $game ||= Game.new
  $game.tick(args)
end

class Game
  def tick(args)
    setup(args)

    args.outputs.borders << args.state.cabinet
    args.outputs.sprites << args.state.ball
  end

  def setup(args)
    args.state.cabinet ||= args.state.new_entity :cabinet, w: 1280, h: 1440, x: 0, y: 0
    args.state.ball ||= args.state.new_entity :ball,
                                              w: 50, h: 50,
                                              x: args.grid.center_x - 25,
                                              y: args.grid.center_y - 25,
                                              path: 'sprites/circle/gray.png'
  end
end
