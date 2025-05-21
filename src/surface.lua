

local spr_surface_back = love.graphics.newImage("asset/image/surface_back.png")
local spr_surface_front = love.graphics.newImage("asset/image/surface_front.png")
local STARTING_Y = 10

SurfaceSection = {}
SurfaceSection.__index = SurfaceSection

local surface_sections={}

local s_batch = love.graphics.newSpriteBatch(spr_surface_front, 30)
local s_batch_back = love.graphics.newSpriteBatch(spr_surface_back, 30)


function SurfaceSection:new(x, y)
	local _section = setmetatable({}, SurfaceSection)
	_section.x = x
	_section.y = y
	return _section
end

function SurfaceSection:update()

end

function SurfaceSection:draw_back()
	love.graphics.draw(spr_surface_back, self.x, self.y)
end

function SurfaceSection:draw_front()
	love.graphics.draw(spr_surface_front, self.x, self.y)
end

function SurfaceSection:move_up()
	local _y = love.math.random( STARTING_Y-1, STARTING_Y+1 )
	local _t = love.math.random( 1.5, 3.5 )
	local _d = love.math.random( 0.1, 1 )
	flux.to(self, _t, {y = _y}):delay(_d):oncomplete(function() self:move_up() end)
end

function SurfaceSection:move_down()
	flux.to(self, 5, {y = STARTING_Y + 3}):after(self, 5, {y = STARTING_Y}):oncomplete(function() self:move_up() end)
end

function set_up_surface()
	love.math.setRandomSeed(love.timer.getTime())
	
	for i = 0, 29 do
		_y = love.math.random( STARTING_Y-1, STARTING_Y+1 )
		local _s_section = SurfaceSection:new(i*8, _y)
		_s_section:move_up()
		table.insert(surface_sections, _s_section)
	end

	s_batch:clear()
	s_batch_back:clear()

	for _, entity in ipairs(surface_sections) do
		s_batch:add(entity.x, entity.y)
		s_batch_back:add(entity.x, entity.y)
	end
end

function update_surfaces()
	for i = 0, 29 do
		local _index = i + 1
		s_batch:set((_index), surface_sections[_index].x, surface_sections[_index].y)
		s_batch_back:set((_index), surface_sections[_index].x, surface_sections[_index].y)
	end
end

function draw_surface_back()
   love.graphics.draw(s_batch_back)
end

function draw_surface_front()
	love.graphics.draw(s_batch)
end
