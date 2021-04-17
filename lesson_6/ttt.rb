require "pry"

class Board 
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end
  
  def there_is_winner?
    !!winner_marker
  end
  
  def counter_marks(line, input_marker)
    @square.map(&:marker).values_at(*line)
  end

  def set_square_at(key, marker)exit
    @squares[key].marker = marker
  end
  
  def winner_marker
    WINING_LINES.each do |line|
      if counter_marks(line, TTTGame::PLAYER_MARKER) == 3
        return TTTGame::PLAYER_MARKER
      elsif counter_marks(line, TTTGame::COMPUTER_MARKER) == 3
        return TTTGAME::COMPUTER_MARKER
      end
    end
    nil
  end
  
  def is_full?
    empty_options == 0
  end

  def empty_options
    @squares.select { |_, v| v.is_empty? }.keys
  end

  def draw
    puts "     |     |"
    puts "  #{@squares[1].marker}  |  #{@squares[2].marker}  |  #{@squares[3].marker}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4].marker}  |  #{@squares[5].marker}  |  #{@squares[6].marker}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7].marker}  |  #{@squares[8].marker}  |  #{@squares[9].marker}"
    puts "     |     |"
  end

  def reset 
    (1..9).each {|num| @squares[num] = Square.new} 
  end

end

class Square
  INITIAL_MARKER = " "
  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end
 
  def is_empty?
    marker == INITIAL_MARKER
  end

end

class Player
  attr_reader :type, :player_marker
  attr_accessor :score

  def initialize(player_marker)
    @type = type
    @score = 0
    @player_marker = player_marker
  end

end

class Human < Player
  def move(board)
    selection = nil
    loop do
      puts "Please select a number from: #{board.empty_options.join(", ")}"
      selection = gets.chomp.to_i
      break if board.empty_options.include?(selection)
      puts "That is not an option available"
    end
    board.set_square_at(selection, human.marker)

  end
end

class Computer < Player
  
  def move(board)
    selection = board.empty_options.sample
    board.set_square_at(selection, player_marker)
  end

end

class TTTGame
  COMPUTER_MARKER = "O"
  HUMAN_MARKER = "X"

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
  end

  def welcome_message
    puts "Hello, let's start playing, enjoy!"
    puts ""
  end

  def goodbye_message
    puts "Goodbye, thank you for playing"
  end
  
  def display_winner
    winner = @board.winner_marker
    case winner
    when COMPUTER_MARKER
      puts "Computer wins"
    when HUMAN_MARKER
      puts "You win"
    else
      puts "Its a tie"
    end
  end 
    
  def display_board
    puts "Player marks with #{@human.player_marker} and computer marks with #{@computer.player_marker}"
    puts ""
    @board.draw
  end

  def clear
  system "clear"
  end

  def clear_and_display_board
    clear
    display_board
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again (y/n)?"
      answer = gets.chomp.downcase
      break if %w(y n).include answer
    end
    answer == "y"
  end
  
  def reset_game
    puts "Lets play again"
    puts ""
    @board.reset
  end

  def play 
    welcome_message

    loop do
      display_board

      loop do
        @human.move(@board)
        break if board.there_is_winner || board.is_full?
      
        @computer.move(@board)
        break if board.is_full?
        clear_display_board
      end
      display_winner
      break unless play_again?
      reset_game

    end

    goodbye_message   
  end 
end

# we'll kick off the game like this
game = TTTGame.new
game.play
