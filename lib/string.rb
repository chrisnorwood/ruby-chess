class String
  def colorize(color)
    "\e[#{color}m#{self}\e[0m"
  end

  def colorize_twice(bg, fg)
    "\e[#{bg};#{fg}m#{self}\e[0m"
  end

  def color(color)
    case color
    when :red_text
      colorize(31)
    when :yellow_text
      colorize(33)
    when :red
      colorize(41)
    when :green
      colorize(42)
    when :yellow
      colorize(43)
    when :blue
      colorize(44)
    when :pink
      colorize(45)
    when :cyan
      colorize(46)
    when :white
      colorize(47)
    when :white_b
      colorize_twice(47, 30)
    when :black_w
      colorize(40)
    else
      colorize(30)
    end
  end
end