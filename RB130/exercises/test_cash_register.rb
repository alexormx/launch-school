require "minitest/autorun"

require_relative "cash_register"
require_relative "transactions"

class CashRegisterTest < Minitest::Test

  def test_accept_money
    register = CashRegister.new(100)
    transaction = Transaction.new(20)
    transaction.amount_paid = 20

    previous_amount = register.total_money
    register.accept_money(transaction)
    current_amount = register.total_money

    assert_equal previous_amount + 20, current_amount
  end

  def test_change
    register = CashRegister.new(100)
    transaction = Transaction.new(40)
    transaction.amount_paid = 100

    assert_equal 60, register.change(transaction)
  end

  def test_get_recieve
    register = CashRegister.new(100)
    transaction = Transaction.new(40)

    output = "You've paid $#{transaction.item_cost}.\n"

    assert_output(output) {register.give_receipt(transaction)}

  end

  def test_prompt
    transaction = Transaction.new(30)
    input = StringIO.new("30\n")
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)

    assert_equal 30, transaction.amount_paid
  end


end
