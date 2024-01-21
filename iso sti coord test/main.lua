local sti = require("sti")
local map = sti("map.lua")
local unit = require("unit")
local tileW, tileH = map.tilewidth, map.tileheight -- map.xyz to get layer properties!
local mapX, mapY = 0, 0 -- map offset
local mapH, mapW = map.height, map.width -- amount of tiles high and wide
local offsetX = (mapH * tileW) / 2 -- offset for pixel to tile coords logic
local entities = {}

function love.load() -- to do: pathfind object... get tile properties for pathfinding?!, how to draw unit on map coordinates?
    print(map.layers[1].data)
    print(map.layers[1].height)
    table.insert(entities, unit:new(1,1))
end

function love.update(dt) -- check if enemy occupies coords before moving!
    for i,u in ipairs(entities) do
        u:update(dt)
    end
end

function love.draw()
    love.graphics.setColor(1,1,1)
    map:draw(mapX, mapY)
    local mx, my = love.mouse.getPosition()
    local cx = (my - mapY) / tileH + (mx - offsetX - mapX) / tileW + 1
    local cy = (my - mapY) / tileH - (mx - offsetX - mapX) / tileW + 1 -- it just werks!
    if cx > mapW then
        cx = mapW
    elseif cx < 1 then
        cx = 1
    end
    if cy > mapH then
        cy = mapH
    elseif cy < 1 then
        cy = 1
    end
    love.graphics.print("X: "..math.floor(cx), 10, 10)
    love.graphics.print("Y: "..math.floor(cy), 10, 30)
    for i,u in ipairs(entities) do
        u:draw()
    end
end

function love.mousepressed(x,y,b)
    for i,u in ipairs(entities) do
        u:mousepressed(x,y,b)
    end
end

function love.keypressed(k)
    for i,u in ipairs(entities) do
        u:keypressed(k)
    end
end

