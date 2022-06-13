# frozen_string_literal: true

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
    @cabinet ||= args.state.new_entity :cabinet,
                                                 w: 1280, h: 1440, x: 0, y: 0
    @ball ||= args.state.new_entity :ball,
                                              w: 50, h: 50,
                                              x: args.grid.center_x - 25,
                                              y: args.grid.center_y - 25,
                                              path: 'sprites/circle/gray.png',
                                              speed: 0,
                                              max_speed: 10,
                                              gravity: 0.1
  end

  def calc(args)
    ball = @ball
    @predict = args.state.new_entity :predict,
                                               x: ball.x,
                                               y: ball.y = ball.y - ball.speed,
                                               w: ball.w, h: ball.h
    predict = @predict
    if args.geometry.inside_rect?(predict, @cabinet)
      ball.speed += ball.gravity unless ball.speed == ball.max_speed
      ball.x = predict.x
      ball.y = predict.y
    end
  end
end
