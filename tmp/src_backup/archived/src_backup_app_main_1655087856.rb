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

    args.outputs[:table].borders << @cabinet
    args.outputs[:table].sprites << @ball

    args.outputs.sprites << {x: 0, y: @ball.y - @cabinet.y, w: @cabinet.w, h: @cabinet.h, path: :table}
  end

  def setup(args)
    @cabinet ||= { w: 1280, h: 1440, x: 0, y: 0 }
    @ball ||= { w: 50, h: 50,
                x: args.grid.center_x - 25,
                y: args.grid.center_y - 25,
                path: 'sprites/circle/gray.png',
                x_speed: 0.0,
                y_speed: 0.0,
                max_speed: 30 }
  end

  def calc(args)
    @next_ball = @ball.clone

    @next_ball.y_speed += 10 if args.inputs.mouse.up

    @next_ball.y_speed -= slope_acceleration
    @next_ball.y += @next_ball.y_speed
    if args.geometry.inside_rect?(@next_ball, @cabinet)
      @ball = @next_ball
    else
      @ball.y_speed = 0
    end
  end
end

def slope_acceleration(mass: 0.008, gravity: 9.8, angle: 6.5)
  mg = mass * gravity
  mg * Math.cos(angle)
end
