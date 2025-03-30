local world_pack = require('world')
local world = world_pack[1]
local entities = world_pack[2]

local color_brightness = 0;
local my_color = { 1, 0, 0 }

function love.draw()
  local graphics = love.graphics
  local triangle = entities["triangle"]
  local floor = entities["floor"]

  graphics.setColor(my_color)
  graphics.polygon('fill', triangle.body:getWorldPoints(triangle.shape:getPoints()))
  graphics.setColor({0, 1, 0.35})
  graphics.polygon('fill', floor.body:getWorldPoints(floor.shape:getPoints()))
end

local update = {
  ---updates the color
  ---@param delta number
  ["color"] = function(delta)
    local speed = 1
    my_color[1] = ((1 + math.sin(color_brightness)) / 2) + 0.3
    color_brightness = (color_brightness + speed * delta) % 360
  end,

  ---moves the player polygon (not workign rn)
  ---@param polgyon Polygon
  ---@param delta number
  ["player"] = function(polgyon, delta)
    local speed = 80 * delta;
    if love.keyboard.isDown("up") then polgyon:update("y", -speed) end
    if love.keyboard.isDown("down") then polgyon:update("y", speed) end
    if love.keyboard.isDown("left") then polgyon:update("x", -speed) end
    if love.keyboard.isDown("right") then polgyon:update("x", speed) end

    if love.keyboard.isDown("space") then
      ---@diagnostic disable-next-line: param-type-mismatch
      if love.keyboard.isDown("lshift") then
        polgyon:rotate(5)
      else
        polgyon:rotate(-5)
      end
    end
  end,
}

---@param delta number
function love.update(delta)
  world:update(delta)
  update["color"](delta)
end
