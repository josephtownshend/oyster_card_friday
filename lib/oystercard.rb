

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :journey
  attr_reader :entry_station


  def initialize
    @balance = 0
    @journey = nil
    @entry_station = []
  end

  def top_up(amount)
    fail 'Max balance of #{MAXIMUM_BALANCE} exceeded' if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@journey
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MINIMUM_FARE
    @journey = true
    @entry_station << station
  end

  def touch_out
    @journey = nil
    deduct(MINIMUM_FARE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
