require('lib.polygon')
local number = 1
local my_poly = Polygon:new({ { 50, 0 }, { 0, 100 }, { 100, 100 } })
local my_cross = Polygon:fromNormal({100, 100, 200, 200, 100, 200, 200, 100})

function love.draw()
  number = number + 1;
  love.graphics.print(tostring(number), 300, number)
  my_poly:update("xy", 1)
  love.graphics.polygon('fill', my_poly:normalizedVertices())
  love.graphics.polygon('line', my_cross:normalizedVertices())
end
