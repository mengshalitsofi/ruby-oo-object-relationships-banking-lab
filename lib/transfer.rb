class Transfer
  attr_reader :sender
  attr_reader :receiver
  attr_reader :amount
  attr_reader :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @status != "complete"
      if !valid? || @sender.balance < @amount
        @status = "rejected"
        return "Transaction rejected. Please check your account balance."        
      else
        @receiver.deposit(@amount)
        @sender.deposit(-@amount)
        @status = "complete"
      end
    end
  end

  def reverse_transfer
    if @status == "complete"
      @status = "reversed"
      @receiver.deposit(-@amount)
      @sender.deposit(@amount)
    end
  end
end
