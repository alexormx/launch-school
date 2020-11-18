# ask the user for two numers
# ask the user for an operator to perform
# perform the operation on the two numbers
# oyutput the result

# answer = Kernel.gets()
# Kernel.puts(answer)
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'en'

def prompt(key, var)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def messages(message, LANGUAGE)
  MESSAGES[lang][message]
end

def operation_to_message(op)
  word = case op
         when "1"
           "Adding"
         when "2"
           "Substracting"
         when "3"
           "Multiplying"
         when "4"
           "Dividing"
         end
  word
end

prompt('welcome')
name = ""
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt('valid_name')
  else
    break
  end
end

prompt("Hi #{name}")

loop do # main loop
  number1 = 0
  number2 = 0
  operator = ""

  loop do
    prompt('first_number')
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt('error')
    end
  end

  loop do
    prompt('second_number')
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt('error')
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add 
    2) substract 
    3) multiply 
    4) divide
  MSG

  prompt(operator_prompt)

  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('op_error')
    end
  end
  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when "1"
             number1.to_i() + number2.to_i()
           when "2"
             number1.to_i() - number2.to_i()
           when "3"
             number1.to_i() * number2.to_i()
           when "4"
             number1.to_i() / number2.to_i()
           end

  prompt("The number is: #{result}")
  prompt('question')
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?("y")
end

prompt('thanks')