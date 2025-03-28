local number = 1

---@class Polygon
---@field vertices [number, number][]
local Polygon = {}
Polygon.__index = Polygon

---@param vertices [number, number][]
---@return Polygon
function Polygon:new(vertices)
  self = setmetatable({}, Polygon)
  self.vertices = vertices
  return self
end

---@return number[]
function Polygon:normalizedVertices()
  local output = {}
  for i = 1, #self.vertices do
    output[#output + 1] = self.vertices[i][1]
    output[#output + 1] = self.vertices[i][2]
  end
  return output
end

---@param value number
---@param coordinate "x" | "y" | "both"
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

local my_poly = Polygon:new({ { 50, 0 }, { 0, 100 }, { 100, 100 } })

function love.draw()
  number = number + 1;
  love.graphics.print(tostring(number), 300, number)
  my_poly:update("both", 1)
  love.graphics.polygon('line', my_poly:normalizedVertices())
end
