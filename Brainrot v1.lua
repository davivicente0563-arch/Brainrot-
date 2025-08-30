local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Função: Plataforma que sobe
local function criarPlataformaVertical()
	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local plataforma = Instance.new("Part")
	plataforma.Size = Vector3.new(6, 1, 6) -- maior
	plataforma.Position = root.Position - Vector3.new(0, 3, 0)
	plataforma.Anchored = false
	plataforma.CanCollide = true
	plataforma.Material = Enum.Material.Neon
	plataforma.BrickColor = BrickColor.new("Really red")
	plataforma.Name = "PlataformaVertical"
	plataforma.Parent = workspace

	-- Colocar o jogador em cima
	root.CFrame = plataforma.CFrame + Vector3.new(0, 2.5, 0)

	-- Subir suavemente
	local velocidade = 40
	local tempo = 2
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = Vector3.new(0, velocidade, 0)
	bodyVelocity.MaxForce = Vector3.new(0, 1e5, 0)
	bodyVelocity.Parent = plataforma

	task.delay(tempo, function()
		bodyVelocity:Destroy()
		plataforma.Anchored = true
		task.delay(3, function()
			plataforma:Destroy()
		end)
	end)
end

-- Função: Plataforma que vai pra frente
local function criarPlataformaFrontal()
	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local plataforma = Instance.new("Part")
	plataforma.Size = Vector3.new(6, 1, 6)
	plataforma.Position = root.Position - Vector3.new(0, 3, 0)
	plataforma.Anchored = false
	plataforma.CanCollide = true
	plataforma.Material = Enum.Material.Neon
	plataforma.BrickColor = BrickColor.new("Bright blue")
	plataforma.Name = "PlataformaFrontal"
	plataforma.Parent = workspace

	-- Colocar o jogador em cima
	root.CFrame = plataforma.CFrame + Vector3.new(0, 2.5, 0)

	-- Mover para frente
	local direcao = root.CFrame.LookVector
	local velocidade = 60
	local tempo = 2
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = direcao * velocidade
	bodyVelocity.MaxForce = Vector3.new(1e5, 0, 1e5)
	bodyVelocity.Parent = plataforma

	task.delay(tempo, function()
		bodyVelocity:Destroy()
		plataforma.Anchored = true
		task.delay(3, function()
			plataforma:Destroy()
		end)
	end)
end

-- Interface de botões
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PlataformaGUI"
gui.ResetOnSpawn = false

local function criarBotao(nome, posicao, cor, aoClicar)
	local botao = Instance.new("TextButton")
	botao.Size = UDim2.new(0, 120, 0, 50)
	botao.Position = posicao
	botao.BackgroundColor3 = cor
	botao.Text = nome
	botao.TextScaled = true
	botao.Font = Enum.Font.SourceSansBold
	botao.TextColor3 = Color3.new(1, 1, 1)
	botao.Parent = gui
	botao.MouseButton1Click:Connect(aoClicar)
end

criarBotao("Subir", UDim2.new(0, 20, 1, -130), Color3.fromRGB(255, 0, 0), criarPlataformaVertical)
criarBotao("Avançar", UDim2.new(0, 160, 1, -130), Color3.fromRGB(0, 170, 255), criarPlataformaFrontal)
