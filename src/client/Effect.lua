local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local effectsModule = {}

--Local
local function playSound(part)
    local sound = part:FindFirstChildOfClass("Sound");

    if sound then
        sound:Play()
    end
    return sound;
end


local function emitParticles(part, amount)
    local emitter = part:FindFirstChildOfClass("ParticleEmitter");

    if emitter then
        emitter:Emit(amount)
    end
    return emitter
end
--Replicated Storage: Remote Event - Effect
replicatedStorage.Common.Events.Effect.OnClientEvent:Connect(function(part)
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


-- Rotation Modules

local rotParts = {}

local partGroups = {
	workspace.KillParts;
	workspace.DamageParts;
	workspace.SpawnParts;
	workspace.RewardParts;
	workspace.BadgeParts;
	--workspace.PurchaseParts;
	--workspace.ShopParts;
}

for _, group in pairs(partGroups) do
	for _, part in pairs(group:GetChildren()) do
		if part:IsA("BasePart") then
			if part:FindFirstChild("Rotate") then
				table.insert(rotParts, part)
			end
		end
	end
end

runService.RenderStepped:Connect(function(dt)
	for _, part in pairs(rotParts) do
		local rot = part.Rotate.Value
		rot = rot * dt
		rot = rot * ((2 * math.pi) / 360)
		rot = CFrame.Angles(rot.X, rot.Y, rot.Z)
		
		part.CFrame = part.CFrame * rot
	end
end)


return effectsModule;