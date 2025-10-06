-- Brainrot Ultimate Hack v3.0 - ИСПРАВЛЕННАЯ ВЕРСИЯ
-- Полный рабочий скрипт с красивым GUI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Ожидаем появления персонажа
local function waitForCharacter()
    local character = Player.Character
    if not character then
        character = Player.CharacterAdded:Wait()
    end
    return character
end

-- Создание безопасного GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotHackGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(138, 43, 226)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок с градиентом
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 15)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Text = "BRAINROT ULTIMATE V3.0"
TitleLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextStrokeTransparency = 0.7
TitleLabel.Parent = MainFrame

-- Анимация заголовка
spawn(function()
    while true do
        for i = 0, 1, 0.02 do
            if TitleLabel then
                TitleLabel.TextColor3 = Color3.fromHSV(i, 0.9, 1)
                wait(0.05)
            else
                break
            end
        end
    end
end)

-- Контейнер для кнопок
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(0, 20, 0, 70)
ButtonContainer.Size = UDim2.new(1, -40, 1, -80)
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = ButtonContainer

-- Функция создания красивых кнопок
function CreateButton(name, color, icon)
    local Button = Instance.new("TextButton")
    local Corner = Instance.new("UICorner")
    local Stroke = Instance.new("UIStroke")
    local ButtonPadding = Instance.new("UIPadding")
    
    Button.Name = name .. "Button"
    Button.BackgroundColor3 = color
    Button.Size = UDim2.new(1, 0, 0, 48)
    Button.Text = " " .. icon .. " " .. name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.Font = Enum.Font.GothamSemibold
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.AutoButtonColor = false
    
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button
    
    Stroke.Color = Color3.fromRGB(60, 60, 80)
    Stroke.Thickness = 1.5
    Stroke.Parent = Button
    
    ButtonPadding.PaddingLeft = UDim.new(0, 15)
    ButtonPadding.Parent = Button
    
    -- Анимации
    Button.MouseEnter:Connect(function()
        if Button then
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = color + Color3.fromRGB(25, 25, 25),
                Size = UDim2.new(1, 10, 0, 50)
            }):Play()
        end
    end)
    
    Button.MouseLeave:Connect(function()
        if Button then
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = color,
                Size = UDim2.new(1, 0, 0, 48)
            }):Play()
        end
    end)
    
    Button.MouseButton1Down:Connect(function()
        if Button then
            TweenService:Create(Button, TweenInfo.new(0.1), {
                BackgroundColor3 = color - Color3.fromRGB(20, 20, 20)
            }):Play()
        end
    end)
    
    Button.MouseButton1Up:Connect(function()
        if Button then
            TweenService:Create(Button, TweenInfo.new(0.1), {
                BackgroundColor3 = color + Color3.fromRGB(25, 25, 25)
            }):Play()
        end
    end)
    
    return Button
end

-- ⚡ SPEED HACK
local SpeedButton = CreateButton("INFINITE SPEED", Color3.fromRGB(255, 152, 0), "⚡")
local speedEnabled = false
local originalWalkSpeed = 16

SpeedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    
    local character = waitForCharacter()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        if speedEnabled then
            originalWalkSpeed = humanoid.WalkSpeed
            -- Поиск скоростной катушки
            local function findSpeedItem()
                local backpack = Player:FindFirstChild("Backpack")
                local characterItems = character:GetChildren()
                
                local allItems = {}
                if backpack then
                    for _, item in pairs(backpack:GetChildren()) do
                        table.insert(allItems, item)
                    end
                end
                for _, item in pairs(characterItems) do
                    table.insert(allItems, item)
                end
                
                for _, item in pairs(allItems) do
                    local itemName = string.lower(item.Name)
                    if string.find(itemName, "coil") or 
                       string.find(itemName, "speed") or 
                       string.find(itemName, "boost") then
                        return true
                    end
                end
                return false
            end
            
            local hasSpeedItem = findSpeedItem()
            local targetSpeed = hasSpeedItem and 50 or 35
            
            -- Плавное увеличение скорости
            spawn(function()
                for i = 1, 30 do
                    if humanoid and speedEnabled then
                        humanoid.WalkSpeed = originalWalkSpeed + (i * ((targetSpeed - originalWalkSpeed) / 30))
                        wait(0.03)
                    else
                        break
                    end
                end
                if humanoid and speedEnabled then
                    humanoid.WalkSpeed = targetSpeed
                end
            end)
            
            SpeedButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
            SpeedButton.Text = " ⚡ SPEED: ACTIVATED"
        else
            humanoid.WalkSpeed = originalWalkSpeed
            SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
            SpeedButton.Text = " ⚡ INFINITE SPEED"
        end
    end
