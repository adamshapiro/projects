class Dog
	def self.bark
		"bark like a #{self.name}"
	end	
end

class DogFactory
	def self.method_missing(method)
		match = /^create_(.*)/.match(method)
		if match
			dog_name = match.captures[0]
			Object.const_set(dog_name.capitalize,Class.new(Dog))
		else
			super
		end
	end
end
