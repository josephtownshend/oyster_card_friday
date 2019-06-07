require 'oystercard'

describe Oystercard do

  it 'has a default balance of 0' do
    oyster = Oystercard.new
    expect(subject.balance).to eq(0)
    end

  describe '#top_up' do
    it 'can top_up' do
      expect{ subject.top_up 5}.to change{ subject.balance}.by 5
    end

    it 'raises an error if the maximum_balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1}.to raise_error 'Max balance of #{MAXIMUM_BALANCE} exceeded'
    end
  end

  describe '#in_journey?' do
    it 'can be in_journey' do
      station = Oystercard.new
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'can touch_in' do
      station = Oystercard.new
      subject.top_up 5
      expect{ subject.touch_in(station)}.to change{ subject.journey}.to true
    end

    it 'can touch _ut' do
      station = Oystercard.new
      subject.top_up 5
      subject.touch_in(station)
      expect{ subject.touch_out}.to change{ subject.journey}.to nil
    end

    it 'can deduct minimum_fare on touch_out' do
      station = Oystercard.new
      subject.top_up 5
      subject.touch_in(station)
      expect{ subject.touch_out}.to change{ subject.balance}.by -Oystercard::MINIMUM_FARE
    end
  end

    describe '#save_journey' do
      let(:station) {double 'station'}
      it 'stores the entry_station' do

      subject.top_up 5
      subject.touch_in(station)
      expect( subject.entry_station).to eq([station])
    end
  end

  describe '#mimimum_fare' do
    it 'will not touch_in if balance < minimum_fare' do
      station = Oystercard.new
      expect{ subject.touch_in(station) }.to raise_error "Insufficient balance to touch in"
    end
  end

end
