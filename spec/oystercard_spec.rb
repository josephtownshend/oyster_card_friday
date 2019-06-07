require 'oystercard'

describe Oystercard do

  it 'has a default balance of 0' do
    oyster = Oystercard.new
    expect(subject.balance).to eq(0)
    end

  describe '#top_up' do
    it 'can be topped up' do
    expect{ subject.top_up 5}.to change{ subject.balance}.by 5
    end

    it 'raises an error if the max balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1}.to raise_error 'Max balance of #{MAXIMUM_BALANCE} exceeded'
    end
  end

  describe '#deduct' do
    it 'can deduct an amount from the balance' do
      subject.top_up 5
      expect{ subject.deduct 5}.to change{ subject.balance}.by -5
    end
  end

  describe '#in_journey?' do
    it 'it can be in a journey' do
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    subject.touch_in
    expect(subject).to be_in_journey
  end

    it 'it can touch in' do
      subject.top_up 5
      expect{ subject.touch_in}.to change{ subject.journey}.to true
    end

    it 'it can touch out' do
      subject.top_up 5
      subject.touch_in
      expect{ subject.touch_out}.to change{ subject.journey}.to false
    end
  end

  describe '#mimimum_fare' do
    it 'will not touch in if below minimum balance' do
    expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in"
  end
  end

end
