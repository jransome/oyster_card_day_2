class OysterCard

	attr_reader :balance, :entry_station
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1



	def initialize
		@balance = 0
	end

	def top_up amount
		fail ("Maximum balance exceeded, please keep your balance at £#{MAXIMUM_BALANCE} or below.") if @balance+amount > MAXIMUM_BALANCE
		@balance += amount
	end

	def touch_in(entry_station)
		fail("Seek Assistance: not enough money!") if @balance < MINIMUM_FARE
		@entry_station = entry_station
	end

	def touch_out
		deduct(MINIMUM_FARE)
		@entry_station = nil
	end

	def in_journey?
		@entry_station != nil
	end

	private

	def deduct fare
		@balance -= fare
	end


end
