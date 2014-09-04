f = File.open('C:\Users\Adam Shapiro\Desktop\dictionary.txt')

@data = File.readlines(f)

@dict_hash = Hash.new {|h,k| h[k] = []}

def anagram
	@data.each do |text|
		if @dict_hash.key?((text.split('').sort - ["\n"]).join) == true
			@dict_hash[(text.split('').sort - ["\n"]).join] << text
		else
			@dict_hash[(text.split('').sort - ["\n"]).join] = []
			@dict_hash[(text.split('').sort - ["\n"]).join] << text
		end
	end
	j = @dict_hash.keys.first
	@dict_hash.each do |k,v|
		if v.count > @dict_hash[j].count
			j=k
		end
	end
	return @dict_hash[j]
end