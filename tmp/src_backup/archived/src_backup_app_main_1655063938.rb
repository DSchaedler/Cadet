# frozen_string_literal: true

def tick(args)
  $game ||= Game.new
  $game.tick(args)
end

class Game
  def tick(args)
    setup(args)

    args.outputs.primitives << {
      x: 0, y: 0,
      w: args.state.cabinet_w,
      h: args.state.cabinet_h,
      primitive_marker: :border
    }
  end

  def setup(args)
    args.state.cabinet_w = 1280
    args.state.cabinet_h = 1440
  end
end
