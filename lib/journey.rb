class Journey

  attr_reader :entry_station, :exit_station

  def initialize entry_station
    @entry_station = entry_station
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def complete exit_station
    @exit_station = exit_station
    @in_journey = false
  end

end
