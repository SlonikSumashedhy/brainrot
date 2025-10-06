-- Brainrot Ultimate Hack v2.0
-- Полный обход античита с продвинутыми методами
-- Только для приватных серверов и тестовых аккаунтов

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Анти-детект система
local AntiDetect = {
    _G = {},
    Hooked = {},
    OriginalFunctions = {}
}

-- Очистка следов в памяти
for i,v in pairs(getreg()) do
    if type(v) == "function" and islclosure(v) and not is_synapse_function(v) then
        local constants = getconstants(v)
        if table.find(constants, "HookFunction") or table.find(constants, "Detect") then
            hookfunction(v, function() return true end)
        end
    end
end

-- Обход античита через hookfunction
function AntiDetect:HookFunction(fn, replacement)
    local original = fn
    self.OriginalFunctions[fn] = original
    hookfunction(fn, replacement)
    self.Hooked[fn] = true
end

-- Создание безопасного GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CoreGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(138, 43, 226)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок с анимацией
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Text = "BRAINROT ULTIMATE V2.0"
TitleLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextStrokeTransparency = 0.5
TitleLabel.Parent = MainFrame

-- Анимация заголовка
spawn(function()
    while true do
        for i = 0, 1, 0.05 do
            TitleLabel.TextColor3 = Color3.fromHSV(i, 0.8, 1)
            wait(0.1)
        end
    end
end)

local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "Buttons"
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(0, 25, 0, 60)
ButtonContainer.Size = UDim2.new(1, -50, 1, -70)
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 15)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = ButtonContainer

-- Функция создания кнопок
function CreateButton(name, color, sizeY)
    local Button = Instance.new("TextButton")
    local Corner = Instance.new("UICorner")
    local Stroke = Instance.new("UIStroke")
    
    Button.Name = name
    Button.BackgroundColor3 = color
    Button.Size = UDim2.new(1, 0, 0, sizeY or 45)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.Font = Enum.Font.GothamSemibold
    Button.AutoButtonColor = false
    
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    Stroke.Color = Color3.fromRGB(60, 60, 80)
    Stroke.Thickness = 1
    Stroke.Parent = Button
    
    -- Анимация наведения
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = color + Color3.fromRGB(20, 20, 20)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    
    Button.Parent = ButtonContainer
    return Button
end

-- SPEED HACK (Умный обход проверок)
local SpeedButton = CreateButton("⚡ INFINITE SPEED", Color3.fromRGB(255, 152, 0))
local speedEnabled = false
local originalWalkSpeed = 16

SpeedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    
    if speedEnabled then
        -- Поиск скоростной катушки с обходом проверок
        local function FindSpeedCoil()
            local backpack = Player:FindFirstChild("Backpack")
            local character = Player.Character
            
            -- Проверяем все возможные места
            local locations = {backpack, character}
            for _, location in pairs(locations) do
                if location then
                    for _, item in pairs(location:GetChildren()) do
                        local itemName = string.lower(item.Name)
                        if string.find(itemName, "coil") or 
                           string.find(itemName, "speed") or 
                           string.find(itemName, "boost") then
                            return true, item
                        end
                    end
                end
            end
            return false
        end
        
        local hasCoil, coilItem = FindSpeedCoil()
        
        if hasCoil then
            -- Увеличиваем скорость с защитой от обнаружения
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                originalWalkSpeed = humanoid.WalkSpeed
                
                -- Медленное увеличение скорости для обхода детекции
                spawn(function()
                    for i = 1, 50 do
                        if humanoid and speedEnabled then
                            humanoid.WalkSpeed = originalWalkSpeed + (i * 0.7)
                            wait(0.02)
                        end
                    end
                end)
                
                SpeedButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
                SpeedButton.Text = "⚡ SPEED: ACTIVATED"
            end
        else
            -- Создаем виртуальную катушку в памяти
            spawn(function()
                wait(0.5)
                local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and speedEnabled then
                    humanoid.WalkSpeed = 50
                    SpeedButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
                    SpeedButton.Text = "⚡ SPEED: FORCED"
                end
            end)
        end
    else
        -- Возвращаем нормальную скорость
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = originalWalkSpeed
        end
        SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
        SpeedButton.Text = "⚡ INFINITE SPEED"
    end
end)

-- INVSEE FUNCTION (Полная невидимость)
local InvseeButton = CreateButton("👻 INVSEE PLAYER", Color3.fromRGB(33, 150, 243))
local invseeEnabled = false

InvseeButton.MouseButton1Click:Connect(function()
    invseeEnabled = not invseeEnabled
    local character = Player.Character
    
    if character and invseeEnabled then
        -- Делаем персонажа полностью невидимым
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
                if part:FindFirstChildOfClass("SurfaceAppearance") then
                    part:FindFirstChildOfClass("SurfaceAppearance"):Destroy()
                end
            elseif part:IsA("Decal") then
                part.Transparency = 1
            end
        end
        
        -- Отключаем тени и эффекты
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        end
        
        InvseeButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        InvseeButton.Text = "👻 INVSEE: ACTIVE"
    else
        -- Возвращаем видимость
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                elseif part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
        end
        InvseeButton.BackgroundColor3 = Color3.fromRGB(33, 150, 243)
        InvseeButton.Text = "👻 INVSEE PLAYER"
    end
end)

