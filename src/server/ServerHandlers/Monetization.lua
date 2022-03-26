local insertService = game:GetService("InsertService")
local marketplaceService = game:GetService("MarketplaceService")

local dataStoreService = game:GetService("DataStoreService")
local playerServices = game:GetService("Players")
local collectionService = game:GetService("CollectionService")
local defineModule = require(script.Parent.Define)
local dataModule = require(script.Parent.Data)
local monetizationDefine = require(script.Parent.MonetizationDefine)
local monetizationModule = {}


monetizationModule.insertTool = function(player, assestId)
    local assest = insertService:LoadAsset(assestId)
    local tool = assest:FindFirstChildOfClass(assest);

    tool.Parent = player.Backpack
    assest:Destroy()
    
end


monetizationModule[monetizationDefine.SpeedCoil.GamePassUrl] = function(player)
    
    monetizationModule.insertTool(player, monetizationDefine.SpeedCoil.Id)
end
monetizationModule[monetizationDefine.GravityCoil.GamePassUrl] = function(player)
    
    monetizationModule.insertTool(player, monetizationDefine.GravityCoil.Id)
end
monetizationModule[monetizationDefine.Radio.GamePassUrl] = function(player)
    
    monetizationModule.insertTool(player, monetizationDefine.Radio.Id)
end

monetizationModule[monetizationDefine.Coinsx100.GamePassUrl] = function(player)
    
    dataModule.increment(player, defineModule.CoinName, 100)
end



marketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, wasPurchased)
    if wasPurchased then
        collectionService:AddTag(player, gamePassId)
        monetizationModule[gamePassId](player)
    end
end)
return monetizationModule
