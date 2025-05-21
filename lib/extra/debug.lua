
function draw_hitbox(obj, color)
    love.graphics.push("all")
    change_draw_color(color)
    love.graphics.rectangle("line", obj.hitbox.x, obj.hitbox.y, obj.hitbox.w, obj.hitbox.h)
    love.graphics.pop()
end


function _color(str, mul)
    mul = mul or 1
    local r, g, b, a
    r, g, b = str:match("#(%x%x)(%x%x)(%x%x)")
    if r then
      r = tonumber(r, 16) / 0xff
      g = tonumber(g, 16) / 0xff
      b = tonumber(b, 16) / 0xff
      a = 1
    elseif str:match("rgba?%s*%([%d%s%.,]+%)") then
      local f = str:gmatch("[%d.]+")
      r = (f() or 0) / 0xff
      g = (f() or 0) / 0xff
      b = (f() or 0) / 0xff
      a = f() or 1
    else
      error(("bad color string '%s'"):format(str))
    end
    return r * mul, g * mul, b * mul, a * mul
  end
  
  function change_draw_color(hex)
      love.graphics.setColor(_color(hex))
  end
  
  function changeBgColor(hex)
      love.graphics.setBackgroundColor(_color(hex))
  end
  