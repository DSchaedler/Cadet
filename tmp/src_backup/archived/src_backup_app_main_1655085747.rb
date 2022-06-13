# frozen_string_literal: true

$game = nil

def tick(args)
  $game ||= Game.new
  $game.tick(args)
end

class Game
  def tick(args)
    setup(args)
    calc(args)

    args.outputs.borders << @cabinet
    args.outputs.sprites << @ball
  end

  def setup(args)
    @cabinet = { w: 200, h: 200, x: args.grid.center_x - 100, y: args.grid.center_y - 100 }
    @ball = { w: 50, h: 50,
              x: args.grid.center_x - 25,
              y: args.grid.center_y - 25,
              path: 'sprites/circle/gray.png',
              speed: 0,
              max_speed: 1,
              gravity: 0.1 }
  end

  def calc(args)
    @predict = @ball.clone
    puts @predict
  end
end
