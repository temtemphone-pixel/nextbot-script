-- [[ 100% WORKING ANTI-BLACKOUT MENU WITH DESCRIPTION FOR XENO ]] --
local Players = game:Service("Players")
local RunService = game:Service("RunService")
local UserInputService = game:Service("UserInputService")
local Lighting = game:Service("Lighting")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUI if exists
if PlayerGui:FindFirstChild("XenoMenuGlobal") then PlayerGui.XenoMenuGlobal:Destroy() end

-- STATES
local speed = 100
local tSpeed = false
local tNoclip = false
local tJump = false
local tBright = false

-- FEATURE LOOPS
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if tSpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
            end
        end)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if tJump then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

RunService.Stepped:Connect(function()
    if tNoclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ULTRA BRIGHTNESS LOOP (Bypasses Map Blackouts)
task.spawn(function()
    while task.wait(0.1) do
        if tBright then
            pcall(function()
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                Lighting.Brightness = 10 
                Lighting.ClockTime = 14  
                Lighting.FogEnd = 999999 
                Lighting.GlobalShadows = false 
                
                for _, effect in pairs(Lighting:GetChildren()) do
                    if effect:IsA("Atmosphere") or effect:IsA("Sky") then
                        if effect:IsA("Atmosphere") then effect.Density = 0 end
                    end
                end
            end)
        end
    end
end)

-- GUI GENERATION
local sg = Instance.new("ScreenGui", PlayerGui)
sg.Name = "XenoMenuGlobal"
sg.ResetOnSpawn = false

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 180, 0, 310) -- เพิ่มความสูงรองรับข้อความอธิบาย
frame.Position = UDim2.new(0.1, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.Active = true
frame.Draggable = true

local layout = Instance.new("UIListLayout", frame)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0, 5)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
title.Text = "Xeno Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 15

local bSpeed = Instance.new("TextButton", frame)
bSpeed.Size = UDim2.new(0.9, 0, 0, 35)
bSpeed.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
bSpeed.Text = "Speed: OFF"
bSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)

local iSpeed = Instance.new("TextBox", frame)
iSpeed.Size = UDim2.new(0.9, 0, 0, 30)
iSpeed.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
iSpeed.Text = "100"
iSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
iSpeed.PlaceholderText = "Enter Speed..."

local bNoclip = Instance.new("TextButton", frame)
bNoclip.Size = UDim2.new(0.9, 0, 0, 35)
bNoclip.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
bNoclip.Text = "Noclip: OFF"
bNoclip.TextColor3 = Color3.fromRGB(255, 255, 255)

local bJump = Instance.new("TextButton", frame)
bJump.Size = UDim2.new(0.9, 0, 0, 35)
bJump.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
bJump.Text = "Inf Jump: OFF"
bJump.TextColor3 = Color3.fromRGB(255, 255, 255)

local bBright = Instance.new("TextButton", frame)
bBright.Size = UDim2.new(0.9, 0, 0, 35)
bBright.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
bBright.Text = "Anti-Blackout: OFF"
bBright.TextColor3 = Color3.fromRGB(255, 255, 255)

-- TEXT DESCRIPTION FOR BUTTON 5 (คำอธิบายใต้ปุ่มเมนูที่ 5)
local descBright = Instance.new("TextLabel", frame)
descBright.Size = UDim2.new(0.9, 0, 0, 30)
descBright.BackgroundTransparency = 1
descBright.Text = "(Use this fix when map power outages or pitch black)"
descBright.TextColor3 = Color3.fromRGB(180, 180, 180)
descBright.TextSize = 11
descBright.Font = Enum.Font.SourceSansItalic
descBright.TextWrapped = true

-- BUTTON TOGGLES
bSpeed.MouseButton1Click:Connect(function()
    tSpeed = not tSpeed
    bSpeed.Text = "Speed: " .. (tSpeed and "ON" or "OFF")
    bSpeed.BackgroundColor3 = tSpeed and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(50, 50, 55)
end)

iSpeed.FocusLost:Connect(function()
    local n = tonumber(iSpeed.Text)
    if n then speed = n else iSpeed.Text = tostring(speed) end
end)

bNoclip.MouseButton1Click:Connect(function()
    tNoclip = not tNoclip
    bNoclip.Text = "Noclip: " .. (tNoclip and "ON" or "OFF")
    bNoclip.BackgroundColor3 = tNoclip and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(50, 50, 55)
end)

bJump.MouseButton1Click:Connect(function()
    tJump = not tJump
    bJump.Text = "Inf Jump: " .. (tJump and "ON" or "OFF")
    bJump.BackgroundColor3 = tJump and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(50, 50, 55)
end)

bBright.MouseButton1Click:Connect(function()
    tBright = not tBright
    bBright.Text = "Anti-Blackout: " .. (tBright and "ON" or "OFF")
    bBright.BackgroundColor3 = tBright and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(50, 50, 55)
end)

-- PC KEYBINDS (Z, X, C, F, V)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Z then tSpeed = not tSpeed bSpeed.Text = "Speed: "..(tSpeed and "ON" or "OFF") bSpeed.BackgroundColor3 = tSpeed and Color3.fromRGB(0,170,100) or Color3.fromRGB(50,50,55)
    elseif input.KeyCode == Enum.KeyCode.X then tNoclip = not tNoclip bNoclip.Text = "Noclip: "..(tNoclip and "ON" or "OFF") bNoclip.BackgroundColor3 = tNoclip and Color3.fromRGB(0,170,100) or Color3.fromRGB(50,50,55)
    elseif input.KeyCode == Enum.KeyCode.C then tJump = not tJump bJump.Text = "Inf Jump: "..(tJump and "ON" or "OFF") bJump.BackgroundColor3 = tJump and Color3.fromRGB(0,170,100) or Color3.fromRGB(50,50,55)
    elseif input.KeyCode == Enum.KeyCode.F then tBright = not tBright bBright.Text = "Anti-Blackout: "..(tBright and "ON" or "OFF") bBright.BackgroundColor3 = tBright and Color3.fromRGB(0,170,100) or Color3.fromRGB(50,50,55)
    elseif input.KeyCode == Enum.KeyCode.V then frame.Visible = not frame.Visible end
end)
