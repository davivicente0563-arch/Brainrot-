local tool = script.Parent

tool.Activated:Connect(function()
	local character = tool.Parent
	local humanoidRoot = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRoot then return end

	-- Criar a plataforma
	local plataforma = Instance.new("Part")
	plataforma.Size = Vector3.new(8, 1, 8)
	plataforma.Position = humanoidRoot.Position - Vector3.new(0, 3, 0)
	plataforma.Anchored = false
	plataforma.CanCollide = true
	plataforma.Material = Enum.Material.Neon
	plataforma.BrickColor = BrickColor.new("Really red")
	plataforma.Name = "PlataformaBrainrot"
	plataforma.Parent = workspace

	-- Soldar o jogador na plataforma
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = plataforma
	weld.Part1 = humanoidRoot
	weld.Parent = plataforma

	-- Adicionar impulso vertical
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = Vector3.new(0, 100, 0)
	bodyVelocity.MaxForce = Vector3.new(0, 1e6, 0)
	bodyVelocity.Parent = plataforma

	-- Efeitos visuais (opcional)
	local glow = Instance.new("PointLight")
	glow.Color = Color3.new(1, 0, 0)
	glow.Range = 16
	glow.Brightness = 2
	glow.Parent = plataforma

	-- Cronômetro para remover impulso e plataforma
	task.delay(1.5, function()
		bodyVelocity:Destroy()
		plataforma.Anchored = true
		weld:Destroy()
		
		task.delay(2, function()
			plataforma:Destroy()
		end)
	end)
end)
