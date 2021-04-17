require "pry"

class Board 
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]
  attr_reader :squares
  def initialize
    @squares = {}
    reset
    
  end
  
  def there_is_winner?
    !!winner_marker
  end

  def set_square(square, mark)
    @squares[square].marker = mark
  end
  
  def line_winner?(line)
    same_value?(line) && full_line?(line)
  end
  
  def almost_winner?(line, marker)
    marks_counter(line) == 2 &&
      unique_values_counter(line) == 2 && 
      uniq_marker(line) == marker
  end

  def square_option(line)
    line.select { |num| @squares[num].unmarked? }.first
  end    
  
  def uniq_marker(line)
    val = line.select { |num| @squares[num].marked? }.first
    @squares[val].marker
  end    
  
  def same_value?(line)
    unique_values_counter(line) == 1
  end
  
  def unique_values_counter(line)
    line.map {|num| @squares[num].marker }.uniq.size
  end
 
  def full_line?(line)
    marks_counter(line) == 3
  end
  
  def marks_counter(line)
    line.select {|num| @squares[num].marked? }.size
  end

  def winner_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_indentical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end
  
  def can_win?(marker)
    !!free_space(marker)
  end
 
  def free_space(marker)
    WINNING_LINES.each do |line|
      return square_option(line) if almost_winner?(line, marker)
    end
    nil
  end
  
  def best_option
    [1,9,5,3,7,2,4,6,8].each do |num|
      return num if @squares[num].unmarked?
    end
  end
  
  def is_full?
    empty_options.size == 0
  end

  def empty_options
    @squares.select { |_, v| v.unmarked? }.keys
  end

  def draw
    draw_line(1, 2, 3)
    draw_line(4, 5, 6)
    draw_line(7, 8, 9, last: false)
  end
  
  def draw_line(n1, n2, n3, last: true)
    puts "     |     |"
    puts "  #{@squares[n1].marker}  |  #{@squares[n2].marker}  |  #{@squares[n3].marker}"
    puts "     |     |"
    puts "-----+-----+-----" if last
  end

  def reset 
    (1..9).each {|num| @squares[num] = Square.new }
  end
  
  private

  def three_indentical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

end

class Square
  INITIAL_MARKER = " "
  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end
 
  def unmarked?
    marker == INITIAL_MARKER
  end
  
  def marked?
    !unmarked?
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

class TTTGame
  COMPUTER_MARKER = "O"
  HUMAN_MARKER = "X"
  
  attr_accessor :board, :human, :computer, :current_marker, :total_games
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER) 
    @total_games = 0
    @current_marker = [COMPUTER_MARKER, HUMAN_MARKER].sample
  end

  def welcome_message
    puts "Hello, let's start playing, enjoy!"
    puts ""
  end

  def goodbye_message
    puts "Goodbye, thank you for playing"
  end
  
  def display_winner
    @total_games += 1 
    winner = @board.winner_marker
    case winner
    when COMPUTER_MARKER
      computer.score += 1
      @current_marker = COMPUTER_MARKER
      puts "Computer wins"
    when HUMAN_MARKER
      human.score += 1
      puts "You win"
      @current_marker = COMPUTER_MARKER
    else
      @current_marker = [COMPUTER_MARKER, HUMAN_MARKER].sample
      puts "Its a tie"
    end
  end 
  
  def display_score
    puts "---- Current score is: ----"
    puts "=> Computer: #{computer.score}"
    puts "=> Player: #{human.score}"
    puts "=> Ties: #{total_games - computer.score - human.score}"
  end   

  def display_board
    puts "Player marks with #{@human.player_marker} and computer marks with #{@computer.player_marker}"
    puts ""
    board.draw
  end

  def clear
    #system "clear"
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
      break if %w(y n).include? answer
    end
    answer == "y"
  end
  
  def reset_game
    puts "Lets play again"
    puts ""
    @board.reset
  end
  
  def human_move
    selection = nil
    loop do
      puts "Please select a number from: #{joinor(board.empty_options)}"
      selection = gets.chomp.to_i
      break if board.empty_options.include?(selection)
      puts "That is not an option available"
    end
    board.set_square(selection, HUMAN_MARKER)
  end

  def computer_move
    puts defensive_mode?
    if can_i_win?
      selection = board.free_space(COMPUTER_MARKER)
    elsif defensive_mode?
      selection = board.free_space(HUMAN_MARKER)
    else
      selection = board.best_option
    end
    board.set_square(selection, COMPUTER_MARKER)
  end
  
  def defensive_mode?
    board.can_win?(HUMAN_MARKER)
  end
  
  def can_i_win?
    board.can_win?(COMPUTER_MARKER)
  end

  def joinor(options, separator=", ", adder=" or ")
    answer = ""
    case options.size
    when 1
      answer = "#{options.first}"
    when 2
      answer = "#{options.join(adder)}"
    else
      answer = "#{options[0..-2].join(separator)}#{adder}#{options.last}"
    end
    answer
  end

  def player_move
    p board.squares.map { |k, v| v.marker}
    if current_marker == COMPUTER_MARKER
      computer_move
      @current_marker = HUMAN_MARKER
    else
      human_move
      @current_marker = COMPUTER_MARKER
    end
  end

  def fillup_squares
    loop do
      player_move
      break if board.there_is_winner? || board.is_full?
      clear_and_display_board
    end
  end

  def main_game
    loop do
      display_board
      fillup_squares
      display_board
      display_winner
      display_score
      break unless play_again?
      reset_game
    end
  end  

  def play 
    welcome_message
    main_game
    goodbye_message   
  end 
end

game = TTTGame.new
game.play
