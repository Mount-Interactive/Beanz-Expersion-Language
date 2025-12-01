local Types = require(game:GetService("ReplicatedStorage").Constances)
return function (Info , Value)
    Info.ActiveValue = Info.ActiveValue + Value
    return Info
end