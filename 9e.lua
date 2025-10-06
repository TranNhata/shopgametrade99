-- Simple Script Hub with Auto Resize + Hotkey K (scaled 0.5)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local luatrai = CFrame.new(1.031, 2.776, 1.113) + Vector3.new(10, 10, 0)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Scale factor (0.5 = nhỏ 1 nửa)
local SCALE = 0.5
local function scaleSize(x, y) return UDim2.new(0, x * SCALE, 0, y * SCALE) end

-- Remove old GUI
if CoreGui:FindFirstChild("DeltaHub") then CoreGui.DeltaHub:Destroy() end

-- GUI setup (Frame chính KHÔNG thu nhỏ)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "DeltaHub"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 340, 0, 120)
Frame.Position = UDim2.new(0.5, -170, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true

-- Title bar
local TitleBar = Instance.new("Frame", Frame)
TitleBar.Size = scaleSize(340, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = scaleSize(100, 36)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ShopGameTrade"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 10 * SCALE * 2
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Di chuyển
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = Frame.Position
	end
end)
TitleBar.InputChanged:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local d = i.Position - dragStart
		Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
	end
end)
UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Button tạo tiện
local function createButton(name, color, offset)
	local btn = Instance.new("TextButton", TitleBar)
	btn.Size = scaleSize(70, 24)
	btn.Position = UDim2.new(1, offset * SCALE, 0, 6 * SCALE)
	btn.BackgroundColor3 = color
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 14 * SCALE * 2
	return btn
end

-- Tạo nút có căn phải chuẩn
local function createButton(name, color, order)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 70, 0, 24)
	btn.AnchorPoint = Vector2.new(1, 0)  -- Căn theo mép phải
	btn.Position = UDim2.new(1, -(10 + (order - 1) * 80), 0, 6)
	btn.BackgroundColor3 = color
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 14
	btn.Parent = TitleBar
	return btn
end

-- Tạo 3 nút theo thứ tự từ phải sang trái
local CloseBtn = createButton("Close", Color3.fromRGB(200,50,50), 1)
local MinBtn = createButton("Minimize", Color3.fromRGB(200,180,50), 2)
local MaxBtn = createButton("Maximize", Color3.fromRGB(60,150,255), 3)


-- Content
local Content = Instance.new("Frame", Frame)
Content.Size = UDim2.new(1, 0, 1, -36)
Content.Position = UDim2.new(0, 0, 0, 36)
Content.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 6 * SCALE)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- Scripts
local scripts = {
	{name = "Infinite Yield", url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
}

for _, s in ipairs(scripts) do
	local btn = Instance.new("TextButton", Content)
	btn.Size = scaleSize(300, 36)
	btn.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
	btn.Text = s.name
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16 * SCALE * 2
	btn.MouseButton1Click:Connect(function()
		pcall(function() loadstring(game:HttpGet(s.url))() end)
	end)
end

-- Custom Script
local customBtn = Instance.new("TextButton", Content)
customBtn.Size = scaleSize(300, 36)
customBtn.BackgroundColor3 = Color3.fromRGB(80,150,80)
customBtn.Text = "Custom Script"
customBtn.TextColor3 = Color3.fromRGB(255,255,255)
customBtn.Font = Enum.Font.SourceSansBold
customBtn.TextSize = 16 * SCALE * 2

-- Editor
local Editor = Instance.new("Frame", ScreenGui)
Editor.Size = scaleSize(420, 300)
Editor.Position = UDim2.new(0.5, -210 * SCALE, 0.5, -150 * SCALE)
Editor.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Editor.Visible = false
Editor.Active = true
Editor.Draggable = true

local TextBox = Instance.new("TextBox", Editor)
TextBox.Size = UDim2.new(1, -20 * SCALE, 1, -80 * SCALE)
TextBox.Position = UDim2.new(0, 10 * SCALE, 0, 36 * SCALE)
TextBox.BackgroundColor3 = Color3.fromRGB(15,15,15)
TextBox.TextColor3 = Color3.fromRGB(255,255,255)
TextBox.MultiLine = true
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 14 * SCALE * 2
TextBox.Text = "-- Paste script here"

local RunBtn = Instance.new("TextButton", Editor)
RunBtn.Size = scaleSize(100, 28)
RunBtn.Position = UDim2.new(0, 10 * SCALE, 1, -36 * SCALE)
RunBtn.BackgroundColor3 = Color3.fromRGB(50,150,50)
RunBtn.Text = "Run"
RunBtn.TextColor3 = Color3.fromRGB(255,255,255)
RunBtn.Font = Enum.Font.SourceSansBold
RunBtn.TextSize = 14 * SCALE * 2

local CloseEdBtn = Instance.new("TextButton", Editor)
CloseEdBtn.Size = scaleSize(100, 28)
CloseEdBtn.Position = UDim2.new(1, -110 * SCALE, 1, -36 * SCALE)
CloseEdBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
CloseEdBtn.Text = "Close"
CloseEdBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseEdBtn.Font = Enum.Font.SourceSansBold
CloseEdBtn.TextSize = 14 * SCALE * 2

customBtn.MouseButton1Click:Connect(function() Editor.Visible = true end)
CloseEdBtn.MouseButton1Click:Connect(function() Editor.Visible = false end)
RunBtn.MouseButton1Click:Connect(function()
	local code = TextBox.Text
	local func, err = loadstring(code)
	if func then pcall(func) else warn(err) end
end)

-- Auto resize
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local function updateSize()
	local h = UIList.AbsoluteContentSize.Y + 48 * SCALE
	local target = UDim2.new(0, 340, 0, h)
	TweenService:Create(Frame, tweenInfo, {Size = target}):Play()
end
UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
task.delay(0.1, updateSize)

-- Minimize / Maximize / Hotkey K
local minimized, maximized, savedSize, savedPos = false, false, Frame.Size, Frame.Position
local function minimize()
	if minimized then return end
	minimized = true
	savedSize, savedPos = Frame.Size, Frame.Position
	local currentPos = Frame.Position
	TweenService:Create(Frame, tweenInfo, {Size = UDim2.new(0, 200, 0, 36), Position = currentPos}):Play()
	task.delay(0.22, function() Content.Visible = false end)
end
local function restore()
	if not minimized then return end
	minimized = false
	Content.Visible = true
	TweenService:Create(Frame, tweenInfo, {Size = savedSize, Position = savedPos}):Play()
end
MinBtn.MouseButton1Click:Connect(function() if minimized then restore() else minimize() end end)
MaxBtn.MouseButton1Click:Connect(function()
	if not maximized then
		savedSize, savedPos = Frame.Size, Frame.Position
		TweenService:Create(Frame, tweenInfo, {Size = UDim2.new(1, -40, 1, -40), Position = UDim2.new(0, 20, 0, 20)}):Play()
		maximized = true
		MaxBtn.Text = "Restore"
	else
		TweenService:Create(Frame, tweenInfo, {Size = savedSize, Position = savedPos}):Play()
		maximized = false
		MaxBtn.Text = "Maximize"
	end
end)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.K then if minimized then restore() else minimize() end end
end)

-- Nút lửa trại
local customCollect = Instance.new("TextButton", Content)
customCollect.Size = scaleSize(300, 36)
customCollect.BackgroundColor3 = Color3.fromRGB(150,100,50)
customCollect.Text = "lửa trại"
customCollect.TextColor3 = Color3.fromRGB(255,255,255)
customCollect.Font = Enum.Font.SourceSansBold
customCollect.TextSize = 16 * SCALE * 2
customCollect.MouseButton1Click:Connect(function()
	hrp.CFrame = luatrai
end)
