require('lib.polygon')
-- local my_poly = Polygon:new({ {100, 200}, {100, 100}, {200, 200}, {200, 100}})
local my_bow_tie = Polygon:new({ {0, 0}, {100, 0}, {100, 100}, {0, 100}})

local x = 180;
local my_color = { 1, 0, 0 }

function love.draw()
  local graphics = love.graphics
  graphics.setColor(my_color)
  graphics.polygon('fill', my_bow_tie:normalizedVertices())
end

---@param delta number
function love.update(delta)
  my_color[1] = ((1 + math.sin(x))/2) + 0.3
  x = (x + 0.01) % 360
  local speed = 80;
  if love.keyboard.isDown("up") then
    my_bow_tie:update("y", -speed * delta)
  end
  if love.keyboard.isDown("down") then
    my_bow_tie:update("y", speed * delta)
  end
  if love.keyboard.isDown("left") then
    my_bow_tie:update("x", -speed * delta)
  end
  if love.keyboard.isDown("right") then
    my_bow_tie:update("x", speed * delta)
  end
  if love.keyboard.isDown("space") then
    if love.keyboard.isDown("lshift") then
      my_bow_tie:rotate(10)
    else
      my_bow_tie:rotate(-10)
    end
  end
end
