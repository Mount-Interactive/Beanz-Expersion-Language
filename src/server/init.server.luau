local Compiler = require(game:GetService("ReplicatedStorage").Shared.Compiler)

local INFO = Compiler.Compiler(require(game:GetService("ReplicatedStorage").Constances.IDK))
print(INFO)

Compiler.Excutor(INFO)