
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "ShopGameTrade",
    LoadingTitle = "Đang khởi tạo...",
    LoadingSubtitle = "Fanpage ShopGameTrade ",
})

local Tab = Window:CreateTab("Main", 4483362458)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local nhanvat = player.Character.HumanoidRootPart
local root = char:WaitForChild("HumanoidRootPart")
local luatrai = CFrame.new(1.03133392, 2.77634621, 1.11379433, 0.74464798, -0.582548022, -0.325787127, 0.639664769, 0.762239635, 0.0990950167, 0.190600276, -0.282185405, 0.940235615) + Vector3.new(10, 10, 0)



Tab:CreateButton({
    Name = "🧭 Dịch chuyển tới lửa trại",
    Callback = function()
   
      nhanvat.CFrame = luatrai
    end
})

Tab:CreateButton({
    Name = "Strong Hold",
    Callback = function()
    end
})

Tab:CreateButton({
    Name = "➡️ Tele tới chest tiếp theo",

    Callback = function()
 
    end
})




Tab:CreateButton({
    Name = "infiniteyield",
    Callback = function()
     loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

Tab:CreateButton({
    Name = "Dark Dex",
    Callback = function()
     loadstring(game:HttpGet('https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua'))()
    end
})

Tab:CreateButton({
    Name = "SimpleSpy",
    Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua'))()
    end
})



