require 'oystercard'

describe Oystercard do

  it 'has a balance of 0 by default' do
    oyster = Oystercard.new
    expect(subject.balance).to eq(0)
    end

  it 'has an empty journey_history by default' do
    expect(subject.journey_history).to eq({})

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
    let(:station) {double 'station'}
    let(:station2) {double 'station2'}

    it 'can be in_journey' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'can touch_in' do
      subject.top_up 5
      expect{ subject.touch_in(station)}.to change{ subject.journey_active}.to true
    end

    it 'can touch_out' do
      subject.top_up 5
      subject.touch_in(station)
      expect{ subject.touch_out(station2)}.to change{ subject.journey_active}.to nil
    end

    it 'can deduct minimum_fare on touch_out' do
      subject.top_up 5
      subject.touch_in(station)
      expect{ subject.touch_out(station2)}.to change{ subject.balance}.by -Oystercard::MINIMUM_FARE
    end
  end

    describe '#save_entry_station' do
      let(:station) {double 'station'}
      let(:station2) {double 'station2'}

      it 'stores the entry_station' do
        subject.top_up 5
        subject.touch_in(station)
        expect( subject.stations).to eq([station])
      end

    end

    describe '#save_exit_station' do
      let(:station) {double 'station'}
      let(:station2) {double 'station2'}

      it 'stores the exit_station' do
        subject.top_up 5
        subject.touch_in(station)
        subject.touch_out(station2)
        expect( subject.stations).to eq([station, station2])
      end
    end

    describe '#save_stations' do
      let(:station) {double 'station'}
      let(:station2) {double 'station2'}

      it 'stores both stations in a hash' do
        subject.top_up 5
        subject.touch_in(station)
        subject.touch_out(station2)
        expect( subject.entry_exit).to eq([:entry, station, :exit, station2])
      end
    end

  describe '#mimimum_fare' do
    it 'will not touch_in if balance < minimum_fare' do
      station = Oystercard.new
      expect{ subject.touch_in(station) }.to raise_error "Insufficient balance to touch in"
    end
  end
end
