local Excutor = {}
local Types = require(game:GetService("ReplicatedStorage").Constances)
local Util  = require(script.Parent.Util)



local CheckIfString = Util.CheckIfString
local CheckIfNumberIsValid = Util.CheckIfNumberIsValid


local function ReadFromCache(Info : Types.CompilerExport , Instruction : string)
    local Name = CheckIfString(Instruction)

    assert(Name , `[{script.Name}] {Instruction} String Is not Valid.`)
    assert(Info.CACHE[Name] , `[{script.Name}] {Name} Is not Found In cache.`)
    return Name
end


function Excutor.Excute(Info: Types.CompilerExport)
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
                        if CheckIfNumberIsValid(V) or CheckIfString(V) then
                            Value = V
                        elseif script.SpecialValues:FindFirstChild(V) then
                            Value = require(script.SpecialValues:FindFirstChild(V))
                        else
                            error(`[{script.Name}] {V} is not a Valid Number, String or Special Value` , 1)
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