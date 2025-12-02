local Util = {}

function Util.CheckIfString(String:string)
    local Seperated1 = String:split("(")[2]
    if Seperated1 then
        local Seperated2 = Seperated1:split(")")[1]
        if Seperated2 then
            return true
        end
    end
    return nil
end


function Util.CheckIfNumberIsValid(Number : string)
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

function Util.GetAndCheckString(Instruction:string)
    local Seperated1 = Instruction:split("(")[2]
    if Seperated1 then
        local Seperated2 = Seperated1:split(")")[1]
        if Seperated2 then
            return Seperated2
        end
    end
    return nil
end


return Util