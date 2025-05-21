Bubble = {}
Bubble.__index = Bubble

all_bubbles={}

function Bubble:new(x, y)
    local _bubble = setmetatable({}, Bubble)
    _bubble.x = x 
    _bubble.starting_y = y
    _bubble.y = y 
    _bubble.r = 1
    _bubble.dir = {0,-15}
    _bubble.kill_y = _bubble.starting_y - 25
    return _bubble
end

function Bubble:update(dt)
    self.y = self.y + self.dir[2] * dt
    --self.x = self.x + math.random(-0.01, 0.01)
    --self.r = self.r + 0.04
end

function Bubble:die(pos)
    --MAYBE: Add popping effect
end

function Bubble:draw()
    --love.graphics.push("all")
    --love.graphics.scale(0.5)
    love.graphics.circle("fill", self.x, self.y, self.r)
    --love.graphics.pop()

end

function update_bubbles(dt)
    for _, b in ipairs(all_bubbles) do
        b:update(dt)
    end
end

function draw_bubbles()
    for _, b in ipairs(all_bubbles) do
        if b.y > b.kill_y then
            b:draw()
        else
            table.remove(all_bubbles, _)
        end
    end
end

