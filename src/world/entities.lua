---@param world love.World
return function(world)
  local shapes = require('shapes')
  local entities = {}
  entities["triangle"] = Polygon:new(world, shapes.TRIANGLE, 10, "dynamic", {200, 40})
  entities["triangle"].fixture:setUserData("triangle")

  entities["floor"] = Polygon:new(world, shapes.FLOOR, 300, "static", {40, 400})
  entities["floor"].fixture:setUserData("floor")
  return entities
end
