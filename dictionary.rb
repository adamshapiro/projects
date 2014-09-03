f = File.open('C:\Users\Adam Shapiro\Desktop\dictionary.txt')

@data = File.readlines(f)

@dict_hash = Hash.new {|h,k| h[k] = []}

def anagram
	@data.each do |text|
		@dict_hash[text.split.sort.join] << text
	end
	j = []
	@dict_hash.each do |k,v|
		j.delete_if {|less| @dict_hash[less].count < v.count}
		j << k
	end
	if @dict_hash[j.last].count < @dict_hash[j.first].count
		j.delete(j.last)
	end
	return j
end