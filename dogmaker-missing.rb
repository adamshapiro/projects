class Dog
	def self.bark
		"bark like a #{self.name}"
	end	
end

class DogFactory
	def self.method_missing(meth)
		if m = /^create_(.*)/.match(meth).captures
			Object.const_set(m[0].capitalize,Class.new(Dog))
		else
			super
		end
	end
end
