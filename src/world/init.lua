local physics = love.physics
local world = physics.newWorld(0, 100, true)
local entities = require('world.entities')(world)
require('world.callbacks')(world)

return { world, entities }
