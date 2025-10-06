repeat task.wait() until game:IsLoaded()

-- 🧩 Lấy player và nhân vật
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- 🧱 Tạo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "ShopGameTradeUI"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- 🪟 Khung chính
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 250, 0, 500)
main.Position = UDim2.new(0.02, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

-- 🏷️ Tiêu đề
local title = Instance.new("TextLabel")
title.Text = "🛠️ ShopGameTrade"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = main

-- 🧭 Tính năng kéo giao diện (drag)
local dragging, dragInput, dragStart, startPos
local UserInputService = game:GetService("UserInputService")

local function update(input)
	local delta = input.Position - dragStart
	main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

title.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		update(input)
	end
end)

-- ⚙️ Hàm tạo nút
local buttonY = 40
local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Text = name
	btn.Size = UDim2.new(1, -10, 0, 35)
	btn.Position = UDim2.new(0, 5, 0, buttonY)
	buttonY = buttonY + 40
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	btn.Parent = main
	btn.MouseButton1Click:Connect(callback)
end

-- 📍 Các vị trí teleport
local luatrai = CFrame.new(1.031, 2.776, 1.113) + Vector3.new(10, 10, 0)

-- 🧭 Nút 1
createButton("🧭 Dịch chuyển tới lửa trại", function()
	pcall(function()
		hrp.CFrame = luatrai
	end)
end)

-- 🌀 Infinite Yield
createButton("🌀 Infinite Yield", function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end)
end)

-- 💠 Dark Dex
createButton("💠 Dark Dex", function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"))()
	end)
end)

-- 🔍 Simple Spy
createButton("🔍 SimpleSpy", function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
	end)
end)

-- 🧩 Phím nóng thu nhỏ / mở lại (phím M)
local UserInputService = game:GetService("UserInputService")
local visible = true

UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.M then
		visible = not visible
		main.Visible = visible
	end
end)
