local LANES = {
    40,
    50,
    60,
    70,
    80,
    90,
    100,
    110
}

local SIDES = {
    { x = -15, f_dir = 1 },
    { x = 250, f_dir = -1 }
}

local SPAWN_TYPES = {
    0, --Diver
    1, --Shark
    2  --MiniSub
}


local SPAWN_DIVER = 0
local SPAWN_SHARK = 1
local SPAWN_SUB = 2

local SPAWN_LEFT_X = -15
local SPAWN_RIGHT_X = 250

local FACE_LEFT = -1
local FACR_RIGHT = 1


local WAVES = {
    {
        { SPAWN_SUB,   SPAWN_RIGHT_X, 2 },
        { SPAWN_SHARK, SPAWN_RIGHT_X, 3 },
        { SPAWN_DIVER, SPAWN_RIGHT_X, 4 },
    },
    {
        { SPAWN_SHARK, SPAWN_LEFT_X,  2 },
        { SPAWN_DIVER, SPAWN_RIGHT_X, 5 },
        { SPAWN_DIVER, SPAWN_LEFT_X,  4 },
    },
    {
        { SPAWN_SHARK, SPAWN_LEFT_X, 3 },
        { SPAWN_SHARK, SPAWN_LEFT_X, 6 },
    },
    {
        { SPAWN_SHARK, SPAWN_RIGHT_X, 2 },
        { SPAWN_SHARK, SPAWN_RIGHT_X, 4 },
    },
    {
        { SPAWN_DIVER, SPAWN_RIGHT_X, 1 },
        { SPAWN_DIVER, SPAWN_LEFT_X,  4 },
    },
    {
        { SPAWN_DIVER, SPAWN_RIGHT_X, 2 },
        { SPAWN_DIVER, SPAWN_RIGHT_X, 6 },
    },
    {
        { SPAWN_DIVER, SPAWN_LEFT_X, 5 },
        { SPAWN_DIVER, SPAWN_LEFT_X, 2 },
        { SPAWN_DIVER, SPAWN_LEFT_X, 3 },
    },
    {
        { SPAWN_SUB,   SPAWN_LEFT_X,  2 },
        { SPAWN_DIVER, SPAWN_RIGHT_X, 3 },
        { SPAWN_SUB,   SPAWN_RIGHT_X, 4 },
        { SPAWN_SUB,   SPAWN_LEFT_X,  6 },
    },
    {
        { SPAWN_SHARK, SPAWN_RIGHT_X, 4 },
        { SPAWN_SHARK, SPAWN_RIGHT_X, 5 },
    },
    {
        { SPAWN_SUB, SPAWN_RIGHT_X, 4 },
        { SPAWN_SUB, SPAWN_RIGHT_X, 5 },
    },
    {
        { SPAWN_SUB, SPAWN_RIGHT_X, 1 },
        { SPAWN_SUB, SPAWN_RIGHT_X, 3 },
        { SPAWN_SUB, SPAWN_RIGHT_X, 5 },
    },
    {
        { SPAWN_SUB, SPAWN_LEFT_X, 1 },
        { SPAWN_SUB, SPAWN_LEFT_X, 3 },
        { SPAWN_SUB, SPAWN_LEFT_X, 5 },
    },
}


local die = {
    roll = function(self, sides)
        local _sides = sides or 6
        return math.random(_sides)
    end
}

----------------------------------------------------------------------------------------------------------------

Spawner = {}
Spawner.__index = Spawner

function Spawner:new()
    local _spawner = setmetatable({}, Spawner)
    _spawner.spawn_interval = 5 * 60
    _spawner.tmr_spawn_battleship = Timer:new(function() _spawner:spawn_battleship() end, true)
    _spawner.tmr_spawn_wave = Timer:new(function() _spawner:spawn_something() end, true)
    return _spawner
end

function Spawner:start()
    self.tmr_spawn_battleship:start(10 * 60)
    self.tmr_spawn_wave:start(self.spawn_interval)
end

function Spawner:update(dt)
    self.tmr_spawn_wave:update()
    self.tmr_spawn_battleship:update()
end

function Spawner:spawn_actor(type, side, lane)
    local _lane = math.max(1, math.min(lane, 8))
    local _facing_dir

    if side == SPAWN_RIGHT_X then
        _facing_dir = -1
    else
        _facing_dir = 1
    end

    if type == 0 then
        --spawn diver
        _diver = Diver:new(side, LANES[_lane], _facing_dir, level)
        table.insert(all_divers, _diver)
    elseif type == 1 then
        _shark = Shark:new(side, LANES[_lane], _facing_dir, level)
        table.insert(all_sharks, _shark)
    elseif type == 2 then
        _mini_sub = MiniSub:new(side, LANES[_lane], _facing_dir, level)
        table.insert(all_mini_subs, _mini_sub)
    end
end

function Spawner:spawn_something()
    math.randomseed(os.time())
    local _index = math.random(1, #WAVES)
    for w in table.for_each(WAVES[_index]) do
        self:spawn_actor(w[1], w[2], w[3])
    end
end

function Spawner:spawn_battleship()
    local d = die:roll(6)

    if d >= 5 then
        battleship:pass_by()
    end
end

function Spawner:reset()
    battleship:reset()
    self.tmr_spawn_battleship:stop()
    self.tmr_spawn_wave:stop()
    table.clear(all_divers)
    table.clear(all_mines)
    table.clear(all_sharks)
    table.clear(all_mini_subs)
    table.clear(player_torpedos)
end
