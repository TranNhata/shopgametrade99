repeat task.wait() until game:IsLoaded()
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
--  Tạo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "ShopGameTradeUI"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui
--  Tạo khung chính
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 250, 0, 500)
main.Position = UDim2.new(0.01, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
--  Tiêu đề
local title = Instance.new("TextLabel")
title.Text = "🛠️ ShopGameTrade"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = main
--  Hàm tạo nút
local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Text = name
	btn.Size = UDim2.new(1, -10, 0, 35)
	btn.Position = UDim2.new(0, 5, 0, #main:GetChildren() * 40)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	btn.Parent = main
	btn.MouseButton1Click:Connect(callback)
end
--  Các vị trí Tele
local luatrai = CFrame.new(1.031, 2.776, 1.113) + Vector3.new(10, 10, 0)
local stronghold = CFrame.new(-80, -2.167, -640)
--  Nút 1: Dịch chuyển tới lửa trại
createButton(" Dịch chuyển tới lửa trại", function()
	pcall(function()
		hrp.CFrame = luatrai
	end)
end)
createButton("Infinite Yield", function()
	pcall(function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
	end)
end)
createButton(" Dịch chuyển tới lửa trại2", function()
	pcall(function()
		hrp.CFrame = luatrai
	end)
end)
createButton(" Dịch chuyển tới lửa trại3", function()
	pcall(function()
		hrp.CFrame = luatrai
	end)
end)

