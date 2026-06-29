-- // Unnamed Encracked | Linoria UI + Features Mejorados
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = 'Unnamed Encracked',
    Center = true,
    AutoShow = true,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- ==================== TABS ====================
local Combat = Window:AddTab('Combat')
local Visuals = Window:AddTab('Visuals')
local Misc = Window:AddTab('Misc')

-- Combat
local Rage = Combat:AddLeftGroupbox('RageBot')
Rage:AddToggle('SilentAim', {Text = 'Silent Aim', Default = false})
Rage:AddToggle('Aimbot', {Text = 'Aimbot', Default = false})
Rage:AddToggle('Ragebot', {Text = 'Ragebot', Default = false})
Rage:AddToggle('TriggerBot', {Text = 'TriggerBot', Default = false})

local AimSettings = Combat:AddRightGroupbox('Aim Settings')
AimSettings:AddSlider('FOV', {Text = 'FOV', Default = 120, Min = 10, Max = 800, Rounding = 0})

-- ==================== VISUALS ====================
local ESPGroup = Visuals:AddLeftGroupbox('ESP')

local ESPEnabled = ESPGroup:AddToggle('ESPBoxes', {Text = 'ESP Boxes', Default = false})
ESPGroup:AddToggle('ESPNames', {Text = 'ESP Names', Default = false})
ESPGroup:AddToggle('ESPHealth', {Text = 'ESP Health Bar', Default = false})
ESPGroup:AddToggle('Skeleton', {Text = 'Skeleton', Default = false})
ESPGroup:AddToggle('Tracers', {Text = 'Tracers', Default = false})

-- ==================== MISC ====================
local Movement = Misc:AddLeftGroupbox('Movement')

local FlyToggle = Movement:AddToggle('Fly', {Text = 'Fly', Default = false})
local NoclipToggle = Movement:AddToggle('Noclip', {Text = 'Noclip', Default = false})
local InfJumpToggle = Movement:AddToggle('InfiniteJump', {Text = 'Infinite Jump', Default = false})

Movement:AddSlider('WalkSpeed', {Text = 'WalkSpeed', Default = 16, Min = 16, Max = 250, Rounding = 0})

Misc:AddRightGroupbox('Script'):AddButton({
    Text = 'Unload',
    Func = function() Library:Unload() end
})

-- ==================== FUNCIONES REALES ====================

-- **FLY Mejorado**
local flyBody = nil
FlyToggle:OnChanged(function(state)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    if state then
        flyBody = Instance.new("BodyVelocity")
        flyBody.Name = "FlyVelocity"
        flyBody.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyBody.Velocity = Vector3.new(0,0,0)
        flyBody.Parent = character.HumanoidRootPart
    else
        if flyBody then flyBody:Destroy() end
    end
end)

RunService.RenderStepped:Connect(function()
    if flyBody and flyBody.Parent then
        local camera = workspace.CurrentCamera
        local direction = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction += camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction -= camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction -= camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction += camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction -= Vector3.new(0,1,0) end
        
        flyBody.Velocity = direction.Unit * 60
    end
end)

-- **NOCLIP**
NoclipToggle:OnChanged(function(state)
    if state then
        spawn(function()
            while NoclipToggle.Value do
                local character = LocalPlayer.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
                RunService.Stepped:Wait()
            end
        end)
    end
end)

-- **INFINITE JUMP**
InfJumpToggle:OnChanged(function(state)
    if state then
        UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- **WALKSPEED**
local wsConnection
Movement:GetSlider('WalkSpeed'):OnChanged(function(value)
    if wsConnection then wsConnection:Disconnect() end
    wsConnection = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end)
end)

Library:Notify("Unnamed Encracked cargado correctamente", 6)
print("✅ Unnamed Encracked | Features mejorados")
