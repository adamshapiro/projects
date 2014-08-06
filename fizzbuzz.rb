count = Array.new

def fizzbuzz(a=1,e)
while a <= e do
	count.push(a)
	a.next
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
fizzbuzz(1,100)