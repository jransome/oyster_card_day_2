class OysterCard

	attr_reader :balance, :entry_station, :exit_station, :journeys
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1



	def initialize
		@balance = 0
		@journeys = []
	end

	def top_up amount
		fail ("Maximum balance exceeded, please keep your balance at £#{MAXIMUM_BALANCE} or below.") if @balance+amount > MAXIMUM_BALANCE
		@balance += amount
	end

	def touch_in(entry_station)
		fail("Seek Assistance: not enough money!") if @balance < MINIMUM_FARE
		@entry_station = entry_station
	end

	def touch_out(exit_station)
		@exit_station = exit_station
		log_journey
		deduct(MINIMUM_FARE)
	end

	def in_journey?
		@entry_station != nil
	end

	private

	def deduct fare
		@balance -= fare
	end

	def log_journey
		journeys << {entry_station: @entry_station, exit_station: @exit_station}
		@entry_station, @exit_station = nil
	end

end
