local spr_left = love.graphics.newImage("asset/image/mini_submarine/mini_sub_left.png")
local spr_right = love.graphics.newImage("asset/image/mini_submarine/mini_sub_right.png")

MiniSubParts = {}
MiniSubParts.__index = MiniSubParts

sub_parts = {}

function MiniSubParts:new(x, y, dir)
	local _mini_sub_parts = setmetatable({}, MiniSubParts)
	_mini_sub_parts.base_x = x
	_mini_sub_parts.base_y = y
	_mini_sub_parts.alpha = 1
	_mini_sub_parts.left_spr = { x = x, y = y, rot = 0 }
	_mini_sub_parts.right_spr = { x = x, y = y, rot = 0 }
	_mini_sub_parts.xvel = 0
	_mini_sub_parts.move_speed = 3
	_mini_sub_parts.facing_dir = dir
	_mini_sub_parts.origin = { x = 11, y = 8 }

	return _mini_sub_parts
end

function MiniSubParts:update()
	self.left_spr.x = self.left_spr.x - (0.5 * self.facing_dir)
	self.right_spr.x = self.right_spr.x + (0.5 * self.facing_dir)

	self.left_spr.rot = self.left_spr.rot - (0.05 * self.facing_dir)
	self.right_spr.rot = self.right_spr.rot + (0.05 * self.facing_dir)

	self.right_spr.y = self.right_spr.y + 1
	self.left_spr.y = self.left_spr.y + 1

	if self.right_spr.y >= self.base_y + 20 then
		table.remove_item(sub_parts, self)
	end
end

function MiniSubParts:fade_away(starting_y)

end

function MiniSubParts:draw()
	love.graphics.draw(spr_left, self.left_spr.x, self.left_spr.y, self.left_spr.rot, self.facing_dir, 1, self.origin.x, self.origin.y)
	love.graphics.draw(spr_right, self.right_spr.x, self.right_spr.y, self.right_spr.rot, self.facing_dir, 1, self.origin.x, self.origin.y)
end

function spawn_sub_peices(x, y, dir)
	_sp = MiniSubParts:new(x, y, dir)
	table.insert(sub_parts, _sp)
end
