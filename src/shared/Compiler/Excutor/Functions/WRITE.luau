local Types = require(game:GetService("ReplicatedStorage").Constances)
return function (Info:Types.CompilerExport , Value)
    Info.CACHE[Value] = Info.ActiveValue
    return Info
end