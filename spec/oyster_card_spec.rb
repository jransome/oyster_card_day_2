require "oyster_card"

describe OysterCard do

  subject(:oyster_card) { described_class.new }
  let(:top_up_amount) { 15 }
  let(:entry_station) { double "Entry station"}

  # let(:fare) { 2.80 }

  it "will have a balance " do
    expect(oyster_card).to respond_to(:balance)
  end

  it 'can be topped up' do
    expect(oyster_card).to respond_to(:top_up).with(1).argument
  end

  it 'can top up the balance' do
    expect{ oyster_card.top_up(top_up_amount) }.to change{ oyster_card.balance }.by top_up_amount
  end

  it 'cannot have a balance of more than 90' do
	  expect { oyster_card.top_up(91) }.to raise_error "Maximum balance exceeded, please keep your balance at £#{OysterCard::MAXIMUM_BALANCE} or below."
  end

  it "does not allow touch in if balance is less than #{OysterCard::MINIMUM_FARE}" do
    oyster_card.top_up(rand)
    expect{ oyster_card.touch_in(:entry_station) }.to raise_error "Seek Assistance: not enough money!"
  end

  context 'Oystercard has money on it' do
    before {oyster_card.top_up(top_up_amount)}

    it 'is on a journey' do
    	oyster_card.touch_in(:entry_station)
    	expect(oyster_card).to be_in_journey
    end
    it 'will have balance deducted when touching out' do
    	oyster_card.touch_in(:entry_station)
      expect{ oyster_card.touch_out }.to change{ oyster_card.balance }.by -OysterCard::MINIMUM_FARE
    end

    it 'registers the entry station' do
      oyster_card.touch_in(:entry_station)
      expect(oyster_card.entry_station).to eq :entry_station
    end

    it 'forgets te entry station on touch-out' do
      oyster_card.touch_in(:entry_station)
      oyster_card.touch_out
      expect(oyster_card.entry_station).to eq nil
    end
  end

end
