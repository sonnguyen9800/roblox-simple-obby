local serverScriptService = game:GetService("ServerScriptService")
local defineModule = require(game.ServerScriptService.Server.ServerHandlers.Define)


local playersService = game:GetService("Players")


local currentPlayer = playersService.LocalPlayer
local char = currentPlayer.Character or currentPlayer.CharacterAdded:Wait()

local tool = script.Parent
local mouse = currentPlayer:GetMouse()

local equipped
local clicked = false
local jump_power = defineModule.Items.SpringPotion.JumpPower


tool.Equipped:Connect(function()
    equipped = true
end)

tool.Unequipped:Connect(function()
    equipped = false
end)

mouse.Button1Down:Connect(function()
    if equipped and not clicked then
        clicked = true
        char.Humanoid.JumpPower = jump_power

        task.wait(defineModule.Items.SpringPotion.EffectDuration)
        char.Humanoid.Jump = defineModule.PlayerCharacter.DefaultJumpPower
        tool:Destroy()
    end
end)