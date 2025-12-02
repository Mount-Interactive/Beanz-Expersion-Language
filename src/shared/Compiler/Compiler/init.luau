local Types = require(game:GetService("ReplicatedStorage").Constances.Types.Compiler)
local Util  = require(script.Parent.Util)



local CheckIfString = Util.CheckIfString
local CheckIfNumberIsValid = Util.CheckIfNumberIsValid

local Functions = script.Parent.Excutor.Functions


return function(Code: string)
    local Seperated = Code:split(";")


    local Info = {}

    Info.CACHE = {}
    Info.Instructions = {}
    Info.ActiveValue = nil


    for _ , V in Seperated do
        local CommentCheck = V:split("--") -- comments are over rated

        if CommentCheck[2] then
            if CommentCheck[1] ~= "" then
                table.insert(Info.Instructions , CommentCheck[1])
            end
            continue
        end
        table.insert(Info.Instructions , V)
    end



    return Info
end