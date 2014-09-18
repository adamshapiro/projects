
def grid_sizer(square = 5)
	@grid_map = []
	columns = (1..square)
	square.times do |row|
		row_array = []
		columns.each do |size|
			row_array << "#{@alphabet[row]}#{size}"
		end
		@grid_map << row_array
	end
	@x_curr = rand(0..square -1)
	@x_start = @x_curr
	@y_curr = rand(0..square -1)
	@y_start = @y_curr
	@x_final = rand(0..square -1)
	@y_final = rand(0..square -1)
	@start_location = @grid_map[@x_start][@y_start]
	@curr_location = @start_location
	@destination = @grid_map[@x_final][@y_final]
	npc_num=1
	@people = ""
	((square * square) / 4).times do |row|
		friend_or_foe = rand(1..2)
		if friend_or_foe == 1
			instance_variable_set("@person#{npc_num}",Friendly.new)
		elsif friend_or_foe == 2
			instance_variable_set("@person#{npc_num}",Enemy.new)
		end
		@people += "person#{npc_num}"
		npc_num += 1
	end
end

class Player
	attr_accessor :health
	def initialize(options = {})
		@health = options[:health] || 100
	end
	def health
		@health
	end
	def health_plus(amount)
		@health += amount
	end
	def health_minus(amount)
		@health -= amount
	end
	def grid_make(square = 5)
		@alphabet = []
		("A".."Z").each do |letter|
			@alphabet << letter
		end
		@grid_map = []
		columns = (1..square)
		square.times do |row|
			row_array = []
			columns.each do |size|
				row_array << "#{@alphabet[row]}#{size}"
			end
			@grid_map << row_array
		end
		@x_curr = rand(0..square -1)
		@x_start = @x_curr
		@y_curr = rand(0..square -1)
		@y_start = @y_curr
		@x_final = rand(0..square -1)
		@y_final = rand(0..square -1)
		@start_location = @grid_map[@x_start][@y_start]
		@curr_location = @start_location
		@destination = @grid_map[@x_final][@y_final]
		@npc_num=1
		@people = ""
		((square * square) / 4).times do |row|
			friend_or_foe = rand(1..2)
			if friend_or_foe == 1
				instance_variable_set("@person#{@npc_num}",Friendly.new(self,square))
			elsif friend_or_foe == 2
				instance_variable_set("@person#{@npc_num}",Enemy.new(self,square))
			end
			@people += "@person#{@npc_num}"
			@npc_num += 1
		end
		puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
	end
	def grid_map
		@grid_map
	end
	def people
		@people
	end
	["up","down","left","right"].each do |direction|
		define_method "move_#{direction}" do
			case direction
			when "up"
				@x_curr += 1
				if @grid_map[@x_curr]
					@curr_location = @grid_map[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
				else
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				end
			when "down"
				@x_curr -= 1
				if @x_curr < 0
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				elsif @grid_map[@x_curr][@y_curr]
					@curr_location = @grid_map[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
				end
			when "left"
				@y_curr -= 1
				if @y_curr < 0
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				elsif @grid_map[@x_curr][@y_curr]
					@curr_location = @grid_map[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
				end
			when "right"
				@y_curr += 1
				if @grid_map[@x_curr][@y_curr]
					@curr_location = @grid_map[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
				else
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				end
			end
			@people.scan(/@person\d/).each do |npc|
				npc = instance_variable_get(npc)
				if @curr_location == npc.location
					if npc.class == Friendly
						puts "You've met a friend! He heals you a bit!"
						self.health_plus(npc.damage(self.health))
						puts "Your health is now #{self.health}. The friend left."
						npc.go_away
					elsif npc.class == Enemy
						puts "Oh no! You've met an enemy! He hurts you a bit!"
						self.health_minus(npc.damage(self.health))
						puts "Your health is now #{self.health}. The enemy left."
						npc.go_away
					end
				end
			end
			if self.health <= 0
				puts "You've died! Game over!"
			elsif @curr_location == @destination
				puts "Congratulations! You win!"
			end
		end
	end
end

class Friendly
	def initialize(hero_name,grid_size)
		grid_map = hero_name.grid_map
		@location = grid_map[rand(0.. grid_size - 1)][rand(0..grid_size - 1)]
	end
	def damage(amount)
		(amount/10) * rand(1..6)
	end
	def location
		@location
	end
	def go_away
		@location = []
	end
end

class Enemy
	def initialize(hero_name,grid_size)
		grid_map = hero_name.grid_map
		@location = grid_map[rand(0..grid_size - 1)][rand(0..grid_size - 1)]
	end
	def damage(amount)
		(amount/10) * rand(1..6)
	end
	def location
		@location
	end
	def go_away
		@location = []
	end
end

puts "To begin a new game, start by creating a new instance of Player.\nThen, call the grid_make method on your hero (the default map size is 5, but you can choose a different number as an argument for the method).\nFinally, move your player to the destination using the methods move_(up, down, left, or right).\nA1 is the bottom left of the map."