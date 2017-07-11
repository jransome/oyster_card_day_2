require "oyster_card"

describe OysterCard do

  subject(:oyster_card) { described_class.new }
  let(:top_up_amount) { 15 }
  let(:entry_station) { double "Entry station"}
  let(:exit_station) { double "Exit station"}
  let(:journey) { instance_double "Journey" }

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
    expect{ oyster_card.touch_in(entry_station) }.to raise_error "Seek Assistance: not enough money!"
  end

  context 'Journey in progress, Oystercard has money on it' do

    before do
      oyster_card.top_up(top_up_amount)
      oyster_card.touch_in(entry_station)
    end

    it 'is on a journey' do
    	expect(oyster_card).to be_in_journey
    end

    it 'will have balance deducted when touching out' do
      expect{ oyster_card.touch_out(exit_station) }.to change{ oyster_card.balance }.by -OysterCard::MINIMUM_FARE
    end
  end

  context 'new instance' do
    it 'has an empty list of journeys by default' do
      expect(oyster_card.journeys).to be_empty
    end
  end



  context 'one journey completed' do
    before do
      oyster_card.top_up(top_up_amount)
      oyster_card.touch_in(entry_station)
      oyster_card.touch_out(exit_station)
    end

    it 'logs a single journey' do
      expect(oyster_card.journeys.last).to eq journey
    end
  end

end
