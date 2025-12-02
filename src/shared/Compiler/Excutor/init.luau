local Excutor = {}
local Types = require(game:GetService("ReplicatedStorage").Constances)
local Util  = require(script.Parent.Util)



local CheckIfString = Util.CheckIfString
local CheckIfNumberIsValid = Util.CheckIfNumberIsValid

local VALID_FUNCTION_THAT_CAN_TAKE_STRING = {
    "WRITE",


}



local function ReadFromCache(Info , Instruction : string)
    local Name = CheckIfString(Instruction)

    assert(Name , `[{script.Name}] {Instruction} String Is not Valid.`)
    assert(Info.CACHE[Name] , `[{script.Name}] {Name} Is not Found In cache.`)
    return Name
end


function Excutor.Excute(Info)
    for StepNum , Instruction in Info.Instruction do
        local separated = string.split(Instruction , " ")

        local FunctionName , Value = nil , nil
        
        for _ , V in separated do
            if V ~= "" then
                if FunctionName == nil then
                    FunctionName = V
                    assert(script.Functions:FindFirstChild(FunctionName) , `[{script.Name}] Not valid function name`)
                else
                    if V:split("(")[1] == "READ" then
                        Value = ReadFromCache(Info , V)
                    else
                        if CheckIfNumberIsValid(V) then
                            Value = tonumber(V)
                        elseif script.SpecialValues:FindFirstChild(V) then
                            Value = require(script.SpecialValues:FindFirstChild(V))
                        elseif CheckIfString(V) then
                            assert(table.find(VALID_FUNCTION_THAT_CAN_TAKE_STRING , V) ,  `[{script.Name}] {FunctionName} Can not take a string as Value`)
                        else
                            error(`[{script.Name}] {V} is not a Valid Number or Special Value` , 1)
                        end
                    end
                end
            end
        end


        Info = require(script.Functions:FindFirstChild(FunctionName))(Info , Value)
    end
    return Info
end









return Excutor