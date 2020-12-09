require "pry"

INIITIAL_MARKER = " "
PLAYER_MARKER = "X"
COMPUTER_MARKER = "O"
WINNIG_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
               [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
               [[1, 5, 9], [3, 5, 7]]

computer = 0
player = 0

def prompt(msg)
  puts "=>#{msg}"
end

prompt("Who is firtst Player (P), Computer (C) or any (any key)")
first_move = gets.chomp
if first_move.downcase == "p"
  current_player = "Player"
elsif first_move.downcase == "c"
  current_player = "Computer"
else
  current_player = %w(Player Computer).sample
end

prompt "Initial is #{current_player}"

def display_board(brd)
  puts ""
  print_line(brd[1], brd[2], brd[3])
  puts "-----+-----+-----"
  print_line(brd[4], brd[5], brd[6])
  puts "-----+-----+-----"
  print_line(brd[7], brd[8], brd[9])
  puts ""
end

def print_line(elem1, elem2, elem3)
  puts "     |     |"
  puts "  #{elem1}  |  #{elem2}  |  #{elem3}"
  puts "     |     |"
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INIITIAL_MARKER }
  new_board
end

def empty_squres(brd)
  brd.keys.select { |num| brd[num] == INIITIAL_MARKER }
end

def player_place_piece!(brd)
  square = ""
  loop do
    prompt("Choose a square (#{joiner(empty_squres(brd), ", ")})")
    square = gets.chomp.to_i
    if empty_squres(brd).include?(square)
      break
    else
      prompt "Sorry, that's not a valid choice."
    end
  end
  brd[square] = PLAYER_MARKER
end

def computer_place_piece!(brd)
  if there_is_two?(brd, COMPUTER_MARKER)
    square = there_is_two?(brd, COMPUTER_MARKER)
  elsif there_is_two?(brd, PLAYER_MARKER)
    square = there_is_two?(brd, PLAYER_MARKER)
  else
    square = empty_squres(brd).sample
  end
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squres(brd).size == 0
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNIG_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return "Player"
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Computer"
    end
  end
  nil
end

def joiner(arr, separator = ", ", add = "or")
  arr.size > 1? "#{arr[0..-2].join(separator)} #{add} #{arr[-1]}" : "#{arr.join(separator)}"
end

def there_is_two?(brd, who)
  WINNIG_LINES.each do |line|
    if brd.values_at(*line).count(who) == 2 && brd.values_at(*line).count(INIITIAL_MARKER) == 1
      return brd.select {|k,v| line.include?(k)}.select {|k,v| v == " "}.keys[0]  
    end
  end
  return false
end

def alternate_player(current_player)
  current_player == "Player" ? current_player = "Computer" : current_player = "Player"
end

def place_piece!(brd, current_player)
  current_player == "Player" ? player_place_piece!(brd) : computer_place_piece!(brd)
end

loop do
  board = initialize_board

  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
    if detect_winner(board) == "Player"
      player += 1
    else
      computer += 1
    end
  else
    prompt "It is a tie"
  end
  prompt "Current score is Player #{player} Vs Computer #{computer}"
  
  # prompt "Play again? (y or n)"
  # answer = gets.chomp
  # break unless answer.downcase.start_with?("y")
  player >= 5 || computer >=5 ? break : prompt("Who first reaches 5 wins")
end

prompt "Thanks for playing TicTacToe, see you soon!!"
