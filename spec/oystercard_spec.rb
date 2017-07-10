require "oystercard"

describe OysterCard do
  
  subject(:oystercard) { described_class.new }

it "will have a balance " do
	expect(oystercard).to respond_to(:balance)
	end



end	