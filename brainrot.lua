local player = game.Players.LocalPlayer

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = 150
    humanoid.JumpPower = 100
end)

if player.Character then
    local humanoid = player.Character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = 150
    humanoid.JumpPower = 100
end
