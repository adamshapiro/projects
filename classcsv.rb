require 'CSV'

f = "name,age,city\nbob,14,boston\njoan,20,cleveland\nkelvin,18,sydney\nmary,22,boston"

parsed = CSV.parse(f)

def people
	i=1
	while i < 4
		puts parsed[i][0]
		i += 1
	end
end

def citynum(city)
	a=0
	for i in parsed
		if parsed[i][2] = "city"
			a +=1
		end
	end
	return a
end