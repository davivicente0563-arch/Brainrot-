-- Carregar OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Criar janela principal
local Window = OrionLib:MakeWindow({Name = "Vox Seas Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "VoxSeasConfig"})

-- Variáveis
local autoFarm = false
local autoBoss = false
local autoChest = false
local autoMoney = false
local attackDistance = false

-- Funções
function farmMobs()
    while autoFarm do
        for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
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
        for _, boss in pairs(game:GetService("Workspace").Bosses:GetChildren()) do
            if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                boss.Humanoid:TakeDamage(100)
            end
        end
        wait(2)
    end
end

function collectChests()
    while autoChest do
        for _, chest in pairs(game:GetService("Workspace").Chests:GetChildren()) do
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
        -- Simulação de coleta de dinheiro (ajuste conforme o jogo)
        game:GetService("ReplicatedStorage").Events.CollectMoney:FireServer()
        wait(5)
    end
end

-- Gui: Auto Farm
local Tab = Window:MakeTab({Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})

Tab:AddToggle({
    Name = "Auto Farm Mobs",
    Default = false,
    Callback = function(value)
        autoFarm = value
        farmMobs()
    end
})

Tab:AddToggle({
    Name = "Auto Farm Boss",
    Default = false,
    Callback = function(value)
        autoBoss = value
        farmBoss()
    end
})

Tab:AddToggle({
    Name = "Ataque à distância (melee)",
    Default = false,
    Callback = function(value)
        attackDistance = value
    end
})

-- Gui: Coleta e Dinheiro
local Tab2 = Window:MakeTab({Name = "Recursos", Icon = "rbxassetid://6031075938", PremiumOnly = false})

Tab2:AddToggle({
    Name = "Auto Chest",
    Default = false,
    Callback = function(value)
        autoChest = value
        collectChests()
    end
})

Tab2:AddToggle({
    Name = "Farm Dinheiro",
    Default = false,
    Callback = function(value)
        autoMoney = value
        farmMoney()
    end
})

-- Gui: Teleporte
local Tab3 = Window:MakeTab({Name = "Teleporte", Icon = "rbxassetid://6031071053", PremiumOnly = false})

local ilhas = {
    ["Ilha Inicial"] = Vector3.new(100, 10, 200),
    ["Ilha dos Piratas"] = Vector3.new(500, 20, -300),
    ["Ilha do Vulcão"] = Vector3.new(-800, 15, 600),
    ["Ilha da Marinha"] = Vector3.new(1200, 25, -1000)
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
