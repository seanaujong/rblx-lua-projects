--if 100 Bronze = 1 Silver and 100 Silver = 1 Gold

function convert(sgold, ssilver, sbronze)
	local fgold = sgold
	local fsilver = ssilver
	local fbronze = sbronze
	
	if sbronze >= 100 then
		fsilver = fsilver + math.floor(fbronze/100)
		fbronze = fbronze%100
	end
	
	if ssilver >= 100 then
		fgold = fgold + math.floor(fsilver/100)
		fsilver = fsilver%100
	end
	
	return fgold, fsilver, fbronze
end

print(convert(100,100,100))