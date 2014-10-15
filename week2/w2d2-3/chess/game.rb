require './pieces.rb'
require './board.rb'
require './human_player.rb'
require './computer_player.rb'
require 'io/console'
require 'colorize'
require 'pry'

class InputError < ArgumentError
end

class Game
  attr_accessor :board
  attr_reader :players

  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
    assign_players_colors
    setup_player_names
    show_players_board
  end
  
  def play
    catch :quit do
      until board.game_over? do
        board.display(current_player.color, current_player.name)
        play_turn
      end
      puts "Game over. #{board.winner} won!"
    end
    puts "Thanks for playing!"
  end

  def assign_players_colors
    players.first.color = :white
    players.last.color = :black
  end

  def show_players_board
    players.each { |player| player.board = board }
  end

  def setup_player_names
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
    board.display(current_player.color, current_player.name)
    puts "#{e.class}: #{e.message}"
    retry
  end
end

human_player = HumanPlayer.new
computer_player = ComputerPlayer.new
game = Game.new(human_player, computer_player)
game.play