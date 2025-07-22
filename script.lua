local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local MemoryChecker = game:GetService("MemoryCheckerService")

-- ОБХОД АНТИЧИТОВ
do
    -- Обход Byfron
    if not hookmetamethod then
        getgenv().hookmetamethod = function() end
    end
    
    local __namecall
    __namecall = hookmetamethod(game, "__namecall", function(self, ...)
        if getnamecallmethod() == "FireServer" and tostring(self) == "MemoryChecker" then
            return nil
        end
        return __namecall(self, ...)
    end)

    -- Обход детекции скриптов
    for _, v in next, getgc() do
        if type(v) == "function" and getfenv(v).script == Players.LocalPlayer.PlayerScripts.Client then
            hookfunction(v, function() 
                return true 
            end)
        end
    end

    -- Анти-лаг система
    RunService.Stepped:Connect(function()
        if Players.LocalPlayer.Character then
            for _, part in pairs(Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- ФУНКЦИИ
local function InstantSteal()
    local Player = Players.LocalPlayer
    local Base = workspace:FindFirstChild(Player.Name.."Base")
    local Brainrot = workspace.Brainrots:FindFirstChild(Player.Name.."Brainrot")
    
    if Base and Brainrot then
        Brainrot:PivotTo(Base:GetPivot())
        Player.Character:PivotTo(Base:GetPivot() * CFrame.new(0, 5, 0))
    end
end

local function FindBestBrainrot()
    local highestValue = 0
    local targetBrainrot = nil
    
    for _, brainrot in ipairs(workspace.Brainrots:GetChildren()) do
        local value = brainrot:GetAttribute("ValuePerSecond") or brainrot:FindFirstChild("Value") and brainrot.Value.Value or 0
        if value > highestValue then
            highestValue = value
            targetBrainrot = brainrot
        end
    end
    return targetBrainrot
end

local function TPToBest()
    local target = FindBestBrainrot()
    if target and Players.LocalPlayer.Character then
        Players.LocalPlayer.Character:PivotTo(target:GetPivot() * CFrame.new(0, 3, 0))
    end
end

-- ИНТЕРФЕЙС
local Window = Rayfield:CreateWindow({
    Name = "Brainrot Ultimate",
    LoadingTitle = "Steal a Brainrot Private Cheat",
    LoadingSubtitle = "v3.7 | By superuser",
    ConfigurationSaving = { Enabled = false },
})

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateButton({
    Name = "Instant Steal",
    Callback = InstantSteal
})

MainTab:CreateToggle({
    Name = "Auto TP to Best Value",
    CurrentValue = false,
    Flag = "AutoTP",
    Callback = function(Value)
        getgenv().autoTP = Value
        while autoTP do
            TPToBest()
            task.wait(5)
        end
    end
})

MainTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = function(Value)
        if Value then
            local vu = game:GetService("VirtualUser")
            Players.LocalPlayer.Idled:connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

-- ДОПОЛНИТЕЛЬНАЯ ЗАЩИТА
task.spawn(function()
    while task.wait(10) do
        pcall(function()
            -- Очистка следов в памяти
            for i = 1, 10 do
                collectgarbage("collect")
            end
            
            -- Ложные вызовы античита
            MemoryChecker:FireServer("Heartbeat")
        end)
    end
end)

-- АВТО-ОБНОВЛЕНИЕ
if not getgenv().Executed then
    getgenv().Executed = true
    Rayfield:Notify({
        Title = "Cheat Loaded",
        Content = "Press F to toggle UI",
        Duration = 3,
        Image = 4483362458
    })
end
