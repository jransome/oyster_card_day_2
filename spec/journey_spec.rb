require 'journey'

describe Journey do
  subject(:journey) { described_class.new(entry_station) }
  let(:entry_station) { instance_double "Station" }
  let(:exit_station) { instance_double "Station" }
  let(:oyster_card) {instance_double "OysterCard" }

  it 'is instantiated with an entry station' do
    expect(journey.entry_station).to eq entry_station
  end

  it 'shows that a journey is initially in progress' do
    expect(journey).to be_in_journey
  end

  it 'shows that a journey is no longer in progess when touching out' do
    journey.complete(exit_station)
    expect(journey).to_not be_in_journey
  end
end
