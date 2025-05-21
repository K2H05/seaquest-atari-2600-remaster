local DEBUG_IMAGE = love.graphics.newImage("asset/image/test_diver_ui_sheet.png")
local diver_null = love.graphics.newImage("asset/image/diver_null.png")


diver_HUD = {
    x_pos = 110,
    y_pos = 125,
    scale = 0.7,
    frame = 1,
    frames = {
        love.graphics.newQuad(0, 0, 62, 15, DEBUG_IMAGE),
        love.graphics.newQuad(62, 0, 62, 15, DEBUG_IMAGE),
        love.graphics.newQuad(124, 0, 62, 15, DEBUG_IMAGE),
        love.graphics.newQuad(186, 0, 62, 15, DEBUG_IMAGE),
        love.graphics.newQuad(248, 0, 62, 15, DEBUG_IMAGE),
        love.graphics.newQuad(310, 0, 62, 15, DEBUG_IMAGE),
        love.graphics.newQuad(372, 0, 62, 15, DEBUG_IMAGE),
    },
    update_display = function(self, new_amount)
        self.frame = new_amount + 1
    end,
    draw = function(self)
        love.graphics.draw(DEBUG_IMAGE, self.frames[self.frame], self.x_pos, self.y_pos, 0, self.scale, self.scale)
    end,
}


