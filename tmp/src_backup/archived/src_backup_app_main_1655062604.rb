# frozen_string_literal: true

def tick(args)
  $game ||= Game.new
  $game.tick(args)
end

def Game
  def tick(args)
    args.outputs.labels << {
      x: args.grid.center_x,
      y: args.grid.center_y,
      text: 'Hello World',
      alignment_enum: 1
    }
  end
end
