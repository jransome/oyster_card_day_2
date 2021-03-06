class OysterCard

	attr_reader :balance, :journeys
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
		log_journey_started(entry_station)
	end

	def touch_out(exit_station)
		log_journey_finished(exit_station)
		deduct(MINIMUM_FARE)
	end

	def in_journey?
		@journeys.last.in_journey?
	end

	private

	def deduct fare
		@balance -= fare
	end

	def log_journey_started(entry_station)
		journeys << Journey.new(entry_station)
	end

	def log_journey_finished(exit_station)
		journeys.last.complete(exit_station)
	end

end
