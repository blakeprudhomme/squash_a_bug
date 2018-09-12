require 'gosu'

W_WIDTH = 800
W_HEIGHT = 600

GAME_LENGTH = 20

class WhackARuby < Gosu::Window
  def initialize
    super(W_WIDTH, W_HEIGHT)
    self.caption = 'Whack A Ruby!'
    @ruby = Gosu::Image.new('ruby.png')
    @hammer = Gosu::Image.new('hammer.png')
    @x = 200
    @y = 200
    @width = 50
    @height = 43
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hit = 0
    @font = Gosu::Font.new(30)
    @score = 0
    @playing = true
    @start_time = 0
  end

  def update
    if @playing
      @x += @velocity_x
      @y += @velocity_y

      @velocity_x *= -1 if @x + @width / 2 > W_WIDTH || @x - @width / 2 < 0
      @velocity_y *= -1 if @y + @height / 2 > W_HEIGHT || @y - @height / 2 < 0

      @visible -= 1
      @visible = 30 if @visible < -10 && rand < 0.01

      @time_left = (GAME_LENGTH - ((Gosu.milliseconds - @start_time) / 1000))
      @playing = false if @time_left <= 0
    end
  end

  def button_down(id)
    if @playing
      if id == Gosu::MsLeft
        if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible.zero?
          @hit = 1
          @score += 5
        else
          @hit = -1
          @score -= 1
        end
      end
    else
      if id = Gosu::KbSpace
        @playing = true
        @visible = -10
        @start_time = Gosu.milliseconds
        @score = 0
      end
    end
  end

  def draw
    @ruby.draw(@x - @width / 2, @y - @height / 2, 1) if @visible > 0

    @hammer.draw(mouse_x - 40, mouse_y - 10, 1)

    c = case @hit
        when 0
          Gosu::Color::NONE
        when 1
          Gosu::Color::GREEN
        when -1
          Gosu::Color::RED
        end

    draw_quad(0, 0, c, W_WIDTH, 0, c, W_WIDTH, W_HEIGHT, c, 0, W_HEIGHT, c)
    @hit = 0

    @font.draw("SCORE: #{@score}", 640, 20, 2)
    @font.draw("TIME: #{@time_left}", 20, 20, 2)

    unless @playing
      @font.draw('Game Over', 300, 300, 3)
      @font.draw('Press the space bar to play again', 175, 350, 3)
      @visible = 20
    end
  end
end

WhackARuby.new.show
