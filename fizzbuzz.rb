def fizzbuzz(a=1,e)
	count = Array.new
while a <= e
	count << a
	a.next!
end
count.each do |i|
if (i%3==0 && i%5 != 0) 
	puts "Fizz"+/n
elsif (i%3 != 0 && i%5 == 0) 
	puts "Buzz" + /n
elsif (i%3==0 && i%5 == 0) 
	puts "FizzBuzz" + /n
else 
	puts "#{i}" + /n
end
end
end
puts fizzbuzz(1,100)