

def prompt(message)
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

loop do
  prompt("Hello, I am a loan calculator, whats your name?")
  
  name = ""

  loop do
    name = Kernel.gets().chomp()

    if name.empty?()  
      prompt("Pleae enter a valid name")
    else
      break
    end
  end

  prompt("Nice to meet you, #{name}")
  
  prompt("How much will be your loan")
  
  loan = ""
  
  loop do
    loan = Kernel.gets().chomp()

    if valid_number?(loan)
      break
    else
      prompt("Input a valid quantity, it should be a valid number")
    end
  end

  prompt("What will be the annual interest rate expresed in %")
  apr = ""
  loop do
    apr = Kernel.gets().chomp()

    if valid_number?(apr)
      break
    else
      prompt("Input a valid quantity, it should be a valid %")
    end
  end

  prompt("How many years will you pay")
  duration = ""
  loop do
    duration = Kernel.gets().chomp()

    if integer?(apr)
      break
    else
      prompt("Input a valid number, it should be expressed in complete years")
    end
  end
  monthly_interest = apr.to_f / 1200
  duration_months = duration.to_i * 12
  monthly_payment = loan.to_i * (monthly_interest / (1 - (1 + monthly_interest)**(- duration_months)))

  operator_prompt = <<-MSG
  You will pay $#{monthly_payment.round(2)}
  it will take you #{duration_months} months to pay all
  the monthly interest rate #{(monthly_interest*100).round(2)}%
  MSG
  prompt(operator_prompt)

  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?("y")
end