end)

-- 👻 INVSEE PLAYER
local InvseeButton = CreateButton("INVSEE PLAYER", Color3.fromRGB(33, 150, 243), "👻")
local invseeEnabled = false

InvseeButton.MouseButton1Click:Connect(function()
    invseeEnabled = not invseeEnabled
    local character = waitForCharacter()
    
    if character then
        if invseeEnabled then
            -- Делаем персонажа невидимым
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                elseif part:IsA("Decal") then
                    part.Transparency = 1
                end
            end
            
            -- Отключаем тени
            if character:FindFirstChild("Humanoid") then
                character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            end
            
            InvseeButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
            InvseeButton.Text = " 👻 INVSEE: ACTIVE"
        else
            -- Возвращаем видимость
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                elseif part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
            
            InvseeButton.BackgroundColor3 = Color3.fromRGB(33, 150, 243)
            InvseeButton.Text = " 👻 INVSEE PLAYER"
        end
    end
end)

-- 🧠 INVSEE BRAINROT
local BrainrotInvseeButton = CreateButton("INVSEE BRAINROT", Color3.fromRGB(156, 39, 176), "🧠")
local brainrotInvseeEnabled = false

BrainrotInvseeButton.MouseButton1Click:Connect(function()
    brainrotInvseeEnabled = not brainrotInvseeEnabled
    
    local function toggleBrainrotVisibility()
        local targetNames = {"Brainrot", "BrainRot", "StealTarget", "Objective", "Target"}
        
        for _, name in pairs(targetNames) do
            local target = workspace:FindFirstChild(name)
            if target then
                for _, obj in pairs(target:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        if brainrotInvseeEnabled then
                            obj.Transparency = 1
                            obj.CanCollide = false
                        else
                            obj.Transparency = 0
                            obj.CanCollide = true
                        end
                    end
                end
            end
        end
    end
    
    toggleBrainrotVisibility()
    
    if brainrotInvseeEnabled then
        BrainrotInvseeButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        BrainrotInvseeButton.Text = " 🧠 BRAINROT: HIDDEN"
        
        -- Постоянное обновление для новых объектов
        spawn(function()
            while brainrotInvseeEnabled do
                toggleBrainrotVisibility()
                wait(0.5)
            end
        end)
    else
        BrainrotInvseeButton.BackgroundColor3 = Color3.fromRGB(156, 39, 176)
        BrainrotInvseeButton.Text = " 🧠 INVSEE BRAINROT"
    end
end)

-- 🚀 INSTANT STEAL
local InstantStealButton = CreateButton("INSTANT STEAL MODE", Color3.fromRGB(233, 30, 99), "🚀")
local instantStealEnabled = false
local stealGui = nil

InstantStealButton.MouseButton1Click:Connect(function()
    instantStealEnabled = not instantStealEnabled
    
    if instantStealEnabled then
        -- Создаем GUI для Instant Steal
        stealGui = Instance.new("ScreenGui")
        stealGui.Name = "InstantStealGUI"
        stealGui.ResetOnSpawn = false
        
        local StealFrame = Instance.new("Frame")
        StealFrame.Name = "StealFrame"
        StealFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        StealFrame.BackgroundTransparency = 0.1
        StealFrame.Position = UDim2.new(0.75, 0, 0.3, 0)
        StealFrame.Size = UDim2.new(0, 200, 0, 160)
        StealFrame.Active = true
        StealFrame.Draggable = true
        
        local StealCorner = Instance.new("UICorner")
        StealCorner.CornerRadius = UDim.new(0, 12)
        StealCorner.Parent = StealFrame
        
        local StealStroke = Instance.new("UIStroke")
        StealStroke.Color = Color3.fromRGB(233, 30, 99)
        StealStroke.Thickness = 2
        StealStroke.Parent = StealFrame
        
        local StealTitle = Instance.new("TextLabel")
        StealTitle.Name = "StealTitle"
        StealTitle.BackgroundTransparency = 1
        StealTitle.Size = UDim2.new(1, 0, 0, 30)
        StealTitle.Text = "INSTANT STEAL"
        StealTitle.TextColor3 = Color3.fromRGB(233, 30, 99)
        StealTitle.TextSize = 16
        StealTitle.Font = Enum.Font.GothamBold
        StealTitle.Parent = StealFrame
        
        local StealLayout = Instance.new("UIListLayout")
        StealLayout.Padding = UDim.new(0, 8)
        StealLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        StealLayout.Parent = StealFrame
        
        -- Кнопки Instant Steal GUI
        local InstantBaseBtn = CreateButton("INSTANT BASE", Color3.fromRGB(255, 193, 7), "🏠")
        InstantBaseBtn.Size = UDim2.new(0.9, 0, 0, 40)
        InstantBaseBtn.TextXAlignment = Enum.TextXAlignment.Center
        InstantBaseBtn.Parent = StealFrame
        
        local InstantStealBtn = CreateButton("INSTANT STEAL", Color3.fromRGB(103, 58, 183), "💰")
        InstantStealBtn.Size = UDim2.new(0.9, 0, 0, 40)
        InstantStealBtn.TextXAlignment = Enum.TextXAlignment.Center
        InstantStealBtn.Parent = StealFrame
        
        local TeleportHomeBtn = CreateButton("TELEPORT HOME", Color3.fromRGB(0, 150, 136), "🏡")
        TeleportHomeBtn.Size = UDim2.new(0.9, 0, 0, 40)
        TeleportHomeBtn.TextXAlignment = Enum.TextXAlignment.Center
        TeleportHomeBtn.Parent = StealFrame
        
        -- Функции кнопок
        InstantBaseBtn.MouseButton1Click:Connect(function()
            local character = waitForCharacter()
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local enemyBases = {"EnemyBase", "Base", "EnemySpawn", "RedBase", "BlueBase"}
                for _, baseName in pairs(enemyBases) do
                    local base = workspace:FindFirstChild(baseName)
                    if base then
                        root.CFrame = CFrame.new(base.Position.X, base.Position.Y + 5, base.Position.Z)
                        break
                    end
                end
            end
        end)
        
        InstantStealBtn.MouseButton1Click:Connect(function()
            local character = waitForCharacter()
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local brainrot = workspace:FindFirstChild("Brainrot") or workspace:FindFirstChild("BrainRot")
                if brainrot then
                    -- Телепортация к brainrot и обратно
                    local originalPosition = root.CFrame
                    root.CFrame = brainrot.CFrame
                    
                    wait(0.3)
                    
                    -- Телепортация к своей базе
                    local myBases = {"MyBase", "Spawn", "SafeZone", "Home"}
                    for _, baseName in pairs(myBases) do
                        local myBase = workspace:FindFirstChild(baseName)
                        if myBase then
                            root.CFrame = myBase.CFrame + Vector3.new(0, 3, 0)
                            break
                        end
                    end
                end
            end
        end)
        
        TeleportHomeBtn.MouseButton1Click:Connect(function()
            local character = waitForCharacter()
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local spawn = workspace:FindFirstChild("Spawn") or workspace:FindFirstChild("HomeBase")
                if spawn then
                    root.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
                else
                    root.CFrame = CFrame.new(0, 50, 0)
                end
            end
        end)
        
        stealGui.Parent = PlayerGui
        StealFrame.Parent = stealGui
        InstantStealButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        InstantStealButton.Text = " 🚀 STEAL MODE: ACTIVE"
    else
        if stealGui then
            stealGui:Destroy()
            stealGui = nil
        end
        InstantStealButton.BackgroundColor3 = Color3.fromRGB(233, 30, 99)
        InstantStealButton.Text = " 🚀 INSTANT STEAL MODE"
    end
end)

-- 🌀 NO CLIP
local NoclipButton = CreateButton("NO CLIP MODE", Color3.fromRGB(0, 188, 212), "🌀")
local noclipEnabled = false
local noclipConnection

NoclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        local character = waitForCharacter()
        
        -- Отключаем коллизию
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        
        -- Постоянное обновление
        noclipConnection = RunService.Stepped:Connect(function()
            if character and noclipEnabled then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else
                if noclipConnection then
                    noclipConnection:Disconnect()
                end
            end
        end)
        
        NoclipButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        NoclipButton.Text = " 🌀 NO CLIP: ACTIVE"
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        
        local character = waitForCharacter()
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        NoclipButton.BackgroundColor3 = Color3.fromRGB(0, 188, 212)
        NoclipButton.Text = " 🌀 NO CLIP MODE"
    end
end)

