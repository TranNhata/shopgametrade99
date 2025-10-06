-- Dynamic Script Hub (auto-resize by buttons + hotkey K to minimize/restore)
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- cleanup
if CoreGui:FindFirstChild("SimpleHubGui") then
    CoreGui.SimpleHubGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleHubGui"
ScreenGui.Parent = CoreGui

-- MAIN FRAME
local Frame = Instance.new("Frame")
Frame.Name = "HubFrame"
Frame.Size = UDim2.new(0, 340, 0, 120) -- initial small height; will auto expand
Frame.Position = UDim2.new(0.5, -170, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -240, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "My Script Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- TITLE BUTTONS
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 50, 0, 24)
CloseButton.Position = UDim2.new(1, -60, 0, 6)
CloseButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
CloseButton.Text = "Close"
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 70, 0, 24)
MinimizeButton.Position = UDim2.new(1, -140, 0, 6)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(200,180,50)
MinimizeButton.Text = "Minimize"
MinimizeButton.TextColor3 = Color3.fromRGB(255,255,255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 14
MinimizeButton.Parent = TitleBar

local MaximizeButton = Instance.new("TextButton")
MaximizeButton.Size = UDim2.new(0, 80, 0, 24)
MaximizeButton.Position = UDim2.new(1, -230, 0, 6)
MaximizeButton.BackgroundColor3 = Color3.fromRGB(80, 160, 220)
MaximizeButton.Text = "Maximize"
MaximizeButton.TextColor3 = Color3.fromRGB(255,255,255)
MaximizeButton.Font = Enum.Font.SourceSansBold
MaximizeButton.TextSize = 14
MaximizeButton.Parent = TitleBar

-- CONTENT AREA (holds buttons)
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -36)
Content.Position = UDim2.new(0, 0, 0, 36)
Content.BackgroundTransparency = 1
Content.Parent = Frame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 6)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Parent = Content

-- Keep spacing at top
local spacer = Instance.new("Frame")
spacer.Size = UDim2.new(1, 0, 0, 6)
spacer.BackgroundTransparency = 1
spacer.LayoutOrder = 0
spacer.Parent = Content

-- example scripts (you can add/remove entries)
local scripts = {
    {name = "Infinite Yield", url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {name = "Dark Dex", url = "https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"},
    {name = "SimpleSpy", url = "https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"},
}

-- helper to create script button
local function createScriptButton(data)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 300, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
    btn.Text = data.name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = Content
    btn.LayoutOrder = #Content:GetChildren() + 1

    btn.MouseButton1Click:Connect(function()
        local ok, res = pcall(function() return loadstring(game:HttpGet(data.url))() end)
        if not ok then warn("Failed to load script:", res) end
    end)
end

-- create initial buttons
for _, v in ipairs(scripts) do
    createScriptButton(v)
end

-- Custom Script button (opens Editor)
local CustomButton = Instance.new("TextButton")
CustomButton.Size = UDim2.new(0, 300, 0, 36)
CustomButton.BackgroundColor3 = Color3.fromRGB(80, 150, 80)
CustomButton.Text = "Custom Script"
CustomButton.TextColor3 = Color3.fromRGB(255,255,255)
CustomButton.Font = Enum.Font.SourceSansBold
CustomButton.TextSize = 16
CustomButton.Parent = Content
CustomButton.LayoutOrder = #Content:GetChildren() + 1

-- EDITOR (separate frame)
local Editor = Instance.new("Frame")
Editor.Name = "Editor"
Editor.Size = UDim2.new(0, 420, 0, 300)
Editor.Position = UDim2.new(0.5, -210, 0.5, -150)
Editor.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Editor.Visible = false
Editor.Parent = ScreenGui
Editor.Active = true
Editor.Draggable = true

local EditorTitle = Instance.new("TextLabel")
EditorTitle.Size = UDim2.new(1, 0, 0, 28)
EditorTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
EditorTitle.Text = "Custom Script Editor"
EditorTitle.TextColor3 = Color3.fromRGB(255,255,255)
EditorTitle.Font = Enum.Font.SourceSansBold
EditorTitle.TextSize = 16
EditorTitle.Parent = Editor

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 1, -80)
TextBox.Position = UDim2.new(0, 10, 0, 36)
TextBox.BackgroundColor3 = Color3.fromRGB(15,15,15)
TextBox.TextColor3 = Color3.fromRGB(255,255,255)
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.MultiLine = true
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 14
TextBox.Text = "-- Paste your script here"
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

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0, 100, 0, 28)
ClearBtn.Position = UDim2.new(0, 120, 1, -36)
ClearBtn.BackgroundColor3 = Color3.fromRGB(60,120,180)
ClearBtn.Text = "Clear"
ClearBtn.TextColor3 = Color3.fromRGB(255,255,255)
ClearBtn.Font = Enum.Font.SourceSansBold
ClearBtn.TextSize = 14
ClearBtn.Parent = Editor

