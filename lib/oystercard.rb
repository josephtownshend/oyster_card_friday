

class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance, :journey


  def initialize
    @balance = 0
    @journey = nil
  end

  def top_up(amount)
    fail 'Max balance of #{MAXIMUM_BALANCE} exceeded' if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end


end