-- 🕊️ FLY MODE
local FlyButton = CreateButton("FLY MODE", Color3.fromRGB(205, 220, 57), "🕊️")
local flyEnabled = false
local flyConnection
local flyBodyVelocity

FlyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        local character = waitForCharacter()
        local root = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if root and humanoid then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
            flyBodyVelocity.Parent = root
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if flyEnabled and root and flyBodyVelocity then
                    local camera = workspace.CurrentCamera
                    local moveDirection = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDirection = moveDirection + camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDirection = moveDirection - camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDirection = moveDirection - camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDirection = moveDirection + camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        moveDirection = moveDirection - Vector3.new(0, 1, 0)
                    end
                    
                    flyBodyVelocity.Velocity = moveDirection * 100
                else
                    if flyConnection then
                        flyConnection:Disconnect()
                    end
                    if flyBodyVelocity then
                        flyBodyVelocity:Destroy()
                    end
                end
            end)
            
            FlyButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
            FlyButton.Text = " 🕊️ FLY: ACTIVE"
        end
    else
        if flyConnection then
            flyConnection:Disconnect()
        end
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
        end
        
        FlyButton.BackgroundColor3 = Color3.fromRGB(205, 220, 57)
        FlyButton.Text = " 🕊️ FLY MODE"
    end
