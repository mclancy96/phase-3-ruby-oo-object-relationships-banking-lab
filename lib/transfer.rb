require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    unless sender_has_enough_funds? && valid? && @status == 'pending'
      @status = 'rejected'
      return 'Transaction rejected. Please check your account balance.'
    end

    sender.deposit(amount * -1)
    receiver.deposit(amount)
    @status = 'complete'
  end

  private

  def sender_has_enough_funds?
    sender.balance > amount
  end
end
