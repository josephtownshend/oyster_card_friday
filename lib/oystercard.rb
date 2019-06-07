

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :journey_active
  attr_reader :stations
  attr_reader :journey_history
  attr_reader :entry_exit


  def initialize
    @balance = 0
    @journey_active = nil
    @stations = []
    @entry_exit = []
    @journey_history = {}
  end

  def top_up(amount)
    raise 'Max balance of #{MAXIMUM_BALANCE} exceeded' if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@journey_active
  end

  def touch_in(station)
    raise "Insufficient balance to touch in" if balance < MINIMUM_FARE
    @journey_active = true
    @stations << station
  end

  def touch_out(station2)
    @journey_active = nil
    @stations << station2
    deduct(MINIMUM_FARE)
  end

  def save_stations
    @entry_exit = @stations.insert(0, :entry)
    @entry_exit = @stations.insert(2, :exit)
    #@journey_history = Hash[*stations]
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
