local spr_left = love.graphics.newImage("asset/image/shark_left.png")
local spr_right = love.graphics.newImage("asset/image/shark_right.png")

SharkPart = {}
SharkPart.__index = SharkPart

shark_parts = {}

function SharkPart:new(x, y, dir)
	local _shark_part = setmetatable({}, SharkPart)
	_shark_part.base_x = x
	_shark_part.base_y = y
	_shark_part.alpha = 1
	_shark_part.left_spr = { x = x, y = y, rot = 0 }
	_shark_part.right_spr = { x = x, y = y, rot = 0 }
	_shark_part.xvel = 0
	_shark_part.move_speed = 3
	_shark_part.facing_dir = dir
	_shark_part.origin = { x = 11, y = 8 }

	return _shark_part
end

function SharkPart:update()
	self.left_spr.x = self.left_spr.x - (0.5 * self.facing_dir)
	self.right_spr.x = self.right_spr.x + (0.5 * self.facing_dir)

	self.left_spr.rot = self.left_spr.rot - (0.05 * self.facing_dir)
	self.right_spr.rot = self.right_spr.rot + (0.05 * self.facing_dir)

	self.right_spr.y = self.right_spr.y + 1
	self.left_spr.y = self.left_spr.y + 1

	if self.right_spr.y >= self.base_y + 20 then
		table.remove_item(shark_parts, self)
	end
end

function SharkPart:fade_away()

end

function SharkPart:draw()
	love.graphics.draw(spr_left, self.left_spr.x, self.left_spr.y, self.left_spr.rot, self.facing_dir, 1, self.origin.x, self.origin.y)
	love.graphics.draw(spr_right, self.right_spr.x, self.right_spr.y, self.right_spr.rot, self.facing_dir, 1, self.origin.x, self.origin.y)
end

function spawn_shark_peices(x, y, dir)
	_sp = SharkPart:new(x, y, dir)
	table.insert(shark_parts, _sp)
end
