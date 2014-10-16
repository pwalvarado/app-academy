class HumanPlayer
  attr_accessor :name, :color, :board, :cursor_pos

  def initialize()
    @cursor_pos = [4, 4]
  end

  def set_name(player_number)
    puts "Player #{player_number}, you will be #{color.capitalize}."
    puts "What is your name?"
    self.name = gets.chomp
  end

  def move
    [select_pos, select_pos]
  end

  private

    def select_pos
      until [' ', 'q'].include?(input = get_input)
        move_cursor(cursor_diff(cursor_dir(input)))
        board.display(color, name, cursor_pos)
      end
      throw :quit if input == 'q'

      cursor_pos
    end

    def get_input
      begin
        user_input = STDIN.getch
        unless ['c', 'h', 't', 'n', 'q', ' '].include?(user_input)
          raise InputError.new('Unexpected input.')
        end
      rescue InputError
        retry
      end
      user_input
    end

    def cursor_dir(user_input)
      case user_input
      when 'c' then :up
      when 't' then :down
      when 'h' then :left
      when 'n' then :right
      else raise InputError.new('Unexpected input.')
      end
    rescue InputError => e
      puts e.message
    end

    def cursor_diff(dir)
      case dir
      when :up then [0, -1]
      when :down then [0, 1]
      when :right then [1, 0]
      when :left then [-1, 0]
      end
    end

    def move_cursor(diff)
      dx, dy = diff
      new_cursor_pos = [cursor_pos[0] + dx, cursor_pos[1] + dy]
      self.cursor_pos = new_cursor_pos unless board.offboard?(new_cursor_pos)
    end
end