local CloseEdBtn = Instance.new("TextButton")
CloseEdBtn.Size = UDim2.new(0, 100, 0, 28)
CloseEdBtn.Position = UDim2.new(1, -110, 1, -36)
CloseEdBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
CloseEdBtn.Text = "Close"
CloseEdBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseEdBtn.Font = Enum.Font.SourceSansBold
CloseEdBtn.TextSize = 14
CloseEdBtn.Parent = Editor

-- Editor logic
CustomButton.MouseButton1Click:Connect(function()
    Editor.Visible = true
end)
RunBtn.MouseButton1Click:Connect(function()
    local code = TextBox.Text
    local func, err = loadstring(code)
    if func then
        local ok, res = pcall(func)
        if not ok then warn("Error running script:", res) end
    else
        warn("Syntax error:", err)
    end
end)
ClearBtn.MouseButton1Click:Connect(function() TextBox.Text = "" end)
CloseEdBtn.MouseButton1Click:Connect(function() Editor.Visible = false end)

-- Close hub
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- MINIMIZE BAR
local MinBar = Instance.new("Frame")
MinBar.Size = UDim2.new(0, 220, 0, 36)
MinBar.Position = UDim2.new(0.5, -110, 0.9, -40)
MinBar.BackgroundColor3 = Color3.fromRGB(40,40,40)
MinBar.BorderSizePixel = 0
MinBar.Visible = false
MinBar.Parent = ScreenGui
MinBar.Active = true
MinBar.Draggable = true

local MinLabel = Instance.new("TextLabel")
MinLabel.Size = UDim2.new(1, -60, 1, 0)
MinLabel.Position = UDim2.new(0, 8, 0, 0)
MinLabel.BackgroundTransparency = 1
MinLabel.Text = "Hub (minimized) - Press K"
MinLabel.TextColor3 = Color3.fromRGB(255,255,255)
MinLabel.Font = Enum.Font.SourceSansBold
MinLabel.TextSize = 16
MinLabel.TextXAlignment = Enum.TextXAlignment.Left
MinLabel.Parent = MinBar

local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Size = UDim2.new(0, 50, 0, 24)
RestoreBtn.Position = UDim2.new(1, -58, 0, 6)
RestoreBtn.BackgroundColor3 = Color3.fromRGB(60,200,80)
RestoreBtn.Text = "Open"
RestoreBtn.TextColor3 = Color3.fromRGB(255,255,255)
RestoreBtn.Font = Enum.Font.SourceSansBold
RestoreBtn.TextSize = 12
RestoreBtn.Parent = MinBar

-- TWEEN + STATE
local tweenInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local minimizeState = {size = Frame.Size, position = Frame.Position}
local maximizeState = {size = Frame.Size, position = Frame.Position}
local maximized = false
local minimized = false

-- Utility: resize frame to fit UIList content
local function updateFrameSizeToContent()
    -- compute desired height = titleBarHeight(36) + content absolute height + padding
    local contentHeight = UIList.AbsoluteContentSize.Y
    if contentHeight < 36 then contentHeight = 36 end
    local padding = 24 -- bottom padding
    local desiredHeight = 36 + contentHeight + padding
    local desiredWidth = math.clamp(UIList.AbsoluteContentSize.X + 40, 300, 800) -- width adapt if many columns, keep bounds

    local goal = { Size = UDim2.new(0, desiredWidth, 0, desiredHeight) }
    TweenService:Create(Frame, tweenInfo, goal):Play()
