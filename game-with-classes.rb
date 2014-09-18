@alphabet = []
("A".."Z").each do |letter|
	@alphabet << letter
end

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
	["up","down","left","right"].each do |direction|
		define_method "move_#{direction}" do
			case direction
			when "up"
				@x_curr += 1
				if @grid_map[@x_curr]
					@curr_location = @grid[@x_curr][@y_curr]
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
			people.scan(/@person\d/).each do |npc|
				if @curr_location == npc.location
					if npc.class == Friendly
						puts "You've met a friend! He heals you a bit!"
						@hero.health_plus(npc.damage)
						puts "Your health is now #{@hero.health}. The friend left."
						npc.go_away
					elsif npc.class == Enemy
						puts "Oh no! You've met an enemy! He hurts you a bit!"
						@hero.health_minus(npc.damage)
						puts "Your health is now #{@hero.health}. The enemy left."
						npc.go_away
					end
				end
			end
			if @hero.health <= 0
				puts "You've died! Game over!"
			elsif @curr_location == @destination
				puts "Congratulations! You win!"
			end
		end
	end
end

class Friendly
	def initialize(heal, mapsize)
		@damage = (heal * rand(1..6))
		@location = @grid_map[rand(0..mapsize - 1)][rand(0..mapsize -1)]
	end
	def damage
		@damage
	end
	def location
		@location
	end
	def go_away
		@location = nil
	end
end

class Enemy
	def initialize(heal, mapsize)
		@damage = (heal * rand(1..6))
		@location = @grid_map[rand(0..mapsize - 1)][rand(0..mapsize -1)]
	end
	def damage
		@damage
	end
	def location
		@location
	end
	def go_away
		@location = nil
	end
end

class Grid
	attr_accessor :new_health
	def self.make(size, choices ={})
		grid_sizer(size)
		if choices[:new_health]
			instance_variable_set("@hero",Player.new({:health => choices[:new_health]}))
		else
			instance_variable_set("@hero",Player.new)
		end
		npc_num=1
		people = ""
		((size * size) / 4).times do |row|
			friend_or_foe = rand(1..2)
			if friend_or_foe == 1
				instance_variable_set("@person#{npc_num}",Friendly.new(@hero.health,size))
			elsif friend_or_foe == 2
				instance_variable_set("@person#{npc_num}",Enemy.new(@hero.health,size))
			end
			people += "person#{npc_num}"
			npc_num += 1
		end
		@x_curr = rand(0..size -1)
		@x_start = @x_curr
		@y_curr = rand(0..size -1)
		@y_start = @y_curr
		@x_final = rand(0..size -1)
		@y_final = rand(0..size -1)
		@start_location = @grid_map[@x_start][@y_start]
		@curr_location = @start_location
		@destination = @grid_map[@x_final][@y_final]
	end
end