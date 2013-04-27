useful = {}

function useful.sign(val)
	if val == 0 then
		return 1
	else
		return math.abs(val)/val
	end
end

function useful.tri(cond, a, b)
	if cond then
		return a
	else
		return b
	end
end

math.sign = useful.sign