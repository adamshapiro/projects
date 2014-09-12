class Player
	attr_accessor :player_name
	def initialize (options = {})
		@player_name = options[:player_name] || "Hero"
	end
end

class Friendly
	def initialize(location)
		@location = location
	end
	def location
		@location
	end
end

class Enemy
	def initialize(location)
			@location = location
	end
	def location
		@location
	end
end

@alphabet = []
("A".."Z").each do |letter|
	@alphabet << letter
end

@grid = []

def grid_sizer(square = 5)
	@grid = []
	columns = (1..square)
	square.times do |row|
		row_array = []
		columns.each do |size|
			row_array << "#{@alphabet[row]}#{size}"
		end
		@grid << row_array
	end
end

def new_game
	play = true
	@health = 10
	puts "Hello Hero! What is your name?"
	new_name = gets.strip!
	hero = Player.new({:player_name => new_name})
	begin
		puts "How long would you like a side of the map to be?"
		map_size = gets.strip.to_i
	rescue
		puts "Please enter a numeral for the length."
		map_size = gets.strip.to_i
	end
	grid_sizer(map_size)
	map_size.times do |row|
		@friend_locations = []
		@enemy_locations = []
		x_coordinate = rand(0..map_size - 1)
		y_coordinate = rand(0..map_size - 1)
		friend_or_foe = rand(1..2)
		if friend_or_foe == 1
			instance_variable_set("@person#{row}",Friendly.new(@grid[x_coordinate][y_coordinate]))
			@friend_locations << @grid[x_coordinate][y_coordinate]
		elsif friend_or_foe == 2
			instance_variable_set("@person#{row}",Enemy.new(@grid[x_coordinate][y_coordinate]))
			@enemy_locations << @grid[x_coordinate][y_coordinate]
		end
	end
	@x_curr = rand(0..map_size -1)
	@x_start = @x_curr
	@y_curr = rand(0..map_size -1)
	@y_start = @y_curr
	@x_final = rand(0..map_size -1)
	@y_final = rand(0..map_size -1)
	@start_location = @grid[@x_start][@y_start]
	@curr_location = @start_location
	@destination = @grid[@x_final][@y_final]
	puts "You begin your journey on the space #{@start_location}. Your destination is #{@destination}."
	while play == true
		if @curr_location == @destination
			return "Congratulations! You win!"
			break
		elsif @friend_locations.include?( @curr_location)
			puts "You've met a friend! He heals you a bit!"
			@health += rand(1..3)
			puts "Your health is now #{@health}. The friend left."
			@friend_locations.delete(@curr_location)
		elsif @enemy_locations.include? (@curr_location)
			puts "Oh no! You've met an enemy! He hurts you a bit!"
			@health -= rand(2..5)
			puts "Your health is now #{@health}. The enemy left."
			@enemy_locations.delete(@curr_location)
		elsif @health <= 0
			puts "You've died! Game over!"
			break
		else
			puts "How would you like to move?"
			movement = gets.chomp.upcase
			if movement == "UP"
				@x_curr += 1
				if @grid[@x_curr]
					@curr_location = @grid[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
				else
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				end
			elsif movement == "DOWN"
				@x_curr -= 1
				if @x_curr < 0
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				elsif @grid[@x_curr][@y_curr]
					@curr_location = @grid[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
				end
			elsif movement == "RIGHT"
				@y_curr += 1
				if @grid[@x_curr][@y_curr]
					@curr_location = @grid[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
				else
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				end
			elsif movement == "LEFT"
				@y_curr -= 1
				if @y_curr < 0
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				elsif @grid[@x_curr][@y_curr]
					@curr_location = @grid[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@destination}."
				end
			else
				puts "I'm sorry, that's not an option. Please choose up, down, left, or right."
			end
		end
	end
end

puts "To start a game, use the #new_game method. A1 is the bottom left of the grid for all games."