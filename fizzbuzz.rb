def fizzbuzz(a=1,e)
	count = Array.new
while a <= e
	count << a
	a += 1
end
count.each do |i|
if (i%3==0 && i%5 != 0) 
	puts "Fizz"
elsif (i%3 != 0 && i%5 == 0) 
	puts "Buzz"
elsif (i%3==0 && i%5 == 0) 
	puts "FizzBuzz"
else 
	puts "#{i}"
end
end
end
fizzbuzz(1,100)