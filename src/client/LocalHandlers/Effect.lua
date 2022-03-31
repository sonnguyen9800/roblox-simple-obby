local replicatedStorage = game:GetService("ReplicatedStorage")

local effectsModule = {}

--Local
local function playSound(part)
    local sound = part:FindFirstChildOfClass("Sound");

    if sound then
        sound.Play()
    end
    return sound;
end


local function emitParticles(part, amount)
    local emitter = part:FindFirstChildOfClass("ParticleEmitter");

    if emitter then
        emitter.Emit(amount)
    end
    return emitter
end
--Replicated Storage: Remote Event - Effect
replicatedStorage.Effect.OnClientEvent:Connect(function(part)
    local folder = part.Parent.Name
    effectsModule[folder](part)
end)



effectsModule.RewardParts = function(part)
    part.Transparency = 1;
    playSound(part);
end

effectsModule.SpawnParts = function(part)
    playSound(part);
    emitParticles(part, 100)
    part.Material = Enum.Material.Neon

    task.delay(1, function()
        part.Material = Enum.Material.Plastic
    end)
    
end

return effectsModule;