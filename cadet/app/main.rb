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

    args.outputs[:table].clear_before_render = true
    args.outputs[:table].sprites << @cabinet
    args.outputs[:table].sprites << @ball

    args.outputs.labels << {x: 0, y: args.grid.top, text: "#{args.state.tick_count}"}
    args.outputs.labels << {x: 0, y: args.grid.center_y, text: "#{@ball.x_speed}"}
    args.outputs.labels << {x: 0, y: args.grid.center_y - 20, text: "#{@ball.y_speed}"}

    args.outputs.sprites << {x: 0, y: @cabinet.y - @ball.y + args.grid.center_y - @ball.h , w: @cabinet.w, h: 720, path: :table}
  end

  def setup(args)
    @cabinet ||= { w: 1280, h: 720, x: 0, y: 0, path: 'sprites/tile/wall-1111.png' }
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

    if args.inputs.mouse.up
      @next_ball.y_speed += 15 
      @next_ball.x_speed = randr(-15, 15)
    end

    # Handle Ball Y movement
    @next_ball.x += @next_ball.x_speed
    @next_ball.y_speed -= slope_acceleration
    @next_ball.y += @next_ball.y_speed
    if args.geometry.inside_rect?(@next_ball, @cabinet)
      @ball = @next_ball
    else
      @next_ball = @ball.clone 
      until args.geometry.inside_rect?(@next_ball, @cabinet) == false || @next_ball.y_speed == 0
        if @ball.y_speed.negative?
          @next_ball.y -= 0.01
        end
        if @ball.y_speed.positive?
          @next_ball.y += 0.01
        end
        if @ball.x_speed.negative?
          @next_ball.x -= 0.01
        end
        if @ball.x_speed.positive?
          @next_ball.x += 0.01
        end
      end
      @next_ball.y += 0.02 if @ball.y_speed.negative?
      @next_ball.y -= 0.02 if @ball.y_speed.positive?
      @next_ball.y_speed = 0
      @next_ball.x += 0.02 if @ball.x_speed.negative?
      @next_ball.x -= 0.02 if @ball.x_speed.positive?
      @next_ball.x_speed = 0
      @ball = @next_ball
    end
  end
end

def slope_acceleration(mass: 0.015, gravity: 9.8, angle: 6.5)
  mg = mass * gravity
  mg * Math.cos(angle)
end

def randr(min, max)
  rand(max - min + 1) + min
end