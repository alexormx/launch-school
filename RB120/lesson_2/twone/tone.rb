require "pry"

class Deck
  SUITES = %w(H C D S)
  SERIES = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  def initialize
    new_deck
  end

  def new_deck
    @cards = []
    open_deck
    shuffle_cards
  end
  
  def open_deck
    SUITES.each do |suit|
      series = ["H", "C"].include?(suit) ? SERIES : SERIES.reverse
      series.each do |serie|
        @cards << Card.new(suit, serie)
      end
    end
  end
  
  def shuffle_cards
    @cards.shuffle!
  end
  
  def deal_card
    @cards.pop
  end
end


class Card
  attr_reader :suit, :serie
  def initialize(suit, serie)
    @serie = serie
    @suit = suit
  end
  
  def ace?
    serie == "A"
  end

  def suit_name
    display_name = nil
    case suit
    when "H" 
      display_name = "Hearts"
    when "S" 
      display_name = "Spades"
    when "C" 
      display_name = "Clubs"
    when "D" 
      display_name = "Diamonds"
    end
    display_name
  end
      
  def serie_name
    display_name = nil
    case serie
    when "A" 
      display_name = "Ace"
    when "J" 
      display_name = "Jack"
    when "Q" 
      dispaly_name = "Queen"
    when "K" 
      dispaly_name = "King"
    else 
      display_name = serie
    end
    display_name
  end    
    
  def to_s
    "--#{serie_name} of #{suit_name} Card--"
  end
end

class Player
  attr_accessor :score, :cards
  def initialize
    @cards = []
    @score = 0
  end

  def hits(card)
    @cards << card
  end
  
  def return_cards
    @cards = []
  end

  def total
    total = 0
    @cards.each do |card|
      case card.serie
      when "A"
        total += 11
      when "J", "Q", "K"
        total += 10
      else
        total += card.serie.to_i
      end
    end
    if total > 21
      @cards.select(&:ace?).size.times do
        total -= 10
        break unless total > 21
      end
    end
    total
  end

  def strike?
    self.total > 21
  end
end

class TwentyOne
  def initialize
    @gambler = Player.new
    @dealer = Player.new
    @deck = Deck.new
    @total_games = 0
  end

  def first_hand
    2.times do
      @gambler.hits(@deck.deal_card)
      @dealer.hits(@deck.deal_card)
    end
  end
  
  def goodbye_message
    puts "Thank you for playing, say you soon"
  end
  
  def gambler_hits?
    answer = ""
    loop do
      puts "Do you want to (h)it or (s)tay?"
      answer = gets.chomp.downcase
      break if %w(h s).include?(answer)
    end    
    answer == "h"
  end
  
  def squared_message(msg)
    puts "*" * (msg.size + 6)
    puts "** #{msg} **"
    puts "*" * (msg.size + 6)
  end
    
  def welcome_message
    msg = "Welcome to TwentyOne Game"
    squared_message(msg)
  end
    
  def display_result
    display_gambler
    display_dealer
  end

  def display_gambler
    puts "------------"
    puts "Your cards are: "
    @gambler.cards.each do |card|
      puts card
    end
  end

  def display_dealer
    puts "------------"
    puts "Visible card for the dealer is:"
    puts "#{@dealer.cards.last}"
    puts "------------"
  end
  
  def print_score_pre
    puts "Your score is #{@gambler.total}"
    puts "Dealer showing card is #{@dealer.cards.last}"
  end
    
  def want_to_hit?
    print_score_pre
    gambler_hits?
  end

  def gambler_hit
    loop do
      break unless want_to_hit?
      @gambler.hits(@deck.deal_card)
      break if @gambler.strike?
    end
  end

  def dealer_hit
    while @dealer.total < 17
      break if @gambler.strike?
      @dealer.hits(@deck.deal_card)
    end
  end

  def display_winner
    msg = is_tie? ? "It is a tie" : "The winner is #{who_won}"
    puts "Dealer strike!!" if @dealer.strike?
    puts "You strike!!!" if @gambler.strike?
    puts "Your score is #{@gambler.total}"
    puts "Dealer score is #{@dealer.total}"
    puts msg
  end

  def is_tie?
    @dealer.total == @gambler.total
  end
  
  def who_won
    winner = dealer_won? ? "Dealer" : "Gambler"
  end
  
  def dealer_won?
    (@dealer.total > @gambler.total || @gambler.strike?) && !@dealer.strike?
  end
  
  def update_score
    dealer_won? ? @dealer.score += 1 : @gambler.score =+ 1
    @total_games += 1
  end

  def display_score
    update_score
    puts "----------------"
    puts "Current score is:"
    puts "=> Gambler: #{@gambler.score}"
    puts "=> Dealer: #{@dealer.score}"
    puts "=> Ties: #{@total_games - @gambler.score - @dealer.score}"
  end
 
  def displays
    display_result
    display_winner
    display_score
  end
  
  def card_distribution
    loop do
      gambler_hit
      break if @gambler.strike?
      dealer_hit
      break
    end
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again (y/n)?"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
    end
    open_new_deck
    answer == "y"
  end
    
  def open_new_deck
    @gambler.return_cards
    @dealer.return_cards
    @deck.new_deck
  end

  def main_game
    loop do
      first_hand
      display_result
      card_distribution
      displays
      break unless play_again?
    end
  end
 
  def play
    welcome_message
    main_game
    goodbye_message
  end
end

game = TwentyOne.new
game.play

