-- Brainrot Supreme - Versão Ultra
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "BrainrotUI"

local function createButton(text, yPos, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 220, 0, 40)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Text = text
    button.Parent = ScreenGui
    button.MouseButton1Click:Connect(callback)
end

-- 🚪 NoClip
local noclipEnabled = false
createButton("🚪 NoClip ON/OFF", 50, function()
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

-- 🦘 Pulo Infinito
local infiniteJumpEnabled = false
createButton("🦘 Pulo Infinito ON/OFF", 100, function()
    infiniteJumpEnabled = not infiniteJumpEnabled
end)

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- 🛡️ Imunidade a Dano
createButton("🛡️ Ativar Imunidade", 150, function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local humanoid = char.Humanoid
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        humanoid.Health = math.huge
        humanoid.MaxHealth = math.huge
        humanoid.Name = "ProtectedHumanoid"
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name:lower():find("hit") then
                part:Destroy()
            end
        end
    end
end)

-- 🕵️ Invisibilidade Total
local invisible = false
createButton("🕵️ Invisibilidade ON/OFF", 200, function()
    invisible = not invisible
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = invisible and 1 or 0
            elseif part:IsA("Accessory") or part:IsA("Clothing") then
                part:Destroy()
            end
        end
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.NameDisplayDistance = invisible and 0 or 100
            char.Humanoid.DisplayName = invisible and "" or LocalPlayer.DisplayName
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if invisible then
        wait(1)
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 1
            elseif part:IsA("Accessory") or part:IsA("Clothing") then
                part:Destroy()
            end
        end
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.NameDisplayDistance = 0
            char.Humanoid.DisplayName = ""
        end
    end
end)

-- ⚡ Super Velocidade
local speedEnabled = false
local speedValue = 100
createButton("⚡ Velocidade ON/OFF", 250, function()
    speedEnabled = not speedEnabled
end)

RunService.RenderStepped:Connect(function()
    if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * speedValue
    end
end)

-- 🦅 Super Pulo
local jumpBoostEnabled = false
local jumpPower = 100
createButton("🦅 Super Pulo ON/OFF", 300, function()
    jumpBoostEnabled = not jumpBoostEnabled
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = jumpBoostEnabled and jumpPower or 50
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if jumpBoostEnabled and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = jumpPower
    end
end)

-- 💬 Mensagem de carregamento
print("✅ Brainrot Supreme Ultra carregado com todas as funções!")
