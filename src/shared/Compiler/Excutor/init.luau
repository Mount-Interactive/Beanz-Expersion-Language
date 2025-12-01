local Excutor = {}
local Types = require(game:GetService("ReplicatedStorage").Constances)

local function CheckIfString(String:string)
    local Seperated1 = String:split("(")[2]
    if Seperated1 then
        local Seperated2 = Seperated1:split(")")[1]
        if Seperated2 then
            return Seperated2
        end
    end
    return nil
end


local function CheckIfNumberIsValid(Number : string)
    local ValidNumber = {
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "0",
    }

    for _ , V in Number:split("") do
        if not table.find(ValidNumber , V) then
            warn( `[{script.Name}] {Number} is not a Valid Number`)
            return false
        end
    end
    return true
end

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
                        else
                            error(`[{script.Name}] {V} is not a Valid Number or String` , 1)
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