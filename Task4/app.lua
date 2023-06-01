local lapis = require("lapis")
local json_params = require("lapis.application").json_params
local app = lapis.Application()
local cjson = require("cjson.safe")

local Products = {}
Products.__index = Products

categories = {}
products = {}

function getData()
  ngx.req.read_body()
  local convertedJson, data = pcall(function() return cjson.decode(ngx.req.get_body_data()) end)
  if not convertedJson then
    return nil
  elseif not data then
    return {}
  else
    return data
  end
end

function Products.new(id, name, category, price)
  local self = setmetatable({}, Products)
  self.id = id
  self.productname = name
  self.category = category
  self.price = price
  return self
end

local Categories = {}
Categories.__index = Categories

function Categories.new(id, category)
  local self = setmetatable({}, Categories)
  self.id = id
  self.category = category
  return self
end

categories = {}
local obj1 = Categories.new(1, "TV")
local obj2 = Categories.new(2, "Laptop")
local obj3 = Categories.new(3, "Headphones")
table.insert(categories, obj1)
table.insert(categories, obj2)
table.insert(categories, obj3)

local products = {}
local prod1 = Products.new(1, "MacBook", "laptop", "1000$")
local prod2 = Products.new(2, "Samsung TV", "TV", "1000$")
local prod3 = Products.new(3, "airPods", "Headphones", "100$")



app:get("/categories", function()
  return { status = 200, json = categories }
end)

app:get("/products", function()
  return { status = 200, json = products }
end)

app:get("/categories/:id", json_params(function(self)
  for k, v in pairs(categories) do
    if v[1] == tonumber(self.params.id) then
      return { status = 200, json = v  }
    else
      return { status = 404, json = { message = "Category not found" } }
    end
  end
end))


app:post("/categories", json_params(function(self)
  local data = getData()
  if not data or data == {} then
    return { status = 404, json = { message = "Error" } }
  else
    newobj = Categories.new(data.id, data.name);
    table.insert(categories, newobj)
    return { status = 200, json = categories }
  end
end))

app:delete("/categories/:id", function(self)
  for k, v in pairs(categories) do
    if v[1] == tonumber(self.params.id) then
      table.remove(categories, v)
      return { status = 200, json = v  }
    else
      return { status = 404, json = { message = "Category not found" } }
    end
  end
end)



return app