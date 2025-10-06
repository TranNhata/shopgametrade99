-- Simple Script Hub with Auto Resize + Hotkey K
-- Made for Roblox (Delta, Fluxus, etc.)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Remove old GUI if re-executed
if CoreGui:FindFirstChild("DeltaHub") then
	CoreGui.DeltaHub:Destroy()
end

-- GUI setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaHub"
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 340, 0, 120)
Frame.Position = UDim2.new(0.5, -170, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Parent = ScreenGui

-- Title bar để kéo UI
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

-- Tên hub
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -240, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Delta Script Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Di chuyển hub bằng TitleBar
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
	end
end)

TitleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Buttons
local function createButton(name, color, posX)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 70, 0, 24)
	btn.Position = UDim2.new(1, posX, 0, 6)
	btn.BackgroundColor3 = color
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 14
	btn.Parent = TitleBar
	return btn
end

local MaxBtn = createButton("Maximize", Color3.fromRGB(60,150,255), -230)
local MinBtn = createButton("Minimize", Color3.fromRGB(200,180,50), -150)
local CloseBtn = createButton("Close", Color3.fromRGB(200,50,50), -70)

-- Content area
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -36)
Content.Position = UDim2.new(0, 0, 0, 36)
Content.BackgroundTransparency = 1
Content.Parent = Frame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 6)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Parent = Content

-- Add script buttons
local scripts = {
	{name = "Infinite Yield", url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
	{name = "Dark Dex", url = "https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"},
	{name = "SimpleSpy", url = "https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"}
}

for _, scriptData in ipairs(scripts) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 300, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
	btn.Text = scriptData.name
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.Parent = Content

	btn.MouseButton1Click:Connect(function()
		local ok, err = pcall(function()
			loadstring(game:HttpGet(scriptData.url))()
		end)
		if not ok then warn(err) end
	end)
end

-- Custom script editor
local customBtn = Instance.new("TextButton")
customBtn.Size = UDim2.new(0, 300, 0, 36)
customBtn.BackgroundColor3 = Color3.fromRGB(80, 150, 80)
customBtn.Text = "Custom Script"
customBtn.TextColor3 = Color3.fromRGB(255,255,255)
customBtn.Font = Enum.Font.SourceSansBold
customBtn.TextSize = 16
customBtn.Parent = Content

-- Editor
local Editor = Instance.new("Frame")
Editor.Size = UDim2.new(0, 420, 0, 300)
Editor.Position = UDim2.new(0.5, -210, 0.5, -150)
Editor.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Editor.Visible = false
Editor.Active = true
Editor.Draggable = true
Editor.Parent = ScreenGui

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 1, -80)
TextBox.Position = UDim2.new(0, 10, 0, 36)
TextBox.BackgroundColor3 = Color3.fromRGB(15,15,15)
TextBox.TextColor3 = Color3.fromRGB(255,255,255)
TextBox.MultiLine = true
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 14
TextBox.Text = "-- Paste script here"
TextBox.Parent = Editor

local RunBtn = Instance.new("TextButton")
RunBtn.Size = UDim2.new(0, 100, 0, 28)
RunBtn.Position = UDim2.new(0, 10, 1, -36)
RunBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
RunBtn.Text = "Run"
RunBtn.TextColor3 = Color3.fromRGB(255,255,255)
RunBtn.Font = Enum.Font.SourceSansBold
RunBtn.TextSize = 14
RunBtn.Parent = Editor

local CloseEdBtn = Instance.new("TextButton")
CloseEdBtn.Size = UDim2.new(0, 100, 0, 28)
CloseEdBtn.Position = UDim2.new(1, -110, 1, -36)
CloseEdBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
CloseEdBtn.Text = "Close"
CloseEdBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseEdBtn.Font = Enum.Font.SourceSansBold
CloseEdBtn.TextSize = 14
CloseEdBtn.Parent = Editor

customBtn.MouseButton1Click:Connect(function()
	Editor.Visible = true
end)

RunBtn.MouseButton1Click:Connect(function()
	local code = TextBox.Text
	local func, err = loadstring(code)
	if func then
		pcall(func)
	else
		warn("Syntax error:", err)
	end
end)

CloseEdBtn.MouseButton1Click:Connect(function()
	Editor.Visible = false
end)

-- Close hub
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Auto resize logic
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function updateSize()
	local contentHeight = UIList.AbsoluteContentSize.Y + 48
	local targetSize = UDim2.new(0, 340, 0, contentHeight)
	TweenService:Create(Frame, tweenInfo, {Size = targetSize}):Play()
end

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
task.delay(0.1, updateSize)

-- Minimize / Maximize / Hotkey K
local minimized = false
local maximized = false
local savedSize, savedPos = Frame.Size, Frame.Position

local function minimize()
	if minimized then return end
	minimized = true
	savedSize = Frame.Size
	savedPos = Frame.Position
	TweenService:Create(Frame, tweenInfo, {
		Size = UDim2.new(0, 200, 0, 36),
		Position = UDim2.new(0.5, -100, 0.5, -18)
	}):Play()
	Content.Visible = false
end

local function restore()
	if not minimized then return end
	minimized = false
	Content.Visible = true
	TweenService:Create(Frame, tweenInfo, {
		Size = savedSize,
		Position = savedPos
	}):Play()
end

MinBtn.MouseButton1Click:Connect(function()
	if minimized then restore() else minimize() end
end)

MaxBtn.MouseButton1Click:Connect(function()
	if not maximized then
		savedSize, savedPos = Frame.Size, Frame.Position
		TweenService:Create(Frame, tweenInfo, {
			Size = UDim2.new(1, -40, 1, -40),
			Position = UDim2.new(0, 20, 0, 20)
		}):Play()
		maximized = true
		MaxBtn.Text = "Restore"
	else
		TweenService:Create(Frame, tweenInfo, {
			Size = savedSize,
			Position = savedPos
		}):Play()
		maximized = false
		MaxBtn.Text = "Maximize"
	end
end)

-- Hotkey K
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.K then
		if minimized then
			restore()
		else
			minimize()
		end
	end
end)
