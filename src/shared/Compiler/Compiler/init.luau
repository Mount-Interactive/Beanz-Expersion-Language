--local Types = require(game:GetService("ReplicatedStorage").Constances.Types.Compiler)
--local Util  = require(script.Parent.Util)


--[[
local CheckIfString = Util.CheckIfString
local CheckIfNumberIsValid = Util.CheckIfNumberIsValid
]]
local Functions = script.Parent.Excutor.Functions


local AllowedCharacter = require(script.Parent.ValidCharacterList)




return function(Code: string)
    local Info = {}

    Info.CACHE = {}
    Info.Instructions = {}
    Info.ActiveValue = nil

    local CurrentFunction = ""
    local CurrentValue = ""
    local CurrentStage = 1

    for _, V in ipairs(Code:split("")) do
        if V == ";" then
            table.insert(Info.Instructions , `{CurrentFunction}  {CurrentValue}`)


            CurrentFunction = ""
            CurrentValue = ""
            CurrentStage = 1
        elseif table.find(AllowedCharacter, V) then
            if CurrentStage == 1 then
                CurrentFunction = `{CurrentFunction}{V}`
            else
                CurrentValue = `{CurrentValue}{V}`
            end
        elseif V == " " then
            if CurrentFunction ~= "" then
                CurrentStage = 2
                assert(Functions:FindFirstChild(CurrentFunction) , `[{script.Name}] {CurrentFunction} is not a valid function`)
            end
        end
    end
    





    return Info
end