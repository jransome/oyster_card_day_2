class OysterCard

	attr_reader :balance
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1
	attr_accessor :in_journey



	def initialize
		@balance = 0
	end

	def top_up amount
		fail ("Maximum balance exceeded, please keep your balance at £#{MAXIMUM_BALANCE} or below.") if @balance+amount > MAXIMUM_BALANCE
		@balance += amount
	end


	def touch_in
		fail("Seek Assistance: not enough money!") if @balance < MINIMUM_FARE
		@in_journey = true
	end

	def touch_out
		@in_journey = false
		deduct(MINIMUM_FARE)
	end

	def in_journey?
		@in_journey
	end

	private

	def deduct fare
		@balance -= fare
	end


end
