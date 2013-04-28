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

function useful.hsv(H, S, V, A, div, max, ang)
	local max = max or 255
	local ang = ang or 360
	local ang6 = ang/6
	local r, g, b
	local div = div or 100
	local S = (S or div)/div
	local V = (V or div)/div
	local A = (A or div)/div * max
	local H = H%ang
	if H>=0 and H<=ang6 then
		r = 1
		g = H/ang6
		b = 0
	elseif H>ang6 and H<=2*ang6 then
		r = 1 - (H-ang6)/ang6
		g = 1
		b = 0
	elseif H>2*ang6 and H<=3*ang6 then
		r = 0
		g = 1
		b = (H-2*ang6)/ang6
	elseif H>180 and H <= 240 then
		r = 0
		g = 1- (H-3*ang6)/ang6
		b = 1
	elseif H>4*ang6 and H<= 5*ang6 then
		r = (H-4*ang6)/ang6
		g = 0
		b = 1
	else
		r = 1
		g = 0
		b = 1 - (H-5*ang6)/ang6
	end
	local top = (V*max)
	local bot = top - top*S
	local dif = top - bot
	r = bot + r*dif
	g = bot + g*dif
	b = bot + b*dif

	return r, g, b, A
end

math.sign = useful.sign