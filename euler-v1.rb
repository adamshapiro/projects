def euler1(num)
	a=[]
	(1..(num-1)).each do |i|
		if (i%3==0 || i%5==0)
			a << i
		end
	end
	a.inject{|sum,i| sum+i}
end