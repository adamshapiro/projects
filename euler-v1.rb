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

def euler4
	a=[]
	(100..999).each do |x|
		(100..999).each do |y|
			if (x*y).to_s.reverse.to_i == (x*y)
				a << (x*y)
			end
		end
	end
	a.sort!
	return a[-1]
end