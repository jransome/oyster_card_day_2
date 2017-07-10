require "oyster_card"

describe OysterCard do

  subject(:oyster_card) { described_class.new }
  let(:top_up_amount) { 15 }
  let(:fare) { 2.80 }

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

  it 'can have money deducted from its balance' do
    expect{ oyster_card.deduct(fare) }.to change{ oyster_card.balance }.by -fare
  end

  it 'can touch in' do
  	expect(oyster_card).to respond_to(:touch_in)
  end

  it 'can touch out' do
  	expect(oyster_card).to respond_to(:touch_out)
  end

  it 'is on a journey' do
  	oyster_card.touch_in
  	expect(oyster_card).to be_in_journey
  end

end
