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
    @cabinet ||= { w: 200, h: 200, x: args.grid.center_x - 100, y: args.grid.center_y - 100 }
    @ball ||= { w: 50, h: 50,
                x: args.grid.center_x - 25,
                y: args.grid.center_y - 25,
                path: 'sprites/circle/gray.png',
                speed: 0,
                max_speed: 10,
                gravity: 10 }
  end

  def calc(args)
    @predict = @ball.clone
    @ball.speed += @ball.gravity
    @predict.y -= @ball.speed
    if args.geometry.inside_rect?(@predict, @cabinet)
      @ball = @predict
    else
      @ball.y = @cabinet.y
      @ball.speed = 0
    end
  end

  def slope_acceleration(mass: 10, gravity: 10, angle: 6.5)
    mg = mass * gravity
    force_paralell = mg * Math.cos(angle)
    return(force_paralell)
  end
end
