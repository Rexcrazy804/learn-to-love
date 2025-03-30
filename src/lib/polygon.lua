---@class Polygon
---@field vertices [number, number][]
---@field world love.World
---@field body love.Body
---@field shape love.PolygonShape
---@field fixture love.Fixture
Polygon = {}
Polygon.__index = Polygon

---# Constructer for the Polygon class
---@param vertices ([number, number])[]
---@param world love.World
---@param mass number
---@param type? love.BodyType
---@param worldPosition? [number, number]
---@return Polygon
function Polygon:new(world, vertices, mass, type, worldPosition)
  local physics = love.physics
  if worldPosition == nil then worldPosition = {0, 0} end

  self = setmetatable({}, Polygon)
  self.world = world
  self.vertices = vertices
  self.body = physics.newBody(world, worldPosition[1], worldPosition[2], type)
  self.body:setMass(mass)
  self.shape = physics.newPolygonShape(self:normalizedVertices())
  self.fixture = physics.newFixture(self.body, self.shape)

  return self
end

---# Converts `vertices` to number[]
---This function flattens the  `vertices` ``{[x1, y1], [x2, y2], ...}``
---into a flattened single dimensional aray ``{ x1, y1, x2, y2, ...}``
---@return number[]
function Polygon:normalizedVertices()
  local output = {}
  for i = 1, #self.vertices do
    output[#output + 1] = self.vertices[i][1]
    output[#output + 1] = self.vertices[i][2]
  end
  return output
end

---generates a `Polygon` from given vertex array
---@param flatvertices number[]
---@return Polygon
function Polygon:fromNormal(flatvertices)
  self = setmetatable({}, Polygon)
  self.vertices = {}
  for i = 1, #flatvertices, 2 do
    self.vertices[#self.vertices+1] = {
      flatvertices[i],
      flatvertices[i+1],
    }
  end
  return self
end

---increments the given `coordinate` by the given `value`
---@param value number
---@param coordinate 
---| "x"
---| "y"
---| "xy"
function Polygon:update(coordinate, value)
  for i = 1, #self.vertices do
    if coordinate == "x" then
      self.vertices[i][1] = self.vertices[i][1] + value
    elseif coordinate == "y" then
      self.vertices[i][2] = self.vertices[i][2] + value
    else
      self.vertices[i][1] = self.vertices[i][1] + value
      self.vertices[i][2] = self.vertices[i][2] + value
    end
  end
end

---rotates all vertices of the polygon by the given angle `theta`
---@param theta number
function Polygon:rotate(theta)
  local rad_theta = math.rad(theta)
  local centroid = self:get_centroid()

  -- first we apply a translation to shift the polygon to origin
  self:update("x", -centroid[1])
  self:update("y", -centroid[2])

  -- rotate all coordinates
  for i = 1, #self.vertices do
    local original = {}
    original[1] = self.vertices[i][1]
    original[2] = self.vertices[i][2]

    self.vertices[i][1] = original[1] * math.cos(rad_theta) - original[2] * math.sin(rad_theta)
    self.vertices[i][2] = original[2] * math.cos(rad_theta) + original[1] * math.sin(rad_theta)
  end

  -- revert to original position
  self:update("x", centroid[1])
  self:update("y", centroid[2])
end

---find the centroid of a non intersecting simple polygon
---@return [number, number] centroid x and y coordinates of the centroid
function Polygon:get_centroid()
  local sumX = 0
  local sumY = 0
  local vertex_count = #self.vertices
  for i = 1, vertex_count do
    sumX = sumX + self.vertices[i][1]
    sumY = sumY + self.vertices[i][2]
  end
  return { sumX/vertex_count, sumY/vertex_count}
end
