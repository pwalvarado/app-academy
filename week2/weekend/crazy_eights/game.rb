require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :deck, :pile, :players
  attr_accessor :current_suit

  def initialize
    @deck = Deck.new
    @pile = []
    @players = Array.new(4) { |id| Player.new(id, deck) }
  end

  def play
    pile.concat( deck.take(1) )
    self.current_suit = pile.last.suit
    until game_over?
      begin
        puts "#{current_player.id}, it is your turn"
        player_action = current_player.play_turn(current_suit, current_rank)
        if player_action.is_a?(Card)
          @pile.push(player_action) if valid_card?(player_action)
          self.current_suit = get_current_suit
        else
          puts 'you have passed'
        end
        switch_players
      rescue BadMoveError => e
        puts e.message
        current_player.hand.add_cards([player_action])
        retry
      end
    end
    puts "Game over. Player #{players.last.id} won."
  end

  def valid_card?(card)
    raise BadMoveError if !(card.suit == current_suit ||
                              card.rank == current_rank ||
                                        card.rank == :eight)
    true
  end

  def get_current_suit
    pile.last.rank == :eight ? current_player.choose_suit : pile.last.suit
  end

  def current_rank
    pile.last.rank
  end

  def current_player
    players.first
  end

  def switch_players
    players.rotate!
  end

  def game_over?
    players.any? { |player| player.out_of_cards? }
  end
end

game = Game.new
game.play