require("src.bubble")
local spr_torpedo = love.graphics.newImage("asset/image/player_torpedo.png")

Torpedo = {}
Torpedo.__index = Torpedo

player_torpedos = {}

function Torpedo:new(x, y)
	local _torpedo = setmetatable({}, Torpedo)
	_torpedo.x = x
	_torpedo.y = y
	_torpedo.xvel = 0
	_torpedo.move_speed = 3
	_torpedo.facing_dir = 1
	_torpedo.trusting = false
	_torpedo.bubbles = {}
	_torpedo.add_bubble = 0
	_torpedo.w, _torpedo.h = spr_torpedo:getDimensions()
	_torpedo.h = 1
	_torpedo.hitbox = {
		x = _torpedo.x,
		y = _torpedo.y,
		w = _torpedo.w,
		h = _torpedo.h + 2
	}

	return _torpedo
end

function Torpedo:update(dt)
	if self.trusting then
		self.add_bubble = self.add_bubble + 1
		self.xvel = clamp(0, self.xvel + 0.05, 100)
		self.x = (self.x + (self.xvel * self.facing_dir))
		--self.x = self.x + self.move_speed * self.facing_dir
		if self.add_bubble >= 5 then
			table.insert(all_bubbles, Bubble:new(self.x, self.y))
			self.add_bubble = 0
		end
	end

	self.hitbox.x = (self.x - self.w / 2)
	self.hitbox.y = (self.y - 1)
end

function Torpedo:drop(starting_y)
	flux.to(self, 0.5, { y = starting_y + 4 }):oncomplete(function()
		self.trusting = true
		player.can_shoot = true
	end)
end

function Torpedo:draw()
	love.graphics.draw(spr_torpedo, self.x, self.y, 0, self.facing_dir, 1, 3, 1)
end

function draw_torpedos()
	for t in table.for_each(player_torpedos) do
        t:draw()
    end
end
