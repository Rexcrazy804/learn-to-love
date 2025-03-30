---@alias vertexSet [number, number]
---@class Polygon
---@field vertices (vertexSet)[]
---@field world love.World
---@field body love.Body
---@field shape love.PolygonShape
---@field fixture love.Fixture
Polygon = {}
Polygon.__index = Polygon

---# Constructer for the Polygon class
---@param vertices (vertexSet)[]
---@param world love.World
---@param mass number
---@param type? love.BodyType
---@param worldPosition? vertexSet
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
