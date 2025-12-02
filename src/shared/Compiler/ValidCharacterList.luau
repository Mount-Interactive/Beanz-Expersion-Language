local Value = {}

local LongListOfAllValidCharacter = `ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890()`


for _ , V in LongListOfAllValidCharacter:split("") do
  table.insert(Value , V)
end

return Value