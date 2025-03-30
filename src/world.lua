local shapes = require('shapes')
local physics = love.physics
local world = physics.newWorld(0, 48, true)

---@alias Shape { body: love.Body, shape: love.PolygonShape, fixture: love.Fixture}
---@type  table<string, Polygon>
local entities = {}

entities["triangle"] = Polygon:new(world, shapes["square"], 10, "dynamic", {200, 200})
entities["floor"] = Polygon:new(world, shapes["slanted-floor"], 300, "static", {40, 400})

return { world, entities }
