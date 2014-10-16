require './pieces.rb'
require './board.rb'
require './human_player.rb'
require './computer_player.rb'
require 'io/console'
require 'colorize'

class InputError < ArgumentError
end

class Game
  attr_accessor :board
  attr_reader :players

  def initialize
    @board = Board.new
    @players = setup_players
    assign_players_colors
    setup_player_names
    show_players_board
  end

  def play
    catch :quit do
      until board.game_over? do
        board.display(current_player.color, current_player.name, current_player.cursor_pos)
        play_turn
      end
      puts "Game over. #{board.winner} won!"
    end
    puts "Thanks for playing!"
  end

  def setup_players
    system('clear')
    players = []
    puts "What type of game would you like? Choose hh, cc, hc, or ch."
    puts "h means a Human player, and c means a Computer player."
    player_types_code = gets.chomp
    players << new_player(player_types_code[0])
    players << new_player(player_types_code[1])
    players
  end

  def new_player(type_code)
    case type_code
    when 'h' then HumanPlayer.new
    when 'c' then ComputerPlayer.new
    else raise 'Invalid player type.'
    end
  end

  def assign_players_colors
    players.first.color = :white
    players.last.color = :black
  end

  def show_players_board
    players.each { |player| player.board = board }
  end

  def setup_player_names
    system('clear')
    players.each_with_index { |player, player_i| player.set_name(player_i + 1) }
  end

  def current_player
    players.first
  end

  def change_turn
    players.rotate!
  end

  def play_turn
    source_pos, dest_pos = current_player.move
    board.move(source_pos, dest_pos, current_player.color)
    change_turn
  rescue IllegalMoveError => e
    board.display(current_player.color, current_player.name, current_player.cursor_pos)
    puts "#{e.class}: #{e.message}"
    retry
  end
end

game = Game.new
game.play