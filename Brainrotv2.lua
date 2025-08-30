local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Função genérica para criar plataforma
local function criarPlataforma(props)
	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local plataforma = Instance.new("Part")
	plataforma.Size = props.size or Vector3.new(6, 1, 6)
	plataforma.Position = root.Position + props.offset
	plataforma.Anchored = false
	plataforma.CanCollide = true
	plataforma.Material = Enum.Material.Neon
	plataforma.BrickColor = props.cor or BrickColor.new("White")
	plataforma.Name = "Plataforma"
	plataforma.Parent = workspace

	-- Coloca o jogador em cima
	root.CFrame = plataforma.CFrame + Vector3.new(0, 2.5, 0)

	-- Aplica movimento
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = props.velocidade
	bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bodyVelocity.Parent = plataforma

	task.delay(props.tempo or 2, function()
		bodyVelocity:Destroy()
		plataforma.Anchored = true
		task.delay(3, function()
			plataforma:Destroy()
		end)
	end)
end

-- Plataforma que sobe
local function ativarVertical()
	criarPlataforma({
		offset = Vector3.new(0, -3, 0),
		velocidade = Vector3.new(0, 40, 0),
		cor = BrickColor.new("Really red"),
	})
end

-- Plataforma direcional
local function ativarDirecional(direcao)
	local dirMap = {
		["Frente"] = player.Character.HumanoidRootPart.CFrame.LookVector,
		["Trás"] = -player.Character.HumanoidRootPart.CFrame.LookVector,
		["Direita"] = player.Character.HumanoidRootPart.CFrame.RightVector,
		["Esquerda"] = -player.Character.HumanoidRootPart.CFrame.RightVector,
	}

	local dir = dirMap[direcao] or Vector3.new(0, 0, 0)
	local impulso = dir * 60 + Vector3.new(0, 20, 0) -- sobe um pouco antes de ir

	criarPlataforma({
		offset = Vector3.new(0, -3, 0),
		velocidade = impulso,
		cor = BrickColor.new("Bright blue"),
	})
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

-- Botões
criarBotao("Subir", UDim2.new(0, 20, 1, -190), Color3.fromRGB(255, 0, 0), ativarVertical)
criarBotao("Frente", UDim2.new(0, 160, 1, -190), Color3.fromRGB(0, 170, 255), function() ativarDirecional("Frente") end)
criarBotao("Trás", UDim2.new(0, 160, 1, -130), Color3.fromRGB(0, 170, 255), function() ativarDirecional("Trás") end)
criarBotao("Direita", UDim2.new(0, 300, 1, -190), Color3.fromRGB(0, 170, 255), function() ativarDirecional("Direita") end)
criarBotao("Esquerda", UDim2.new(0, 300, 1, -130), Color3.fromRGB(0, 170, 255), function() ativarDirecional("Esquerda") end)
