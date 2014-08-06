count = Array.new

fizzbuzz(number) do |i|
	i == 1
	count << i
	if i==number 
		break

if (i%3==0 && i%5 != 0) 
	puts "Fizz"
	i.next
elsif (i%3 != 0 && i%5 == 0) 
	puts "Buzz"
	i.next
elsif (i%3==0 && i%5 == 0) 
	puts "FizzBuzz"
	i.next
else 
	puts i
	i.next
end
fizzbuzz(100)