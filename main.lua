require('lib.polygon')
local number = 1
local my_poly = Polygon:new({ { 50, 0 }, { 0, 100 }, { 100, 100 } })
local my_bow_tie = Polygon:new({ {100, 200}, {100, 100}, {200, 200}, {200, 100}})

function love.draw()
  number = number + 1;
  love.graphics.print(tostring(number), 300, number)
  my_poly:update("xy", 1)
  my_bow_tie:update("x", 0.5)
  love.graphics.polygon('fill', my_poly:normalizedVertices())
  love.graphics.polygon('line', my_bow_tie:normalizedVertices())
end
