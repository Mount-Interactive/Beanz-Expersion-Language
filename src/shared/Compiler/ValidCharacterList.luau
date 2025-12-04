local Value = {}

local LongListOfAllValidCharacter = `ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890()abcdefghijklmnopqrstuvwxy`


for _ , V in LongListOfAllValidCharacter:split("") do
  table.insert(Value , V)
end

return Value