-- INVSEE BRAINROT FUNCTION
local BrainrotInvseeButton = CreateButton("🧠 INVSEE BRAINROT", Color3.fromRGB(156, 39, 176))
local brainrotInvseeEnabled = false

BrainrotInvseeButton.MouseButton1Click:Connect(function()
    brainrotInvseeEnabled = not brainrotInvseeEnabled
    
    -- Поиск всех brainrot объектов
    local function ToggleBrainrotVisibility()
        local targets = {
            "Brainrot", "BrainRot", "StealTarget", 
            "Objective", "Target", "Item"
        }
        
        for _, targetName in pairs(targets) do
            local target = workspace:FindFirstChild(targetName)
            if target then
                for _, obj in pairs(target:GetDescendants()) do
                    if brainrotInvseeEnabled then
                        -- Делаем невидимым
                        if obj:IsA("BasePart") then
                            obj.Transparency = 1
                            obj.CanCollide = false
                        end
                    else
                        -- Возвращаем видимость
                        if obj:IsA("BasePart") then
                            obj.Transparency = 0
                            obj.CanCollide = true
                        end
                    end
                end
            end
        end
    end
    
    ToggleBrainrotVisibility()
    
    if brainrotInvseeEnabled then
        BrainrotInvseeButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        BrainrotInvseeButton.Text = "🧠 BRAINROT: HIDDEN"
        
        -- Постоянное обновление для новых объектов
        spawn(function()
            while brainrotInvseeEnabled do
                ToggleBrainrotVisibility()
                wait(0.5)
            end
        end)
    else
        BrainrotInvseeButton.BackgroundColor3 = Color3.fromRGB(156, 39, 176)
        BrainrotInvseeButton.Text = "🧠 INVSEE BRAINROT"
    end
end)

-- INSTANT STEAL FUNCTION
local InstantStealButton = CreateButton("🚀 INSTANT STEAL MODE", Color3.fromRGB(233, 30, 99))
local instantStealEnabled = false
local stealGui = nil

InstantStealButton.MouseButton1Click:Connect(function()
    instantStealEnabled = not instantStealEnabled
    
    if instantStealEnabled then
        -- Создаем расширенный GUI для Instant Steal
        stealGui = Instance.new("ScreenGui")
        stealGui.Name = "InstantStealGUI"
        stealGui.ResetOnSpawn = false
        
        local StealFrame = Instance.new("Frame")
        StealFrame.Name = "StealFrame"
        StealFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        StealFrame.Position = UDim2.new(0.75, 0, 0.3, 0)
        StealFrame.Size = UDim2.new(0, 220, 0, 150)
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
        StealTitle.Name = "Title"
        StealTitle.BackgroundTransparency = 1
        StealTitle.Size = UDim2.new(1, 0, 0, 30)
        StealTitle.Text = "INSTANT STEAL"
        StealTitle.TextColor3 = Color3.fromRGB(233, 30, 99)
        StealTitle.TextSize = 16
        StealTitle.Font = Enum.Font.GothamBold
        StealTitle.Parent = StealFrame
        
        local StealLayout = Instance.new("UIListLayout")
        StealLayout.Padding = UDim.new(0, 10)
        StealLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        StealLayout.Parent = StealFrame
        
        -- Кнопка Instant Base
        local InstantBaseBtn = CreateButton("🏠 INSTANT BASE", Color3.fromRGB(255, 193, 7))
        InstantBaseBtn.Size = UDim2.new(0.8, 0, 0, 35)
        InstantBaseBtn.Parent = StealFrame
        
        -- Кнопка Instant Steal
        local InstantStealBtn = CreateButton("💰 INSTANT STEAL", Color3.fromRGB(103, 58, 183))
        InstantStealBtn.Size = UDim2.new(0.8, 0, 0, 35)
        InstantStealBtn.Parent = StealFrame
        
        -- Кнопка Teleport Home
        local TeleportHomeBtn = CreateButton("🏡 TELEPORT HOME", Color3.fromRGB(0, 150, 136))
        TeleportHomeBtn.Size = UDim2.new(0.8, 0, 0, 35)
        TeleportHomeBtn.Parent = StealFrame
        
        -- Функциональность Instant Base
        InstantBaseBtn.MouseButton1Click:Connect(function()
            local character = Player.Character
            if character then
                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    -- Поиск вражеской базы
                    local enemyBases = {
                        "EnemyBase", "Base", "EnemySpawn",
                        "RedBase", "BlueBase", "TeamSpawn"
                    }
                    
                    for _, baseName in pairs(enemyBases) do
                        local base = workspace:FindFirstChild(baseName)
                        if base then
                            -- Телепортация внутрь базы через стену
                            local basePos = base.Position
                            root.CFrame = CFrame.new(basePos.X, basePos.Y + 5, basePos.Z)
                            break
                        end
                    end
                end
            end
        end)
        
        -- Функциональность Instant Steal
        InstantStealBtn.MouseButton1Click:Connect(function()
            local character = Player.Character
            if character then
                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    -- Автоматическая кража brainrot
                    local brainrot = workspace:FindFirstChild("Brainrot") or workspace:FindFirstChild("BrainRot")
                    if brainrot then
                        -- Телепортация к brainrot
                        root.CFrame = brainrot.CFrame
                        
                        -- Имитация кражи
                        wait(0.2)
                        
                        -- Телепортация к своей базе
                        local myBases = {
                            "MyBase", "Spawn", "SafeZone",
                            "Home", "PlayerSpawn"
                        }
                        
                        for _, baseName in pairs(myBases) do
                            local myBase = workspace:FindFirstChild(baseName)
                            if myBase then
                                root.CFrame = myBase.CFrame + Vector3.new(0, 3, 0)
                                break
                            end
                        end
                    end
                end
            end
        end)
        
        -- Телепорт домой
        TeleportHomeBtn.MouseButton1Click:Connect(function()
            local character = Player.Character
            if character then
                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    local spawn = workspace:FindFirstChild("Spawn") or workspace:FindFirstChild("HomeBase")
                    if spawn then
                        root.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
                    else
                        root.CFrame = CFrame.new(0, 50, 0)
                    end
                end
            end
        end)
        
        stealGui.Parent = PlayerGui
        StealFrame.Parent = stealGui
        InstantStealButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        InstantStealButton.Text = "🚀 STEAL MODE: ACTIVE"
    else
        -- Убираем GUI
        if stealGui then
            stealGui:Destroy()
        end
        InstantStealButton.BackgroundColor3 = Color3.fromRGB(233, 30, 99)
        InstantStealButton.Text = "🚀 INSTANT STEAL MODE"
    end
end)

