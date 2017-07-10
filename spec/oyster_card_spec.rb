require "oyster_card"

describe OysterCard do

  subject(:oyster_card) { described_class.new }
  let(:top_up_amount) { 15 }
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

  it 'can touch in' do
  	expect(oyster_card).to respond_to(:touch_in)
  end

  it 'can touch out' do
  	expect(oyster_card).to respond_to(:touch_out)
  end

  it 'is on a journey' do
    oyster_card.top_up(top_up_amount)
  	oyster_card.touch_in
  	expect(oyster_card).to be_in_journey
  end

  context 'balance is less than £1' do
    
    it 'does not allow touch in if balance is less than £1' do
      expect{ oyster_card.touch_in }.to raise_error "Seek Assistance: not enough money!"
    end
  end

  it 'will have balance deducted when touching out' do
  	oyster_card.top_up(top_up_amount)
  	oyster_card.touch_in
    expect{ oyster_card.touch_out }.to change{ oyster_card.balance }.by -OysterCard::MINIMUM_FARE
  end


end
