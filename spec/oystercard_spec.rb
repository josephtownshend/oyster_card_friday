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

    it 'has a maximum balance of £90' do
      
    end

  end

end
