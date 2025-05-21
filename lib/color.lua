

function set_draw_color_from_hex(rgba)
    local rb = tonumber(string.sub(rgba, 2, 3), 16)
    local gb = tonumber(string.sub(rgba, 4, 5), 16)
    local bb = tonumber(string.sub(rgba, 6, 7), 16)
    local ab = tonumber(string.sub(rgba, 8, 9), 16) or nil
    love.graphics.setColor(love.math.colorFromBytes(rb, gb, bb, ab))
end
