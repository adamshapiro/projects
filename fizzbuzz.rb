fizzbuzz = Array.new

def fizzbuzz.endpoint(number) do |i|
	i == 1
	fizzbuzz << i
	i.next
	if i==number 
		break

fizzbuzz.each do |i|
if (i%3==0 && i%5 != 0) 
	puts "Fizz"
elsif (i%3 != 0 && i%5 == 0) 
	puts "Buzz"
elsif (i%3==0 && i%5 == 0) 
	puts "FizzBuzz"
else 
	puts i
end
end
fizzbuzz.endpoint(100)