print("SCRIPT START")

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local remote = game.ReplicatedStorage:FindFirstChild("HitNPC")

if not remote then
	warn("Không tìm thấy HitNPC Remote")
	return
end

-- GUI chuẩn
local gui = Instance.new("ScreenGui")
gui.Name = "NghiaDzaiiHub"
gui.Parent = lp:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- MAIN
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 260, 0, 220)
main.Position = UDim2.new(0.05, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
main.Active = true
main.Draggable = true
main.Visible = true

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "NghiaDzaiiHub\nHitBox NPC"
title.TextScaled = true

-- MENU BUTTON
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = gui
toggleBtn.Size = UDim2.new(0, 120, 0, 40)
toggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
toggleBtn.Text = "MENU: ON"

toggleBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
	toggleBtn.Text = main.Visible and "MENU: ON" or "MENU: OFF"
end)

-- HIT BUTTON
local hitBtn = Instance.new("TextButton")
hitBtn.Parent = main
hitBtn.Size = UDim2.new(0.9, 0, 0, 60)
hitBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
hitBtn.Text = "HITBOX: OFF"

local range = 10
local running = false

local function attack()
	local char = lp.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	for _, npc in pairs(workspace:GetChildren()) do
		if npc:IsA("Model") and npc ~= char and npc:FindFirstChild("Humanoid") then
			local npcRoot = npc:FindFirstChild("HumanoidRootPart")
			if npcRoot then
				local dist = (npcRoot.Position - root.Position).Magnitude
				if dist <= range then
					remote:FireServer(npc, 10)
				end
			end
		end
	end
end

hitBtn.MouseButton1Click:Connect(function()
	running = not running

	if running then
		hitBtn.Text = "HITBOX: ON"
		task.spawn(function()
			while running do
				attack()
				task.wait(0.2)
			end
		end)
	else
		hitBtn.Text = "HITBOX: OFF"
	end
end)
