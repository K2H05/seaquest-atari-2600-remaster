Battleship = {}
Battleship.__index = Battleship

local STARTING_X = -50

function Battleship:new()
    local _battleship = setmetatable({}, Battleship)

    _battleship.sprite = love.graphics.newImage("asset/image/battleship.png")
    _battleship.warning_sfx = love.audio.newSource("asset/audio/battleship_warning.ogg", "stream")

    _battleship.tmr_delay = Timer:new(function() _battleship:go() end, false)

    _battleship.x = STARTING_X
	_battleship.y = 4
	_battleship.moving_dir = 1
	_battleship.move_speed = 100
	_battleship.time_on_screen = 0
	_battleship.is_in_game = false
	_battleship.ox = _battleship.sprite:getWidth()/2
	_battleship.oy = _battleship.sprite:getHeight()/2

    return _battleship
end

function Battleship:update(dt)
    self.tmr_delay:update()
    if self.is_in_game then
    	self.time_on_screen = self.time_on_screen + 1
	    self.x = self.x + self.move_speed * self.moving_dir * dt
	    if self.time_on_screen >= 200 then
			self:reset()
	    end
    end
end

function Battleship:pass_by()
	love.audio.play_sfx(self.warning_sfx)
    self.tmr_delay:start(2*60)
end

function Battleship:go()
	self.is_in_game = true
	spawn_mine(40, 4)
	spawn_mine(82, -2)
	spawn_mine(124, -7)
	spawn_mine(166, -12)
	spawn_mine(208, -17)
end

function Battleship:reset()
	self.is_in_game = false
	self.x = STARTING_X
	self.time_on_screen = 0
	self.tmr_delay:stop()
end

function Battleship:draw()
	if self.is_in_game then
		love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, self.ox, self.oy)
	end
end