end

-- Listen for changes in layout size
UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    -- only auto-resize when not minimized or maximized
    if not minimized and not maximized then
        updateFrameSizeToContent()
    else
        -- if maximized, keep maximizeState size as full screen; if minimized keep tiny
    end
end)

-- Also run once on startup (delay to let layout compute)
task.defer(function()
    task.wait(0.05)
    updateFrameSizeToContent()
end)

-- MINIMIZE logic (shared function)
local function doMinimize()
    if minimized then return end
    minimized = true
    -- store current state to restore later
    minimizeState.size = Frame.Size
    minimizeState.position = Frame.Position

    TweenService:Create(Frame, tweenInfo, {
        Size = UDim2.new(0, 200, 0, 36),
        Position = UDim2.new(0.5, -100, 0.5, -18)
    }):Play()

    task.delay(0.24, function()
        Content.Visible = false
        MinBar.Visible = true
    end)
end

local function doRestoreFromMinimize()
    if not minimized then return end
    MinBar.Visible = false
    Content.Visible = true
    TweenService:Create(Frame, tweenInfo, {
        Size = minimizeState.size,
        Position = minimizeState.position
    }):Play()
    minimized = false
end

MinimizeButton.MouseButton1Click:Connect(function()
    if minimized then
        doRestoreFromMinimize()
    else
        doMinimize()
    end
end)

RestoreBtn.MouseButton1Click:Connect(doRestoreFromMinimize)
MinLabel.MouseButton1Click:Connect(doRestoreFromMinimize)

-- MAXIMIZE logic
MaximizeButton.MouseButton1Click:Connect(function()
    if not maximized then
        maximizeState.size = Frame.Size
        maximizeState.position = Frame.Position

        TweenService:Create(Frame, tweenInfo, {
            Size = UDim2.new(1, -40, 1, -40),
            Position = UDim2.new(0, 20, 0, 20)
        }):Play()

        maximized = true
        MaximizeButton.Text = "Restore"
    else
        TweenService:Create(Frame, tweenInfo, {
            Size = maximizeState.size,
            Position = maximizeState.position
        }):Play()

        maximized = false
        MaximizeButton.Text = "Maximize"
    end
end)

-- HOTKEY K: toggle minimize/restore
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        -- if editor open, ignore to avoid accidental running while typing
        if Editor.Visible and TextBox:IsFocused() then return end

        if minimized then
            doRestoreFromMinimize()
        else
            doMinimize()
        end
    end
end)

-- Ensure dynamic resizing when new buttons are added later by code:
-- Provide a utility to add custom script buttons at runtime and auto-resize.
local function addButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 300, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(60, 130, 180)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = Content
    btn.LayoutOrder = #Content:GetChildren() + 1

    btn.MouseButton1Click:Connect(function()
        local ok, res = pcall(callback)
        if not ok then warn("Button callback error:", res) end
    end)

    -- small delay to let layout update, then adjust size
    task.delay(0.05, function()
        if not minimized and not maximized then
            updateFrameSizeToContent()
        end
    end)
    return btn
end

-- Example: add an "Auto Collect (safe demo)" button (callback is placeholder)
addButton("Safe Scan Fruits", function()
    -- example placeholder (safe): print counts of plants
    local success, err = pcall(function()
        local root = workspace:FindFirstChild("Farm")
        if not root then return print("Farm not found") end
        local plantsRoot = root:FindFirstChild("Farm")
        if not plantsRoot then return print("Farm.Farm not found") end
        local physical = plantsRoot:FindFirstChild("Important") and plantsRoot.Important:FindFirstChild("Plants_Physical")
        if not physical then return print("Plants_Physical not found") end
        for _, plant in ipairs(physical:GetChildren()) do
            local fruits = plant:FindFirstChild("Fruits")
            print(plant.Name, "->", fruits and #fruits:GetChildren() or 0)
        end
    end)
    return success, err
end)

-- initial final resize
task.delay(0.06, updateFrameSizeToContent)
