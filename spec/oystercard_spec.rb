require "oyster_card"

describe OysterCard do

  subject(:oyster_card) { described_class.new }
  let(:top_up_amount) { 15 }

  it "will have a balance " do
    expect(oyster_card).to respond_to(:balance)
  end

  it 'can be topped up' do
    expect(oyster_card).to respond_to(:top_up).with(1).argument
  end

  it 'can top up the balance' do
    expect{ oyster_card.top_up(top_up_amount) }.to change{ oyster_card.balance }.by top_up_amount
  end


end
