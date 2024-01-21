local unit = {}
unit.__index = unit
local sti = require("sti")
local map = sti("map.lua")
local GRID = require ("jumper.grid")
local PATHFINDER = require ("jumper.pathfinder")
local tileW, tileH = map.tilewidth, map.tileheight
local mapX, mapY = 0, 0 -- map offset
local mapH, mapW = map.height, map.width -- amount of tiles high and wide
local offsetX = (mapH * tileW) / 2
local MAP1 = {
    {1,1,1, 1,1,1, 1,1,1},
    {1,1,1, 1,1,1, 1,1,1},
    {1,1,1, 1,1,1, 1,1,1},

    {1,1,1, 1,1,1, 1,1,1},
    {1,1,1, 1,1,1, 1,1,1},
    {1,1,1, 1,1,1, 1,1,1},

    {1,1,1, 1,1,1, 1,1,1},
    {1,1,1, 1,1,1, 1,1,1},
    {1,1,1, 1,1,1, 1,1,1}
}
local MAP2 = map.layers[1].data -- not a valid map?!

function unit:new(x,y)
    local e = {}
    e.x = x
    e.y = y
    e.w = 128
    e.h = 64
    e.state = "idle"
    e.timeLimit = 0.1
    e.timer = e.timeLimit
    e.pathNodes = {}
    setmetatable(e, self)
    return e
end

function unit:update(dt)
    self.timer = self.timer - dt
    if #self.pathNodes > 1 and self.timer <= 0 then
        table.remove(self.pathNodes, 1)
        self.x = self.pathNodes[1].x
        self.y = self.pathNodes[1].y
        self.timer = self.timeLimit
    elseif #self.pathNodes == 1 then
        self.state = "idle"
        self.timer = self.timeLimit
    end
end

function unit:draw()
    local px = (mapX + (self.x * (self.w / 2)) - (self.y * (self.w / 2)))
    local py = (mapY + (self.y * (self.h / 2)) + (self.x * (self.h / 2)))
    love.graphics.setColor(1,0,0,.5)
    love.graphics.rectangle("fill", px + offsetX - 64, py - 64, self.w, self.h)
end

function unit:mousepressed(x,y,b)
    local cx = (y - mapY) / tileH + (x - offsetX - mapX) / tileW + 1
    local cy = (y - mapY) / tileH - (x - offsetX - mapX) / tileW + 1 -- it just werks!
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
    if b == 1 and self.state == "idle" and map.turn == self.team then
        if self.x == cx and self.y == cy then
            print("Path not found")
        elseif cy > 0 and cy <= mapH and cx > 0 and cx <= mapW then
            local grid = GRID(MAP1)
            local walkable = function(v) return v>=1 end
            local pathfinder = PATHFINDER(grid, "ASTAR", walkable)

            self.state = "moving"
            self.pathNodes = {}
            local path = pathfinder:setMode("DIAGONAL"):getPath(self.x, self.y, cx, cy)
            print("X:"..self.x.." ".."Y:"..self.y)
            print("X:"..cx.." ".."Y:"..cy)

            if path then
                print("Path found!")
                for node, count in path:nodes() do
                    table.insert(self.pathNodes, node)
                    --print(string.format("Step %d: (%d, %d)", count, node.x, node.y))
                end
            else
                self.state = "idle"
                print("Path not found")
            end
        end
    end
end

function unit:keypressed(k) -- use vector to alter movement...
    if k == "w" and self.y > 1 and self.x > 1 then -- up
        self.y = self.y - 1
        self.x = self.x - 1
    elseif k == "s" and self.y < mapH and self.x < mapW then -- down
        self.y = self.y + 1
        self.x = self.x + 1
    elseif k == "a" and self.y < mapH and self.x > 1 then -- left
        self.y = self.y + 1
        self.x = self.x - 1
    elseif k == "d" and self.y > 1 and self.x < mapW then -- right
        self.y = self.y - 1
        self.x = self.x + 1
    elseif k == "z" and self.y < mapH then -- down left diagonal
        self.y = self.y + 1
    elseif k == "e" and self.y > 1 then -- up right diagonal
        self.y = self.y - 1
    elseif k == "q" and self.x > 1 then -- up left diagonal
        self.x = self.x - 1
    elseif k == "c" and self.x < mapW then -- down right diagonal
        self.x = self.x + 1
    end
end

return unit