require 'CSV'

f = File.open('C:\Users\Adam Shapiro\Desktop\transaction.txt')

@data = CSV.parse(f.read, {:headers=>true})

def customers(array)
	a = []
	array.each do |names|
		a << names[2]
	end
	a.uniq!
end

def charges(array)
	a=0
	array.each do |charge|
		a += charge[21].to_i
	end
	return a
end