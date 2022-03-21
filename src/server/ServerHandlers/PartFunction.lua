local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")

local dataMod = require(script.Parent.Data);


local partFunctionMods = {}


-- Local Function
partFunctionMods.playerFromHit = function(basePartInstace)
    local model  = basePartInstace:FindFirstAncestorOfClass("Model");
    local player = playerService:GetPlayerFromCharacter(model);
    
    return player, model

end


-- Global Function
partFunctionMods.KillParts = function(part)

    part.Touched:Connect(function(hit)
        local player, model = partFunctionMods.playerFromHit(part);
        if player and model.Humanoid.Health > 0 then
            model.Humanoid.Health = 0
        end
    end)
end

partFunctionMods.DamageParts = function(part)
    local delay = false
    local damageValue = part.Damage.Value;

    part.Touched:Connect(function(hit)
        
        local player, charModel = partFunctionMods.playerFromHit(hit);
        if player and not delay then
            delay = true
            local Humanoid = charModel.Humanoid;
            Humanoid.Health  = Humanoid.Health - damageValue
            delay(0.1, function()
                delay = false
            end)

        end
    end)

end

return partFunctionMods