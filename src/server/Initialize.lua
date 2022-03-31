local playersServices = game:GetService("Players")
local dataMod = require(script.Parent.Data)
local defineModule = require(script.Parent.Define)
local spawnParts = workspace.SpawnParts

local inititalizeModule = {}


local function getStage(stageNum)
    if spawnParts == nil then
        return nil
    end

    for _, stagePart in pairs(spawnParts:GetChildren()) do
        if not stagePart.Stage then
            return nil
        end
        
        if stagePart.Stage.Value == stageNum then
            return stagePart
        end
    end
    
end

playersServices.PlayerAdded:Connect(function(player)
    
    player.CharacterAdded:Connect(function(char)
        
        local stageNum = dataMod.get(player, defineModule.StageName);
        local spawnPoint = getStage(stageNum);
        if spawnPoint then
            char:SetPrimaryPartCFrame(spawnPoint.CFrame * CFrame.new(0,3,0));
        end
    end)
end)



return inititalizeModule

