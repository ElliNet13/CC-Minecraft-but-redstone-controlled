term.clear()
term.setCursorPos(1,1)
print("ElliNet13's Controller for CC:Minecraft")
print("Orginal by Xella: wget run https://pinestore.cc/projects/2/cc-minecraft")
print("Github Repo for the controller: https://github.com/ElliNet13/CC-Minecraft-but-redstone-controlled")

local mon = peripheral.find("monitor")
local moveRelay = peripheral.wrap("redstone_relay_4")
local cameraRelay = peripheral.wrap("redstone_relay_5")
local upDownRelay = peripheral.wrap("redstone_relay_6")
local leftRightClickRelay = peripheral.wrap("redstone_relay_7")

if mon then
    mon.clear()
    term.redirect(mon)
else
    error("Monitor not found", 3)
end

if not moveRelay then
    error("Movement relay not found", 3)
end

if not cameraRelay then
    error("Camera relay not found", 3)
end

if not upDownRelay then
    error("Up down relay not found", 3)
end

-- Map movement relay sides to keys
local relayKeysMove = {
    top = keys.w,
    left = keys.d,
    bottom = keys.s,
    right = keys.a
}

-- Tracks previous movement relay state to avoid duplicate events
local previousStateMove = {
    top = false,
    left = false,
    bottom = false,
    right = false
}

-- Map movement relay sides to keys
local relayKeysCamera = {
    top = keys.up,
    left = keys.right,
    bottom = keys.down,
    right = keys.left
}

-- Tracks previous movement relay state to avoid duplicate events
local previousStateCamera = {
    top = false,
    left = false,
    bottom = false,
    right = false
}

-- Map up down relay sides to keys
local relayKeysUpDown = {
    top = keys.space,
    bottom = keys.leftShift,
}

-- Tracks previous up down relay state to avoid duplicate events
local previousStateUpDown = {
    top = false,
    bottom = false,
}

local function start()
    parallel.waitForAny(function()
        while true do
            local event, side, x, y = os.pullEvent()
            
            -- Monitor touches
            if event == "monitor_touch" then
                local button
                if leftRightClickRelay.getInput("front") then
                    button = 1
                else
                    button = 2
                end
                os.queueEvent("mouse_click", button, x, y)
            end

            -- Redstone/relay input
            if event == "redstone" then
                -- Power button
                if not redstone.getInput("front") then
                    return
                end

                -- Move relays
                for side, key in pairs(relayKeysMove) do
                    if moveRelay.getInput(side) and not previousStateMove[side] then
                        os.queueEvent("key", key)
                        -- Queue char event if it's a printable character
                        local char = keys.getName(key)
                        if char and #char == 1 then
                            os.queueEvent("char", char)
                        end
                        previousStateMove[side] = true
                    elseif not moveRelay.getInput(side) then
                        os.queueEvent("key_up", key)
                        previousStateMove[side] = false
                    end
                end

                -- Camera relays
                for side, key in pairs(relayKeysCamera) do
                    if cameraRelay.getInput(side) and not previousStateCamera[side] then
                        os.queueEvent("key", key)
                        local char = keys.getName(key)
                        if char and #char == 1 then
                            os.queueEvent("char", char)
                        end
                        previousStateCamera[side] = true
                    elseif not cameraRelay.getInput(side) then
                        os.queueEvent("key_up", key)
                        previousStateCamera[side] = false
                    end
                end

                -- Up/down relays
                for side, key in pairs(relayKeysUpDown) do
                    if upDownRelay.getInput(side) and not previousStateUpDown[side] then
                        os.queueEvent("key", key)
                        local char = keys.getName(key)
                        if char and #char == 1 then
                            os.queueEvent("char", char)
                        end
                        previousStateUpDown[side] = true
                    elseif not upDownRelay.getInput(side) then
                        os.queueEvent("key_up", key)
                        previousStateUpDown[side] = false
                    end
                end
            end
        end
    end, function()
        require("Minecraft")
    end)
end

if redstone.getInput("front") then
    start()
end

sleep(2)
if not redstone.getInput("front") then
    term.clear()
    term.setCursorPos(1,1)
end

print("Device powered off. Turn on the lever on the front of the computer to restart.")

while not redstone.getInput("front") do
    sleep(2)
end

os.reboot()