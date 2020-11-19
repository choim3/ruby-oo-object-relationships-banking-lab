require 'pry'
class Transfer

  attr_reader :sender, :receiver
  attr_accessor :status, :amount
  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @@all << self
  end

  def self.all
    @@all
  end

  def valid?
    @sender.valid? && @receiver.valid?
    # BankAccount.all.select {|x| x == self}.is_valid?
    #    return true
    # end

  end
  
  def execute_transaction

      if valid? && self.status == "pending" && self.sender.balance >= amount
        @sender.balance -= amount
        @receiver.balance += amount
        @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.balance += amount
      @receiver.balance -= amount
      @status = "reversed"
    end
  end

end
