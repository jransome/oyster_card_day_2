class OysterCard

	attr_reader :balance
	MAXIMUM_BALANCE = 90

	def initialize
		@balance = 0
	end

	def top_up amount
		fail ("Maximum balance exceeded, please keep your balance at £#{MAXIMUM_BALANCE} or below.") if @balance+amount > MAXIMUM_BALANCE
		@balance += amount
	end

	def deduct fare
		@balance -= fare
	end

end
