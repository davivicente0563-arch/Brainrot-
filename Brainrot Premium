-- Brainrot Supreme v3.0 - Painel Premium
-- Criado por davivicente0563-arch + Copilot

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

-- Proteção contra múltiplas execuções
if getgenv().BrainrotSupremeLoaded then
    StarterGui:SetCore("SendNotification", {
        Title = "Brainrot Supreme",
        Text = "Script já está rodando!",
        Duration = 5
    })
    return
end
getgenv().BrainrotSupremeLoaded = true

-- GUI Setup
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "BrainrotSupreme"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 400)
frame.Position = UDim2.new(0.5, -160, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🧠 Brainrot Supreme"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Botão criador
local function createButton(text, y, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(callback)
end

-- Base position
local basePosition = nil

-- Velocidade e pulo com reaplicação
local speedEnabled = false
local jumpEnabled = false

createButton("🏃 Velocidade/Pulo ON/OFF", 50, function()
    speedEnabled = not speedEnabled
    jumpEnabled = speedEnabled
end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if speedEnabled then
            char.Humanoid.WalkSpeed = 50
            char.Humanoid.JumpPower = 100
        else
            char.Humanoid.WalkSpeed = 16
            char.Humanoid.JumpPower = 50
        end
    end
end)

-- Invisibilidade
createButton("👻 Ficar Invisível", 90, function()
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 1
            end
        end
    end
end)

-- NoClip
local noclipEnabled = false
createButton("🚪 NoClip ON/OFF", 130, function()
    noclipEnabled = not noclipEnabled
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Salvar posição da base
createButton("📍 Salvar Base", 170, function()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        basePosition = root.Position
        StarterGui:SetCore("SendNotification", {
            Title = "Base Salva",
            Text = "Posição registrada com sucesso.",
            Duration = 4
        })
    end
end)

-- Teleportar para jogador
createButton("🧍 Teleportar para Jogador", 210, function()
    local targetName = ""
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            targetName = p.Name
            break
        end
    end
    local target = Players:FindFirstChild(targetName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

-- Teleportar de volta à base
createButton("🏠 Voltar à Base", 250, function()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root and basePosition then
        root.CFrame = CFrame.new(basePosition + Vector3.new(0, 3, 0))
    end
end)
