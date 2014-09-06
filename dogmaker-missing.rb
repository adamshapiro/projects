class Dog
	def self.bark
		"bark like a #{self.class.name}"
	end	
end

class DogFactory
	def self.method_missing(meth)
		/^create_(.*)/.match(meth) {|m| m[1] = Class.new(Dog)}
	end
end