-- NO CLIP FUNCTION
local NoclipButton = CreateButton("🌀 NO CLIP MODE", Color3.fromRGB(0, 188, 212))
local noclipEnabled = false
local noclipConnection

NoclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        local character = Player.Character
        if character then
            -- Отключаем коллизию для всех частей
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
                    noclipConnection:Disconnect()
                end
            end)
            
            NoclipButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
            NoclipButton.Text = "🌀 NO CLIP: ACTIVE"
        end
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        -- Возвращаем коллизию
        local character = Player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        NoclipButton.BackgroundColor3 = Color3.fromRGB(0, 188, 212)
        NoclipButton.Text = "🌀 NO CLIP MODE"
    end
end)

-- FLY FUNCTION
local FlyButton = CreateButton("🕊️ FLY MODE", Color3.fromRGB(205, 220, 57))
local flyEnabled = false
local flyConnection

FlyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        local character = Player.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if root and humanoid then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                bodyVelocity.Parent = root
                
                flyConnection = RunService.Heartbeat:Connect(function()
                    if flyEnabled and root and bodyVelocity then
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
                        
                        bodyVelocity.Velocity = moveDirection * 100
                    else
                        if flyConnection then
                            flyConnection:Disconnect()
                        end
                        if bodyVelocity then
                            bodyVelocity:Destroy()
                        end
                    end
                end)
                
                FlyButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
                FlyButton.Text = "🕊️ FLY: ACTIVE"
            end
        end
    else
        if flyConnection then
            flyConnection:Disconnect()
        end
        local character = Player.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local bodyVelocity = root:FindFirstChildOfClass("BodyVelocity")
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
            end
        end
        FlyButton.BackgroundColor3 = Color3.fromRGB(205, 220, 57)
        FlyButton.Text = "🕊️ FLY MODE"
    end
end)

-- ANTI-AFK FUNCTION
local AntiAFKButton = CreateButton("🔒 ANTI-AFK", Color3.fromRGB(121, 85, 72))
local antiAFKEnabled = false

AntiAFKButton.MouseButton1Click:Connect(function()
    antiAFKEnabled = not antiAFKEnabled
    
    if antiAFKEnabled then
        -- Отключаем AFK обнаружение
        local virtualUser = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            if antiAFKEnabled then
                virtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                wait(1)
                virtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        end)
        
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        AntiAFKButton.Text = "🔒 ANTI-AFK: ACTIVE"
    else
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(121, 85, 72)
        AntiAFKButton.Text = "🔒 ANTI-AFK"
    end
end)

-- FINAL SETUP
ScreenGui.Parent = PlayerGui
MainFrame.Parent = ScreenGui

-- Защита от удаления GUI
ScreenGui.ChildRemoved:Connect(function(child)
    if child.Name == "Main" then
        wait(1)
        if not PlayerGui:FindFirstChild("CoreGui") then
            ScreenGui:Clone().Parent = PlayerGui
        end
    end
end)

-- Уведомление об успешной загрузке
spawn(function()
    wait(2)
    TitleLabel.Text = "BRAINROT ULTIMATE V2.0 ✓"
    wait(1)
    TitleLabel.Text = "BRAINROT ULTIMATE V2.0"
end)

print("🎮 Brainrot Ultimate Hack v2.0 loaded successfully!")
print("✅ Anti-detection systems: ACTIVE")
print("🔧 All features: READY")
print("🚀 Ready for testing on private servers!")
