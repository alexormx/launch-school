class Player
  attr_accessor :move, :name
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name()
  end

  def set_name()
    if human?
      n = ""
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must enter a value."
      end
      self.name = n
    else
      self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please chose rock, paper or scissors"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include? choice
        puts "Sorry, invalid choice"
      end
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end

  def human?
    @player_type == :human
  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissor!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye"
  end

  def display_winner
    puts "#{@human.name}: #{@human.move}"
    puts "#{@computer.name}:  #{@computer.move}"
    puts check_winner(@human, @computer)
  end

  def check_winner(human, computer)
    return "It's a tie" if human.move == computer.move
    case human.move
    when "paper" 
      computer.move == "scissors" ? "#{@computer.name} wins" : "#{@human.move} win"
    when "scissors" 
      computer.move == "rock" ? "#{@computer.name} wins" : "#{@human.move} win"
    when "rock" 
      computer.move == "paper" ? "#{@computer.name} wins" : "#{@human.move} win"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ["y", "n"].include? answer.downcase
      puts "Sorry, must be y or n"
    end
    return true if answer == "y"
    return false
  end

  def play
    display_welcome_message
    loop do 
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play