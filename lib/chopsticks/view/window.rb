module Chopsticks::View
  class Window

    def initialize(win, x, y, width, height)
      @parent = win
      if width == 0
        width = Ncurses.getmaxx(Ncurses.stdscr)
      end
      if height == 0
        height = Ncurses.getmaxy(Ncurses.stdscr)
      end
      
      @width  = width
      @height = height
      @window = win.subwin(@height, @width, y, x)
      @cur_y = 0
      @cur_x = 0
    end

    def clear
      @window.clear
      @window.noutrefresh
    end

    def show
      @window.move(@cur_y, 0)
      @window.noutrefresh
    end

    def update(item, data=nil)
      @data = data
      @items = item
      @window.noutrefresh()
    end

    def open
      
    end

    def pagedown
    end
    
    def pageup
    end

    def refresh
      @window.refresh
    end

    def touchwin
      @window.touchwin
    end

    def add_str(str, x, y, width=0, space=0)
      wadd_str(@window, str, x, y, width, space)
    end


    def wadd_str(win, str, x, y, width=0, space=0)
      str = "-" unless str
      if width == 0
        width = str.bytesize
      end
      win.mvaddstr(y, x, str.display_slice(width).concat(" " * space))
      return x + width + space
    end

    def ins_str(str, x, y, width=0, space=0)
      wins_str(@window, str, x, y, width, space)
    end

    def wins_str(win, str, x, y, width=0, space=0)
      str = "-" unless str
      if width == 0
        width = str.bytesize
      end
      win.mvinsstr(y, x, str.display_slice(width).concat(" " * space))
      return x + width + space
    end

    def add_ch(ch, x, y)
      wadd_ch(@window, ch, x, y)
    end
    
    def wadd_ch(win, ch, x, y)
      win.mvaddch(y, x, ch)
      x + 1
    end
  end
end