def euler1(num)
	a=0
	(1..(num-1)).each do |i|
		if (i%3==0 || i%5==0)
			a+=i
		end
	end
	return a
end

def euler2(num)
	a,b,c,d=0,0,1,1
	while a<=num do
		a=c+d
		if a%2==0
			b+=a
		end
		c=d
		d=a
	end
	return b
end