local replicatedStorage = game:GetService("ReplicatedStorage")

local effectsModule = {}

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


return effectsModule;