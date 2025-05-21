OxygenBar = {}
OxygenBar.__index = OxygenBar

local O2_BAR_BG = love.graphics.newImage("asset/image/o2_bar.png")
local BASE_POSITION = {10,128}
local top=      {x=BASE_POSITION[1] + 3, y=BASE_POSITION[2] + 2.5}
local middle=   {x=BASE_POSITION[1] + 3, y=BASE_POSITION[2] + 3.5}
local bottom=   {x=BASE_POSITION[1] + 3, y=BASE_POSITION[2] + 4.5}

function OxygenBar:new()
    local _oxygen_bar = setmetatable({}, OxygenBar)
    _oxygen_bar.value = 0
    return _oxygen_bar
end

function OxygenBar:update()

end

function OxygenBar:draw()
    love.graphics.draw(O2_BAR_BG, BASE_POSITION[1], BASE_POSITION[2])
    love.graphics.push("all")
    change_draw_color("#ffffff")
    love.graphics.line(top.x, top.y, top.x + self.value, top.y)
    change_draw_color("#0ce6f2")
    love.graphics.line(middle.x, middle.y, middle.x + self.value, middle.y)
    change_draw_color("#0098db")
    love.graphics.line(bottom.x, bottom.y, bottom.x + self.value, bottom.y)
    love.graphics.pop()
end