end)

-- 🔒 ANTI-AFK
local AntiAFKButton = CreateButton("ANTI-AFK", Color3.fromRGB(121, 85, 72), "🔒")
local antiAFKEnabled = false
local antiAFKConnection

AntiAFKButton.MouseButton1Click:Connect(function()
    antiAFKEnabled = not antiAFKEnabled
    
    if antiAFKEnabled then
        local virtualUser = game:GetService("VirtualUser")
        antiAFKConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            if antiAFKEnabled then
                virtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                wait(1)
                virtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        end)
        
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        AntiAFKButton.Text = " 🔒 ANTI-AFK: ACTIVE"
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
        end
        
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(121, 85, 72)
        AntiAFKButton.Text = " 🔒 ANTI-AFK"
    end
end)

-- ФИНАЛЬНАЯ НАСТРОЙКА GUI
ScreenGui.Parent = PlayerGui
MainFrame.Parent = ScreenGui

-- Добавляем все кнопки в контейнер
SpeedButton.Parent = ButtonContainer
InvseeButton.Parent = ButtonContainer
BrainrotInvseeButton.Parent = ButtonContainer
InstantStealButton.Parent = ButtonContainer
NoclipButton.Parent = ButtonContainer
FlyButton.Parent = ButtonContainer
AntiAFKButton.Parent = ButtonContainer

-- Защита от удаления GUI
ScreenGui.ChildRemoved:Connect(function(child)
    if child.Name == "MainFrame" then
        wait(2)
        if not PlayerGui:FindFirstChild("BrainrotHackGUI") then
            local newGUI = ScreenGui:Clone()
            newGUI.Parent = PlayerGui
        end
    end
end)

-- Уведомление о загрузке
spawn(function()
    wait(1)
    TitleLabel.Text = "BRAINROT ULTIMATE V3.0 ✓"
    wait(1)
    TitleLabel.Text = "BRAINROT ULTIMATE V3.0"
end)

print("🎮 Brainrot Ultimate Hack v3.0 loaded successfully!")
print("✅ GUI System: ACTIVE")
print("🚀 All features: READY")
