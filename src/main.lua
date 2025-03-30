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
  graphics.setColor({ 0, 1, 0.35 })
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
  ---@param shape Polygon
  ["player"] = function(shape)
    local speed = 800
      local torque = 3000
    if love.keyboard.isDown("up") then shape.body:applyForce(0, -speed) end
    if love.keyboard.isDown("down") then shape.body:applyForce(0, speed) end
    if love.keyboard.isDown("left") then shape.body:applyForce(-speed, 0) end
    if love.keyboard.isDown("right") then shape.body:applyForce(speed, 0) end

    if love.keyboard.isDown("space") then
      ---@diagnostic disable-next-line: param-type-mismatch
      if love.keyboard.isDown("lshift") then
        shape.body:applyTorque(torque)
      else
        shape.body:applyTorque(torque)
      end
    end
  end,
}

---@param delta number
function love.update(delta)
  world:update(delta)
  update["color"](delta)
  update["player"](entities["triangle"])
end
