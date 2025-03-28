---@class Polygon
---@field vertices [number, number][]
Polygon = {}
Polygon.__index = Polygon

---# Constructer for the Polygon class
---@param vertices [number, number][]
---@return Polygon
function Polygon:new(vertices)
  self = setmetatable({}, Polygon)
  self.vertices = vertices
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
