-- Brainrot v4 - Ativação por tecla "F"
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local active = false

-- Efeito visual
local function spawnEffect()
	local part = Instance.new("Part")
	part.Size = Vector3.new(1, 1, 1)
	part.Shape = Enum.PartType.Ball
	part.Material = Enum.Material.Neon
	part.Color = Color3.fromRGB(255, 0, 255)
	part.Anchored = true
	part.CanCollide = false
	part.CFrame = root.CFrame * CFrame.new(0, 2, 0)
	part.Parent = workspace

	game:GetService("Debris"):AddItem(part, 1)

	local pulse = Instance.new("PointLight", part)
	pulse.Color = part.Color
	pulse.Range = 8
	pulse.Brightness = 5
end

-- Ativação
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F then
		active = not active
		if active then
			hum.WalkSpeed = 50
			hum.JumpPower = 100
			spawnEffect()
		else
			hum.WalkSpeed = 16
			hum.JumpPower = 50
		end
	end
end)
