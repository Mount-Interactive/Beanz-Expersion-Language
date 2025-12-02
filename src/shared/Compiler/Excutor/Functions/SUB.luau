return function (Info , Value)
    Info.ActiveValue = Value - Info.ActiveValue
    return Info
end