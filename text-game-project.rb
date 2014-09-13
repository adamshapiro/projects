class Player
	attr_accessor :player_name
	def initialize (options = {})
		@player_name = options[:player_name] || "Hero"
		@health = options[:player_health] || 100
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

def new_game(hidden = false)
	puts "Hello Hero! What is your name?"
	new_name = gets.strip
	puts "How much health does your hero have?"
	new_health = gets.strip.to_i
	while new_health <= 10
		puts "Please enter a number greater than or equal to 10 for your health."
		new_health = gets.strip.to_i
	end
	hero = Player.new({:player_name => new_name, :player_health => new_health})
	puts "How long would you like a side of the map to be?"
	map_size = gets.strip.to_i
	while map_size <= 0
		puts "Please enter a numeral greater than 0 for the length."
		map_size = gets.strip.to_i
	end
	grid_sizer(map_size)
	@friend_locations = []
	@enemy_locations = []
	((map_size * map_size) / 4).times do |row|
		x_coordinate = rand(0..map_size - 1)
		y_coordinate = rand(0..map_size - 1)
		friend_or_foe = rand(1..2)
		if friend_or_foe == 1
			@friend_locations << @grid[x_coordinate][y_coordinate]
		elsif friend_or_foe == 2
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
	if hidden
		@show_destination = "unknown"
	elsif hidden == false
		@show_destination = @destination
	end
	puts "You begin your journey on the space #{@start_location}. Your destination is #{@show_destination}."
	while true
		if @curr_location == @destination
			return "Congratulations! You win!"
			break
		elsif @friend_locations.include?( @curr_location)
			puts "You've met a friend! He heals you a bit!"
			new_health += ((new_health/10) * rand(1..6))
			puts "Your health is now #{@health}. The friend left."
			@friend_locations.delete(@curr_location)
		elsif @enemy_locations.include? (@curr_location)
			puts "Oh no! You've met an enemy! He hurts you a bit!"
			new_health -= ((new_health/10) * rand(1..6))
			puts "Your health is now #{@health}. The enemy left."
			@enemy_locations.delete(@curr_location)
		elsif new_health <= 0
			puts "You've died! Game over!"
			break
		else
			puts "How would you like to move?"
			movement = gets.chomp.upcase
			if movement == "UP"
				@x_curr += 1
				if @grid[@x_curr]
					@curr_location = @grid[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@show_destination}."
				else
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@show_destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				end
			elsif movement == "DOWN"
				@x_curr -= 1
				if @x_curr < 0
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@show_destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				elsif @grid[@x_curr][@y_curr]
					@curr_location = @grid[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@show_destination}."
				end
			elsif movement == "RIGHT"
				@y_curr += 1
				if @grid[@x_curr][@y_curr]
					@curr_location = @grid[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@show_destination}."
				else
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@show_destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				end
			elsif movement == "LEFT"
				@y_curr -= 1
				if @y_curr < 0
					puts "You've fallen off the map! Go back to the start. Your location is now #{@start_location}. Your destination is #{@show_destination}."
					@curr_location = @start_location
					@x_curr = @x_start
					@y_curr = @y_start
				elsif @grid[@x_curr][@y_curr]
					@curr_location = @grid[@x_curr][@y_curr]
					puts "Your location is now #{@curr_location}. Your destination is #{@show_destination}."
				end
			else
				puts "I'm sorry, that's not an option. Please choose up, down, left, or right."
			end
		end
	end
end

puts "To start a game, use the #new_game method. A1 is the bottom left of the grid for all games. Recommended map size: 5. Recommended health: 100. For added diffcult, begin with 'new_game(true).'"