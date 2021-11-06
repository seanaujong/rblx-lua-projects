local function isMultiple(multiple,number)
	if multiple%number == 0 then
		return true
	else
		return false
	end
end

for i = 1, 100 do
	if isMultiple(i,3) and isMultiple(i,5) then
		print("FizzBuzz")
	elseif isMultiple(i,3) then
		print("Fizz")
	elseif isMultiple(i,5) then
		print("Buzz")
	else
		print(i)
	end
end