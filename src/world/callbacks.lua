local log = require('lib.log')
---@param fixture1 love.Fixture
---@param fixture2 love.Fixture
---@param contact love.Contact
local begin_contact = function(fixture1, fixture2, contact)
  local object_1 = fixture1:getUserData() or "unknown1"
  local object_2 = fixture2:getUserData() or "unknown2"
  log.printlog(string.format("%s and %s started touching", object_1, object_2));

  local points = { contact:getPositions() }
  for i = 1, 4 do points[i] = points[i] or -1.69 end
  log.printlog(string.format("contact points (x1: %d, y1: %d), (x2: %d, y2: %d)",
    points[1],
    points[2],
    points[3],
    points[4]
  ))
end

---@param fixture1 love.Fixture
---@param fixture2 love.Fixture
---@param contact love.Contact
local end_contact = function(fixture1, fixture2, contact)
  local object_1 = fixture1:getUserData() or "unknown1"
  local object_2 = fixture2:getUserData() or "unknown2"

  log.printlog(string.format("%s and %s stopped touching", object_1, object_2));
end

---@param fixture1 love.Fixture
---@param fixture2 love.Fixture
---@param contact love.Contact
local pre_solve = function(fixture1, fixture2, contact)
end

---@param fixture1 love.Fixture
---@param fixture2 love.Fixture
---@param contact love.Contact
local post_solve = function(fixture1, fixture2, contact)
end

---@param world love.World
return function(world) world:setCallbacks(begin_contact, end_contact, pre_solve, post_solve) end
