class Dog
	def self.descendants
		ObjectSpace.each_object(Class).select {|a| a < self}
	end
end

class DogFactory
	def self.create dog_name
		dog_name = Class.new (Dog) do
			def self.bark
				"bark like a #{self.class.name}"
			end
		end
	end
end
