local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local badgeService = game:GetService("BadgeService")
local marketplaceService = game:GetService("MarketplaceService")
local dataMod = require(script.Parent.Data);
local defineModule = require(script.Parent.Define);

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

partFunctionMods.SpawnParts = function(part)
    local stage = part.Stage.Value

    part.Touched:Connect(function(hit)
        local player, model = partFunctionMods.playerFromHit(part);

        if player and dataMod.get(player, defineModule.StageName) == stage -1 then
            dataMod.set(player, defineModule.StageName, stage)
        end
        
    end)
end

-- Coin Related
local partIndex = 0
partFunctionMods.RewardParts = function(part)
    local reward = part.Reward.Value
    local code = partIndex
    partIndex = partIndex + 1

    part.Touched:Connect(function(hit)
        local player = partFunctionMods.playerFromHit(hit)
        if player then
            local tagFolder = player:FindFirstChild("CoinTags")
            if not tagFolder then
                tagFolder = Instance.new("Folder");
                tagFolder.Name = defineModule.FolderTags.Coin
                tagFolder.Parent = player
            end

            if not tagFolder:FindFirstChild(code) then
                dataMod.increment(player, defineModule.CoinName, reward)
                local codeTag = Instance.new("BoolValue")
                codeTag.Name = code
                codeTag.Parent = tagFolder
            end
        end
    end)
end

--Badge
partFunctionMods.BadgePart = function(part)
    local partId =part.BadgeId.Value
    part.Touched:Connect(function(hit)
        local player = partFunctionMods.playerFromHit(hit)

        if player then
            local key = player.UserId
            local hasBadge = badgeService:UserHasBadgeAsync(key, partId)
            
            if not hasBadge then
                badgeService:AwardBadge(key, partId)
            end
        end
    end)
end


-- Market

partFunctionMods.PurchaseParts = function(part)
    local promptId = part.PromptId.Value;
    local isProduct = part.isProduct.Value;

    part.Touched:Connect(function(hit)
        local player = partFunctionMods.playerFromHit(hit)
        if player then
            if isProduct  then
                marketplaceService:PromptProductPurchase(player, promptId);
            else
                marketplaceService:PromptGamePassPurchase(player, promptId);
            end
        end
    end)
end


--Attach script to part
local partGroups = {
	workspace.KillParts;
	workspace.DamageParts;
	workspace.SpawnParts;
	workspace.RewardParts;
	workspace.BadgeParts;
	workspace.PurchaseParts;
	--workspace.ShopParts;
}

for _, group in pairs(partGroups) do
	for _, part in pairs(group:GetChildren()) do
		if part:IsA("BasePart") then
			partFunctionMods[group.Name](part)
		end
	end
end


return partFunctionMods