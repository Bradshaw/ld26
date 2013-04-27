useful = {}

function useful.sign(val)
	if val == 0 then
		return 1
	else
		return math.abs(val)/val
	end
end

math.sign = useful.sign