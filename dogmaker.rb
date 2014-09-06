class Dog
	def self.bark
		"bark like a #{self.name}"
	end
end

class DogFactory
	def self.create dog_name
		Object.const_set(dog_name.capitalize, Class.new(Dog))
	end
end