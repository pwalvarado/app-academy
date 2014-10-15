class HumanPlayer
  attr_accessor :name, :color, :board

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
        board.move_cursor(cursor_diff(cursor_dir(input)))
        board.display(color, name)
      end
      throw :quit if input == 'q'

      board.cursor_pos
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
end