require("src.shark_parts")

Shark = {}
Shark.__index = Shark

all_sharks = {}

local _sfx_die = love.audio.newSource("asset/audio/player_die_2.wav", "stream")
local spr_sheet = love.graphics.newImage("asset/image/shark.png")
local s_grid = anim8.newGrid(22, 16, spr_sheet:getWidth(), spr_sheet:getHeight())

function Shark:new(x, y, facing_dir, speed_multiplier)
    local _shark = setmetatable({}, Shark)

    _shark.animations = {
        default = anim8.newAnimation(s_grid(('1-4'), 1), 0.2),
    }
    _shark.curr_animation = _shark.animations["default"]
    _shark.is_alive = true
    _shark.facing_dir = facing_dir
    _shark.x = x
    _shark.y = y
    _shark.BASE_SPEED = 40
    _shark.move_speed = _shark.BASE_SPEED + (10 * speed_multiplier)
    _shark.w, _shark.h = _shark.curr_animation:getDimensions()
    _shark.hitbox = { x = _shark.x, y = _shark.y, w = _shark.w - 6, h = _shark.h - 10 }

    return _shark
end

function Shark:update(dt)
    self.curr_animation:update(dt)
    self.x = self.x + self.move_speed * self.facing_dir * dt
    self.hitbox.x = (self.x - self.w / 2) + 2
    self.hitbox.y = (self.y - self.h / 2) + 3
end

function Shark:die()
    love.audio.play_sfx(_sfx_die)
    player:increase_score(get_kill_value("shark"))
    spawn_shark_peices(self.x, self.y, self.facing_dir)
    table.remove_item(all_sharks, self)
end

function Shark:draw()
    if is_on_screen(self.hitbox, SCREEN_RECT) then
        self.curr_animation:draw(spr_sheet, self.x, self.y - 2, 0, self.facing_dir, 1, self.w / 2, self.h / 2)
    end
end

function update_sharks(dt)
    for s in table.for_each(all_sharks) do
        if check_collision(s.hitbox, player.hitbox) then
            table.remove_item(all_sharks, s)
            player:die()
        end
        for t in table.for_each(player_torpedos) do
            if check_collision(s.hitbox, t.hitbox) then
                s:die()
                table.remove_item(player_torpedos, t)
            end
        end
        s:update(dt)
    end
end

function draw_sharks()
    for s in table.for_each(all_sharks) do
        s:draw()
    end
end
