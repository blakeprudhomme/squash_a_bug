require 'gosu'

W_WIDTH = 800
W_HEIGHT = 600

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
  end

  def update
    @x += @velocity_x
    @y += @velocity_y

    @velocity_x *= -1 if @x + @width / 2 > W_WIDTH || @x - @width / 2 < 0
    @velocity_y *= -1 if @y + @height / 2 > W_HEIGHT || @y - @height / 2 < 0

    @visible -= 1
    @visible = 30 if @visible < -10 && rand < 0.01
  end

  def draw
    @ruby.draw(@x - @width / 2, @y - @height / 2, 1) if @visible > 0

    @hammer.draw(mouse_x - 40, mouse_y - 10, 1)
  end
end

window = WhackARuby.new
window.show
