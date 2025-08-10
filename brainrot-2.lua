local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Criar GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "BrainrotPanel"

local function createButton(text, posY)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 40)
    button.Position = UDim2.new(0, 10, 0, posY)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = screenGui
    return button
end

-- Botão de velocidade e pulo
local speedActive = false
local speedButton = createButton("Ativar Velocidade/Pulo", 50)
speedButton.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    if speedActive then
        humanoid.WalkSpeed = 150
        humanoid.JumpPower = 100
        speedButton.Text = "Desativar Velocidade/Pulo"
    else
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        speedButton.Text = "Ativar Velocidade/Pulo"
    end
end)

-- Botão de invisibilidade
local invisButton = createButton("Ficar Invisível", 100)
invisButton.MouseButton1Click:Connect(function()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = 1
        end
    end
end)

-- Botão de atravessar parede (noclip)
local noclipActive = false
local noclipButton = createButton("Ativar NoClip", 150)
noclipButton.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    noclipButton.Text = noclipActive and "Desativar NoClip" or "Ativar NoClip"
end)

-- Loop de noclip
game:GetService("RunService").Stepped:Connect(function()
    if noclipActive and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)
