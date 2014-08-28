require 'CSV'

f = File.open('C:\Users\Adam Shapiro\Desktop\transaction.txt')

@data = CSV.parse(f.read)

def customers(array)
	a = []
	array.each do |names|
		unless array.index(names) == 0
			a << names[2]
		end
	end
	a.uniq!
end

def charges(array)
	a=[]
	array.each do |charge|
		unless array.index(charge) == 0
			charge[21].to_i
			a << charge[21]
		end
	end
	a.inject{|sum,x| sum + x}
end