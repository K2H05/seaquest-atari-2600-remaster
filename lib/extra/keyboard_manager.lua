local KeyboardManager = {}

local key_states = {}

function KeyboardManager:update(dt)
    for k, v in pairs(key_states) do
        key_states[k] = nil
    end
end

function KeyboardManager:init()
    function love.keypressed(key, scancode, isrepeat)
        key_states[key] = true
    end
    function love.keyreleased(key, scancode)
        key_states[key] = false
    end
end

function KeyboardManager:is_held(key)
    return love.keyboard.isDown(key)
end

function KeyboardManager:just_pressed(key)
    return key_states[key]
end

function KeyboardManager:just_released(key)
    return key_states[key] == false
end

return KeyboardManager