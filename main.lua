require('lib.polygon')
-- local my_poly = Polygon:new({ {100, 200}, {100, 100}, {200, 200}, {200, 100}})
-- local my_bow_tie = Polygon:new({ -- don't ask me what this is
--   {55, 45}, {100, 45}, {100, 100}, {90, 100}, {90, 55}, {55, 55}, {55, 100},
--   {0, 100}, {0, 90}, {45, 90}, {45, 55}, {0, 55}, {0, 0}, {10, 0}, {10, 45},
--   {45, 45}, {45, 0}, {100, 0}, {100, 10}, {55 , 10},
-- })
local my_bow_tie = Polygon:new({{50, 0}, {100, 90}, {0,90}})

local x = 0;
local my_color = { 1, 0, 0 }

function love.draw()
  local graphics = love.graphics
  graphics.setColor(my_color)
  graphics.polygon('fill', my_bow_tie:normalizedVertices())
end

---@param delta number
function love.update(delta)
  my_color[1] = ((1 + math.sin(x)) / 2) + 0.3
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
      my_bow_tie:rotate(5)
    else
      my_bow_tie:rotate(-5)
    end
  end
end
