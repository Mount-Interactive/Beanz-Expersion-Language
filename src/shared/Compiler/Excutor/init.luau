local Excutor = {}
--local Types = require(game:GetService("ReplicatedStorage").Constances.Types.Compiler)
local Util  = require(script.Parent.Util)



local CheckIfString = Util.CheckIfString
local CheckIfNumberIsValid = Util.CheckIfNumberIsValid
local GetAndCheckString = Util.GetAndCheckString

local VALID_FUNCTIONS_THAT_CAN_TAKE_STRING = {
    "WRITE",
}




local function ReadFromCache(Info , Instruction : string)
    local Name = GetAndCheckString(Instruction)

    assert(Name , `[{script.Name}] {Instruction} String Is not Valid.`)
    assert(Info.CACHE[Name] , `[{script.Name}] {Name} Is not Found In cache.`)

    print(Info.CACHE[Name])

    return Info.CACHE[Name]
end


function Excutor.Excute(Info) : number
    print(Info)
    for _ , Instruction in Info.Instructions do
        local separated = string.split(Instruction , " ")

        local FunctionName , Value = nil , nil

        print(separated)
        for _ , V in separated do
            if V ~= "" then
                if FunctionName == nil then
                    FunctionName = V
                    assert(script.Functions:FindFirstChild(FunctionName) , `[{script.Name}] ({V}) is not valid function name`)
                else
                    if V:split("(")[1] == "READ" then
                        print(V)
                        Value = ReadFromCache(Info , V)
                    else
                        if CheckIfNumberIsValid(V) then
                            Value = V

                        elseif script.SpecialValues:FindFirstChild(V) then
                            Value = require(script.SpecialValues:FindFirstChild(V))

                        elseif CheckIfString(V) then
                            assert(table.find(VALID_FUNCTIONS_THAT_CAN_TAKE_STRING , FunctionName) ,  `[{script.Name}] ({FunctionName}) Can not take a string as Value`)
                            Value = GetAndCheckString(Instruction)
                        else
                            error(`[{script.Name}] {V} is not a Valid Number or Special Value` , 1)
                        end
                    end
                end
            end
        end

        print(Instruction , tonumber(Value))



        if tonumber(Value) then
            Info = require(script.Functions:FindFirstChild(FunctionName))(Info , tonumber(Value)) 
        else
            Info = require(script.Functions:FindFirstChild(FunctionName))(Info , Value) 
        end

        print(Info.ActiveValue)
    end
    return Info.ActiveValue
end




function Excutor.Test(Info , TestValue)
    if Excutor.Excute(Info) ~= TestValue then
        warn("Test Failed Amount Returned In correct.")
    end
end




return Excutor