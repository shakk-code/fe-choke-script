--[[
  FE Choke Script
  By minishakk

  Click to choke npcs [FE].

  Don't redistribute without permission, or before contacting @minishakk on Discord.
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
repeat task.wait() until player and player:FindFirstChild("Backpack")
local mouse = player:GetMouse()

local tool = Instance.new("Tool")
tool.Name = "Firm Hand"
tool.CanBeDropped = false
tool.RequiresHandle = true

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1, 1, 1)
handle.Transparency = 1
handle.CanCollide = false
handle.Parent = tool

local pullSound = Instance.new("Sound")
pullSound.SoundId = "rbxassetid://86165035080520"
pullSound.Parent = handle

local crackSound = Instance.new("Sound")
crackSound.SoundId = "rbxassetid://107817785521562"
crackSound.Parent = handle

local chokeSound = Instance.new("Sound")
chokeSound.SoundId = "rbxassetid://18857324929"
chokeSound.Parent = handle

local startSound = Instance.new("Sound")
startSound.SoundId = "rbxassetid://6784421247"
startSound.Parent = handle

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "FE Choke",
	Text = "by minishakk. Kills NPCs",
	Icon = "rbxassetid://15465967388"
})

local equipped = false
local mousecon

local function bleed(position)
	local part = Instance.new("Part")
	part.Size = Vector3.new(1, 1, 1)
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = 1
	part.Position = position
	part.Parent = workspace

	local emitter = Instance.new("ParticleEmitter")
	emitter.Texture = "rbxassetid://8903193182"
	emitter.Rate = 100
	emitter.Lifetime = NumberRange.new(0.3, 0.5)
	emitter.Speed = NumberRange.new(5, 10)
	emitter.VelocitySpread = 180
	emitter.Color = ColorSequence.new(Color3.new(0.6, 0, 0))
	emitter.Parent = part

	emitter:Emit(30)

	game:GetService("Debris"):AddItem(part, 2)
end

local function choke(target)
	local character = target:FindFirstAncestorOfClass("Model")
	if character and character ~= player.Character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local head = character:FindFirstChild("Head")
		if humanoid and head then
			local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if rootPart then
				local npcCFrame = head.CFrame

				local leftOffset = -npcCFrame.RightVector * 1
				local backOffset = -npcCFrame.LookVector * 1

				local finalPosition = npcCFrame.Position + leftOffset + backOffset

				rootPart.CFrame = CFrame.new(finalPosition, finalPosition + npcCFrame.LookVector)

			end
			task.wait(4)
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			task.wait(0.2)
			humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		end
	end
end

tool.Equipped:Connect(function()
	equipped = true
	startSound:Play()
	mousecon = mouse.Button1Down:Connect(function()
		if equipped and mouse.Target then
			pullSound:Play()
			chokeSound:Play()
			choke(mouse.Target)
			crackSound:Play()
		end
	end)
end)

tool.Unequipped:Connect(function()
	equipped = false
	if mousecon then
		mousecon:Disconnect()
		mousecon = nil
	end
end)

tool.Parent = player.Backpack
