local Types = require(game:GetService("ReplicatedStorage").Constances.Types.Compiler)






return function(Code: string)
    local Seperated = Code:split(";")



    local Info = {}

    Info.CACHE = {}
    Info.Instructions = {}
    Info.ActiveValue = nil






    return Info
end