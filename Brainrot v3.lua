local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Função: Ascensão Brainrot
local function ativarAscensao()
	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	-- Criar plataforma
	local plataforma = Instance.new("Part")
	plataforma.Size = Vector3.new(8, 1, 8)
	plataforma.Position = root.Position - Vector3.new(0, 3, 0)
	plataforma.Anchored = false
	plataforma.CanCollide = true
	plataforma.Material = Enum.Material.Neon
	plataforma.BrickColor = BrickColor.new("Really red")
	plataforma.Name = "AscensaoBrainrot"
	plataforma.Parent = workspace

	-- Efeito de luz
	local luz = Instance.new("PointLight")
	luz.Color = Color3.fromRGB(255, 0, 0)
	luz.Range = 15
	luz.Brightness = 3
	luz.Parent = plataforma

	-- Posicionar jogador em cima
	root.CFrame = plataforma.CFrame + Vector3.new(0, 3, 0)

	-- Impulso vertical
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = Vector3.new(0, 80, 0)
	bodyVelocity.MaxForce = Vector3.new(0, 1e5, 0)
	bodyVelocity.Parent = plataforma

	-- Efeito de explosão após subida
	task.delay(1.5, function()
		bodyVelocity:Destroy()
		plataforma.Anchored = true

		local explosao = Instance.new("Explosion")
		explosao.Position = plataforma.Position
		explosao.BlastRadius = 0 -- visual apenas
		explosao.BlastPressure = 0
		explosao.ExplosionType = Enum.ExplosionType.NoCraters
		explosao.Parent = workspace

		task.delay(0.5, function()
			plataforma:Destroy()
		end)
	end)
end

-- Interface de botão
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AscensaoGUI"
gui.ResetOnSpawn = false

local botao = Instance.new("TextButton")
botao.Size = UDim2.new(0, 140, 0, 50)
botao.Position = UDim2.new(0, 20, 1, -130)
botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
botao.Text = "Ascender"
botao.TextScaled = true
botao.Font = Enum.Font.SourceSansBold
botao.TextColor3 = Color3.new(1, 1, 1)
botao.Parent = gui
botao.MouseButton1Click:Connect(ativarAscensao)
