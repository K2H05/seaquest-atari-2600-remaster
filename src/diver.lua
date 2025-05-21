Diver = {}
Diver.__index = Diver

all_divers = {}

local spr_sheet = love.graphics.newImage("asset/image/diver.png")
local s_grid = anim8.newGrid(17, 16, spr_sheet:getWidth(), spr_sheet:getHeight())
local _sfx_diver_saved = love.audio.newSource("asset/audio/on_collect.wav", "static")

function Diver:new(x, y, facing_dir, speed_multiplier)
    local _diver = setmetatable({}, Diver)
    
    _diver.animations = {
        default = anim8.newAnimation(s_grid(('1-2'), 1), 0.3),
    }
    _diver.curr_animation = _diver.animations["default"]
    _diver.is_alive = true
    _diver.facing_dir = facing_dir
    _diver.sx = 0.6 * facing_dir
    _diver.sy = 0.6
    _diver.x = x
    _diver.y = y
    _diver.BASE_SPEED = 20
    _diver.move_speed = _diver.BASE_SPEED+ (10 * speed_multiplier)
    _diver.w, _diver.h = _diver.curr_animation:getDimensions()
    _diver.hitbox = { x = _diver.x, y = _diver.y, w = _diver.w-6, h = _diver.h -10}
    return _diver
end


function Diver:update(dt)
    self.curr_animation:update(dt)
    self.x = self.x + self.move_speed * self.facing_dir * dt
    self.hitbox.x = (self.x - self.w /2)+2
    self.hitbox.y = (self.y - self.h/2) +3
    
end

function Diver:flee()
    self.facing_dir = (self.facing_dir * -1)
    self.sx = (self.sx * -1)
    self.move_speed = self.move_speed * 2
end

function Diver:draw()
    self.curr_animation:draw(spr_sheet, self.x, self.y - 2, 0, self.sx, self.sy, self.w / 2, self.h / 2)
    --draw_hitbox(self.hitbox, "#3e8948")
end

function update_divers(dt)
    for _, d in ipairs(all_divers) do
        if check_collision(d.hitbox, player.hitbox) then
            if player.diver_on_board < 6 then
                player.diver_on_board = player.diver_on_board + 1
                diver_HUD:update_display(player.diver_on_board)
                table.remove_item(all_divers, d)
                love.audio.play_sfx(_sfx_diver_saved)
            end
        end

        for _, t in ipairs(player_torpedos) do
            if check_collision(d.hitbox, t.hitbox) then
                d:flee()
                table.remove(player_torpedos, _)
                
            end
        end
        d:update(dt)
    end
end

function draw_divers()
    for p in table.for_each(all_divers) do
        p:draw()
    end
end