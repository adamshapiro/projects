class Player
	attr_accessor :player_name, :player_health
	def initialize (options = {})
		@player_name = options[:player_name] || "Hero"
		@player_health = options[:player_health] || 10
	end
	def movement
	end
end

class Friendly
	def initialize
		@give_health = rand(1..3)
	end
end

class Enemy
	def initialize
		@take_health = rand(1..3)
	end
end

