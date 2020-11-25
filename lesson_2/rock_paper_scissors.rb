VALID_CHOICES = %w(r p x s l)
computer_times = 0
player_times = 0

def win?(first, second)
  is_winner = { x: ["p", "l"], p: ["r", "s"], l: ["p", "s"],
                s: ["x", "r"], r: ["l", "x"] }
  is_winner[first.to_sym].include?(second)
end

def display_result(player, computer)
  if player == computer
    prompt("It's a tie")
  elsif win?(player, computer)
    prompt("You won!")
  else
    prompt("Computer won!")
  end
end

def test_method
  prompt("Test method")
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

test_method

loop do
  choice = ""
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_result(choice, computer_choice)

  if win?(choice, computer_choice)
    player_times += 1
  elsif choice != computer_choice
    computer_times += 1
  end

  prompt("Current score is player: #{player_times}; computer #{computer_times}")
  break if computer_times == 5 || player_times == 5
end

prompt("The winner is #{computer_times == 5 ? 'Computer' : 'Player 1'}")
