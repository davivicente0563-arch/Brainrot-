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
	plataforma.Size = Vector3.new(4, 1, 4)
	plataforma.Position = root.Position - Vector3.new(0, 3, 0)
	plataforma.Anchored = true
	plataforma.CanCollide = true
	plataforma.Material = Enum.Material.Neon
	plataforma.BrickColor = BrickColor.new("Really red")
	plataforma.Parent = workspace

	local velocidade = 100
	local subida = 0

	local conexao
	conexao = RunService.Heartbeat:Connect(function(dt)
		subida += velocidade * dt
		plataforma.Position += Vector3.new(0, velocidade * dt, 0)
		if subida >= 100 then
			conexao:Disconnect()
			plataforma:Destroy()
		end
	end)
end

-- Função: Plataforma que vai pra frente
local function criarPlataformaFrontal()
	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local plataforma = Instance.new("Part")
	plataforma.Size = Vector3.new(4, 1, 4)
	plataforma.Position = root.Position - Vector3.new(0, 3, 0)
	plataforma.Anchored = true
	plataforma.CanCollide = true
	plataforma.Material = Enum.Material.Neon
	plataforma.BrickColor = BrickColor.new("Bright blue")
	plataforma.Parent = workspace

	local velocidade = 80
	local distancia = 0
	local direcao = root.CFrame.LookVector

	local conexao
	conexao = RunService.Heartbeat:Connect(function(dt)
		distancia += velocidade * dt
		plataforma.Position += direcao * velocidade * dt
		if distancia >= 100 then
			conexao:Disconnect()
			plataforma:Destroy()
		end
	end)
end

-- Criar interface de botões
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PlataformaGUI"

local function criarBotao(nome, posicao, cor, aoClicar)
	local botao = Instance.new("TextButton")
	botao.Size = UDim2.new(0, 120, 0, 50)
	botao.Position = posicao
	botao.BackgroundColor3 = cor
	botao.Text = nome
	botao.TextScaled = true
	botao.Parent = gui
	botao.MouseButton1Click:Connect(aoClicar)
end

-- Botão para subir
criarBotao("Subir", UDim2.new(0, 20, 1, -130), Color3.fromRGB(255, 0, 0), criarPlataformaVertical)

-- Botão para frente
criarBotao("Avançar", UDim2.new(0, 160, 1, -130), Color3.fromRGB(0, 170, 255), criarPlataformaFrontal)
