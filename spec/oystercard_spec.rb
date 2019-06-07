require 'oystercard'

describe Oystercard do

  it 'has a balance of 0' do
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

end
