def double(hash)
	hash.each do |k,array|
		array.map { |e| e*2 }
	end
end

new_hash = {1=>[1,"one"],2=>[2,"two"],3=>[3,"three"]}

double(new_hash)