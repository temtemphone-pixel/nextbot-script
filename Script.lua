local Players = game:Service("Players")
local RunService = game:Service("RunService")
local UserInputService = game:Service("UserInputService")
local CoreGui = game:Service("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- --- CONFIGURATION & STATES ---
local targetSpeed = 16 
local speedEnabled = false
local noclipEnabled = false
local infJumpEnabled = false

-- --- FEATURE LOGIC ---
-- Speed Loop
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                humanoid.WalkSpeed = speedEnabled and targetSpeed or 16
            end
        end)
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- --- GUI CREATION ---
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local Title = Instance.new("TextLabel")
local SpeedToggleBtn = Instance.new("TextButton")
local SpeedInputBox = Instance.new("TextBox") -- ช่องใส่ความเร็ว
local NoclipBtn = Instance.new("TextButton")
local InfJumpBtn = Instance.new("TextButton")
local ToggleGuiBtn = Instance.new("TextButton")

-- ScreenGui Setup
ScreenGui.Name = "XenoCustomSpeedGui"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Frame 
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 270)
MainFrame.Active = true
MainFrame.Draggable = true

-- Layout
UIListLayout.Parent = MainFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
Title.Text = "Xeno Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold

-- Helper function to style elements
local function styleElement(element, text, isBox)
    element.Size = UDim2.new(0.9, 0, 0, 40)
    element.BackgroundColor3 = isBox and Color3.fromRGB(20, 20, 25) or Color3.fromRGB(50, 50, 55)
    element.Text = text
    element.TextColor3 = Color3.fromRGB(255, 255, 255)
    element.TextSize = 14
    element.Font = Enum.Font.SourceSans
    element.BorderSizePixel = 0
end

styleElement(SpeedToggleBtn, "Speed: OFF", false)
styleElement(SpeedInputBox, "100", true) 
styleElement(NoclipBtn, "Noclip: OFF", false)
styleElement(InfJumpBtn, "Infinite Jump: OFF", false)

-- ตั้งค่าเฉพาะของ TextBox (ช่องใส่ความเร็ว)
SpeedInputBox.PlaceholderText = "text speed"
SpeedInputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
targetSpeed = 100 --

-- Parent Elements
SpeedToggleBtn.Parent = MainFrame
SpeedInputBox.Parent = MainFrame
NoclipBtn.Parent = MainFrame
InfJumpBtn.Parent = MainFrame

-- Toggle Mini Button 
ToggleGuiBtn.Name = "ToggleGuiBtn"
ToggleGuiBtn.Parent = ScreenGui
ToggleGuiBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleGuiBtn.Size = UDim2.new(0, 60, 0, 25)
ToggleGuiBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
ToggleGuiBtn.Text = "Hide/Show"
ToggleGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleGuiBtn.TextSize = 12
ToggleGuiBtn.BorderSizePixel = 0

-- --- INTERACTION LOGIC ---

local function toggleSpeed()
    speedEnabled = not speedEnabled
    SpeedToggleBtn.Text = "Speed: " .. (speedEnabled and "ON" or "OFF")
    SpeedToggleBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(50, 50, 55)
end

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    NoclipBtn.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    NoclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(50, 50, 55)
end

local function toggleInfJump()
    infJumpEnabled = not infJumpEnabled
    InfJumpBtn.Text = "Inf Jump: " .. (infJumpEnabled and "ON" or "OFF")
    InfJumpBtn.BackgroundColor3 = infJumpEnabled and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(50, 50, 55)
end

-- ดักจับเมื่อผู้เล่นพิมพ์ความเร็วแล้วกด Enter หรือเปลี่ยนไปจิ้มที่อื่น
SpeedInputBox.FocusLost:Connect(function(enterPressed)
    local text = SpeedInputBox.Text
    local number = tonumber(text)
    
    if number then
        targetSpeed = number
    else
        -- ถ้าพิมพ์ไม่ใช่ตัวเลข ให้ตีกลับไปค่าเดิม
        SpeedInputBox.Text = tostring(targetSpeed)
    end
end)

-- Click Events
SpeedToggleBtn.MouseButton1Click:Connect(toggleSpeed)
NoclipBtn.MouseButton1Click:Connect(toggleNoclip)
InfJumpBtn.MouseButton1Click:Connect(toggleInfJump)
ToggleGuiBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- PC Keybinds
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- ป้องกันปุ่มลัดทำงานตอนกำลังพิมพ์ในช่องใส่ความเร็ว
    
    if input.KeyCode == Enum.KeyCode.Z then
        toggleSpeed()
    elseif input.KeyCode == Enum.KeyCode.X then
        toggleNoclip()
    elseif input.KeyCode == Enum.KeyCode.C then
        toggleInfJump()
    elseif input.KeyCode == Enum.KeyCode.V then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
