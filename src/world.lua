local shapes = require('shapes')
local physics = love.physics
local world = physics.newWorld(0, 9.8, true)

---@alias Shape { body: love.Body, shape: love.PolygonShape, fixture: love.Fixture}
---@type  table<string, Shape>
local entities = {}
---@type Shape
local triangle = {}
triangle.body = physics.newBody(world, 200, 200, "dynamic")
triangle.body:setMass(10)
triangle.shape = physics.newPolygonShape(shapes["triangle"]:normalizedVertices())
triangle.fixture = physics.newFixture(triangle.body, triangle.shape)

entities["triangle"] = triangle

return { world, entities }
