

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
    set_draw_color_from_hex(hex)
end

function changeBgColor(hex)
    love.graphics.setBackgroundColor(_color(hex))
end

function draw_hitbox(obj, color)
    love.graphics.push("all")
    set_draw_color_from_hex(color)
    love.graphics.rectangle("line", obj.x, obj.y, obj.w, obj.h)
    love.graphics.pop()
end

function print_mouse_pos(x,y, scale) 
	local mx, my = love.mouse.getPosition()
	love.graphics.print("mPos: ("..mx/scale..","..my/scale..")",x,y,0,2,2)
end

-- TABLES
function table.for_each(_list)
    local i = 0
    return function()
        i = i + 1; return _list[i]
    end
end

function table.remove_item(_table, _item)
    for i, v in ipairs(_table) do
        if v == _item then
            _table[i] = _table[#_table]
            _table[#_table] = nil
            return
        end
    end
end

function table.has_value(tbl, value)
    for k, v in ipairs(tbl) do 
        if v == value or (type(v) == "table" and table.has_value(v, value)) then 
            return true 
        end
    end
    return false
end


function table.clear(tbl)
    for k, _ in pairs(tbl) do
        tbl[k] = nil
    end
end

---@param obj table
---@param rect table with screen data {x=0,y=0,w=0,h=0}
function is_on_screen(obj, rect)
    if ((obj.x >= rect.x + rect.w) or
           (obj.x + obj.w <= rect.x) or
           (obj.y >= rect.y + rect.h) or
           (obj.y + obj.h <= rect.y)) then
              return false 
    else return true
    end
end