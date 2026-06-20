-- [[ troll nextbot v1.0 - KAVO UI MOBILE + PC SLIDER EDITION ]] --

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("troll nextbot v1.0 😈", "DarkTheme")

-- MAIN TAB
local Tab1 = Window:NewTab("Main Features")
local Section1 = Tab1:NewSection("Nextbot Troll Tools")

-- ระบบหลังบ้าน: ลูปเช็คและล็อกสปีดตลอดเวลา (สู้กับระบบเกม)
local player = game:GetService("Players").LocalPlayer
local currentSpeed = 16 -- ค่าเริ่มต้น

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

-- 1. SPEED SLIDER FUNCTION (เปลี่ยนจากช่องพิมพ์เป็นแถบเลื่อน เพื่อให้ใช้งานง่ายบนมือถือ)
Section1:NewSlider("Set WalkSpeed", "Slide to change speed directly", 200, 16, function(s)
    currentSpeed = s 
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = currentSpeed
        end
    end)
end)

-- ปุ่มรีเซ็ตความเร็วกลับเป็นค่าปกติ
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

-- 3. INFINITE JUMP FUNCTION (เวอร์ชันแก้บั๊ก F9 สีแดง - กดค้างรอบเดียวโดดรัวๆ)
local InfiniteJumpEnabled = false

task.spawn(function()
    while true do
        task.wait(0.05) -- ลูปเช็คทุกๆ 0.05 วินาที เพื่อไม่ให้หนักเครื่องและไม่เกิด Error
        if InfiniteJumpEnabled then
            pcall(function()
                local character = player.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                
                if humanoid and humanoid.Health > 0 then
                    local uis = game:GetService("UserInputService")
                    
                    -- เช็คว่ามีการกดค้าง (Spacebar บน PC หรือ ปุ่มกระโดดบนหน้าจอมือถือ)
                    if uis:IsKeyDown(Enum.KeyCode.Space) or humanoid.Jump then
                        -- บังคับสถานะให้กระโดดรัวๆ อัตโนมัติ
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    end
end)

Section1:NewToggle("Infinite Jump (Hold to Bunnyhop)", "Toggle auto jump on/off", function(state)
    InfiniteJumpEnabled = state
end)

-- 4. FULL BRIGHT FUNCTION (คำอธิบายภาษาอังกฤษตรงปุ่มชัด ๆ)
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
