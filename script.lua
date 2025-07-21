--[[
  FE Gun Script
  By minishakk

  Click to kill npcs [FE].

  Don't redistribute without permission, or before contacting @minishakk on Discord.
]]

local Players = game:GetService("Players")

local player = Players.LocalPlayer
repeat task.wait() until player and player:FindFirstChild("Backpack")
local mouse = player:GetMouse()

local tool = Instance.new("Tool")
tool.Name = "FE Gun"
tool.CanBeDropped = false
tool.RequiresHandle = true

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1, 1, 1)
handle.Transparency = 1
handle.CanCollide = false
handle.Parent = tool

local shootSound = Instance.new("Sound")
shootSound.SoundId = "rbxassetid://801217802"
shootSound.Parent = handle

local reloadSound = Instance.new("Sound")
reloadSound.SoundId = "rbxassetid://8145744063"
reloadSound.Parent = handle

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "FE Gun",
    Text = "Click to shoot NPCs!",
    Icon = "rbxassetid://5381454270"
})

local equipped = false

local function killCharacter(target)
    local character = target:FindFirstAncestorOfClass("Model")
    if character and character ~= player.Character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Dead)
        end
    end
end

tool.Equipped:Connect(function()
    equipped = true
    reloadSound:Play()
end)

tool.Unequipped:Connect(function()
    equipped = false
end)

mouse.Button1Down:Connect(function()
    if equipped and mouse.Target then
        shootSound:Play()
        killCharacter(mouse.Target)
    end
end)

tool.Parent = player.Backpack
