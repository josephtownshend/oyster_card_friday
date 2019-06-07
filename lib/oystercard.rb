

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :journey


  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    fail 'Max balance of #{MAXIMUM_BALANCE} exceeded' if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey
  end

  def touch_in
    fail "Insufficient balance to touch in" if balance < MINIMUM_FARE
    @journey = true
  end

  def touch_out
    @journey = false
  end




  private
  def deduct(amount)
    @balance -= amount
  end

end
