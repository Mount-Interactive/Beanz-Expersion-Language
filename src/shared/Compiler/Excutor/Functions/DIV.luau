return function (Info , Value)
    print("SUB TEST VALUE:" , Value , " ACTIVE:", Info.ActiveValue , " RESULT:" ,  (Info.ActiveValue / Value))
    Info.ActiveValue = (Info.ActiveValue / Value)
    return Info
end