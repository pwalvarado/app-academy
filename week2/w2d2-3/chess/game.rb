require './pieces.rb'
require './board.rb'
require './human_player.rb'
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
    show_players_board
  end
  
  def play
    catch :quit do
      until board.game_over? do
        board.display(current_player.color)
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
    board.display(current_player.color)
    puts "#{e.class}: #{e.message}"
    retry
  end
end

david = HumanPlayer.new
eline = HumanPlayer.new
game = Game.new(david, eline)
game.play