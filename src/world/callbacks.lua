---@param fixture1 love.Fixture
---@param fixture2 love.Fixture
---@param contact love.Contact
local begin_contact = function(fixture1, fixture2, contact)
  local object_1 = fixture1:getUserData() or "unknown1"
  local object_2 = fixture2:getUserData() or "unknown2"
  print(object_1 .. " and " .. object_2 .. " are touching each other");

  local x1, x2, x3, x4 = contact:getPositions()
  local c_points = { x1 , x2, x3, x4 }
  for index, point in ipairs(c_points) do
    print("[" .. index .. "]: " .. point)
  end
end

---@param fixture1 love.Fixture
---@param fixture2 love.Fixture
---@param contact love.Contact
local end_contact = function(fixture1, fixture2, contact)
  local object_1 = fixture1:getUserData() or "unknown1"
  local object_2 = fixture2:getUserData() or "unknown2"

  print(object_1 .. " and " .. object_2 .. " stopped touching each other");
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
