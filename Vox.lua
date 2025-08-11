-- Carregar OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "🔥 Vox Seas Premium Plus 🔥", HidePremium = false, SaveConfig = true, ConfigFolder = "VoxSeasPro"})

-- Variáveis
local autoFarm = false
local autoBoss = false
local autoChest = false
local autoMoney = false
local attackDistance = false
local antiAFK = true

-- Anti-AFK
if antiAFK then
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        virtualUser = game:GetService("VirtualUser")
        virtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        virtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

-- Funções
function farmMobs()
    while autoFarm do
        for _, mob in pairs(workspace:WaitForChild("Enemies"):GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                hrp.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                if attackDistance then
                    mob.Humanoid:TakeDamage(50)
                else
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                end
            end
        end
        wait(1)
    end
end

function farmBoss()
    while autoBoss do
        for _, boss in pairs(workspace:WaitForChild("Bosses"):GetChildren()) do
            if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                hrp.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                boss.Humanoid:TakeDamage(100)
            end
        end
        wait(2)
    end
end

function collectChests()
    while autoChest do
        for _, chest in pairs(workspace:WaitForChild("Chests"):GetChildren()) do
            if chest:IsA("Model") and chest:FindFirstChild("TouchInterest") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame
                wait(0.5)
            end
        end
        wait(3)
    end
end

function farmMoney()
    while autoMoney do
        local event = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild("CollectMoney")
        if event then
            event:FireServer()
        end
        wait(5)
    end
end

-- Gui: Auto Farm
local Tab = Window:MakeTab({Name = "⚔️ Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})

Tab:AddToggle({
    Name = "Auto Farm Mobs",
    Default = false,
    Callback = function(v)
        autoFarm = v
        farmMobs()
    end
})

Tab:AddToggle({
    Name = "Auto Farm Boss",
    Default = false,
    Callback = function(v)
        autoBoss = v
        farmBoss()
    end
})

Tab:AddToggle({
    Name = "Ataque à distância (melee)",
    Default = false,
    Callback = function(v)
        attackDistance = v
    end
})

-- Gui: Recursos
local Tab2 = Window:MakeTab({Name = "💰 Recursos", Icon = "rbxassetid://6031075938", PremiumOnly = false})

Tab2:AddToggle({
    Name = "Auto Chest",
    Default = false,
    Callback = function(v)
        autoChest = v
        collectChests()
    end
})

Tab2:AddToggle({
    Name = "Farm Dinheiro",
    Default = false,
    Callback = function(v)
        autoMoney = v
        farmMoney()
    end
})

-- Gui: Teleporte
local Tab3 = Window:MakeTab({Name = "🗺️ Teleporte", Icon = "rbxassetid://6031071053", PremiumOnly = false})

local ilhas = {
    ["Spawn"] = Vector3.new(100, 10, 200),
    ["Pirate Island"] = Vector3.new(500, 20, -300),
    ["Volcano Island"] = Vector3.new(-800, 15, 600),
    ["Marine Base"] = Vector3.new(1200, 25, -1000),
    ["Secret Cave"] = Vector3.new(-1500, 5, 300)
}

for nome, pos in pairs(ilhas) do
    Tab3:AddButton({
        Name = nome,
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        end
    })
end

-- Finalizar
OrionLib:Init()
