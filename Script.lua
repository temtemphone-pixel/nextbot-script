-- [[ troll nextbot v1.0 - AUTO JUMP HOLD EDITION ]] --

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("troll nextbot v1.0 😈", "DarkTheme")

-- MAIN TAB
local Tab1 = Window:NewTab("Main Features")
local Section1 = Tab1:NewSection("Nextbot Troll Tools")

-- ระบบหลังบ้าน: ลูปเช็คและล็อกสปีดตลอดเวลา (สู้กับระบบเกม)
local player = game:GetService("Players").LocalPlayer
local currentSpeed = 16 

local function loopSpeed(character)
    local humanoid = character:WaitForChild("Humanoid", 10)
    if humanoid then
        task.spawn(function()
            while character and character:IsDescendantOf(workspace) do
                humanoid.WalkSpeed = currentSpeed
                task.wait(0.1)
            end
        end)
    end
end

if player.Character then loopSpeed(player.Character) end
player.CharacterAdded:Connect(loopSpeed)

-- 1. SPEED SLIDER FUNCTION (เวอร์ชัน Mobile + PC)
Section1:NewSlider("Set WalkSpeed", "Slide to change speed directly", 200, 16, function(s)
    currentSpeed = s
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = currentSpeed
        end
    end)
end)

-- ปุ่มรีเซ็ตความเร็ว
Section1:NewButton("Reset Speed (Normal)", "Reset back to 16", function()
    currentSpeed = 16
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end)
end)

-- 2. NOCLIP FUNCTION
local noclip = false
game:GetService("RunService").Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

Section1:NewToggle("Noclip (Walk Through Walls)", "Toggle noclip on/off", function(state)
    noclip = state
end)

-- 3. INFINITE JUMP FUNCTION (แก้ไขใหม่: กดค้างรอบเดียวโดดรัวๆ ออโต้)
local InfiniteJumpEnabled = false
game:GetService("RunService").RenderStepped:Connect(function()
    if InfiniteJumpEnabled then
        pcall(function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            
            -- เช็คว่าถ้าผู้เล่นกดปุ่มกระโดดค้างไว้ (ทั้งบนมือถือและคอม) และตัวละครไม่ได้ลอยสูงเกินไป
            if humanoid and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) or (humanoid and humanoid.Jump) then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

Section1:NewToggle("Infinite Jump (Hold to Bunnyhop)", "Toggle auto jump on/off", function(state)
    InfiniteJumpEnabled = state
end)

-- 4. FULL BRIGHT FUNCTION
local Light = game:GetService("Lighting")
local fullbright = false

Section1:NewToggle("Full Bright (Use when lights go out)", "Anti-Dark Mode", function(state)
    fullbright = state
    if fullbright then
        Light.Ambient = Color3.new(1, 1, 1)
        Light.Brightness = 3
        Light.GlobalShadows = false
    else
        Light.Ambient = Color3.new(0.5, 0.5, 0.5)
        Light.Brightness = 1
        Light.GlobalShadows = true
    end
end)
end)
