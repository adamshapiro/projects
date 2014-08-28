def double(hash)
	hash.each do |k,array|
		array.map { |e| e*2 }
	end
end