local Vec2 = {}

function Vec2:new(x, y)
	local _v2 = {}
	_v2.x = x or 0
	_v2.y = y or 0
end

return Vec2