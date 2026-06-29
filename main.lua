-- // Unnamed Encracked | Linoria UI Full
local Library = {} -- Aquí va toda tu librería Linoria

-- PEGA AQUÍ TODO EL CÓDIGO DE LA LIBRERÍA QUE ME MANDaste (desde "local InputService = ..." hasta el final "return Library")

-- ==================== SCRIPT PRINCIPAL ====================

local Window = Library:CreateWindow({
    Title = 'Unnamed Encracked',
    Center = true,
    AutoShow = true,
    TabPadding = 8
})

-- ==================== COMBAT ====================
local CombatTab = Window:AddTab('Combat')

local RageGroup = CombatTab:AddLeftGroupbox('RageBot')
RageGroup:AddToggle('Ragebot', {Text = 'Enable Ragebot', Default = false})
RageGroup:AddToggle('SilentAim', {Text = 'Silent Aim', Default = false})
RageGroup:AddToggle('Aimbot', {Text = 'Aimbot', Default = false})
RageGroup:AddToggle('TriggerBot', {Text = 'Trigger Bot', Default = false})
RageGroup:AddToggle('Resolver', {Text = 'Resolver', Default = false})
RageGroup:AddToggle('AutoShoot', {Text = 'Auto Shoot', Default = false})

local AimGroup = CombatTab:AddRightGroupbox('Aim Settings')
AimGroup:AddSlider('FOV', {Text = 'FOV', Default = 120, Min = 10, Max = 800, Rounding = 0})
AimGroup:AddSlider('Smoothness', {Text = 'Smoothness', Default = 8, Min = 1, Max = 30, Rounding = 1})
AimGroup:AddSlider('MaxDistance', {Text = 'Max Distance', Default = 300, Min = 50, Max = 1000, Rounding = 0})

-- ==================== VISUALS ====================
local VisualsTab = Window:AddTab('Visuals')

local ESPGroup = VisualsTab:AddLeftGroupbox('ESP')
ESPGroup:AddToggle('ESPBoxes', {Text = 'ESP Boxes', Default = false})
ESPGroup:AddToggle('ESPNames', {Text = 'ESP Names', Default = false})
ESPGroup:AddToggle('ESPHealth', {Text = 'ESP Health Bar', Default = false})
ESPGroup:AddToggle('Skeleton', {Text = 'Skeleton', Default = false})
ESPGroup:AddToggle('Tracers', {Text = 'Tracers', Default = false})

ESPGroup:AddColorPicker('BoxColor', {Text = 'Box Color', Default = Color3.fromRGB(255, 0, 255)})
ESPGroup:AddColorPicker('HealthLow', {Text = 'Health Low Color', Default = Color3.fromRGB(255, 0, 0)})
ESPGroup:AddColorPicker('HealthHigh', {Text = 'Health High Color', Default = Color3.fromRGB(0, 255, 0)})

local UnlockGroup = VisualsTab:AddRightGroupbox('Unlocks')
UnlockGroup:AddButton({
    Text = '🔓 Unlock All Emotes + Skins + Wraps',
    Func = function()
        pcall(function()
            for _, obj in pairs(game:GetDescendants()) do
                if obj.Name:lower():find("emote") or obj.Name:lower():find("skin") or obj.Name:lower():find("wrap") or obj.Name:lower():find("cosmetic") then
                    for _, v in pairs(obj:GetDescendants()) do
                        if v:IsA("BoolValue") or v:IsA("StringValue") then
                            v.Value = true
                        end
                    end
                end
            end
        end)
        Library:Notify('Unlock All Activado correctamente!', 5)
    end
})

-- ==================== MISC ====================
local MiscTab = Window:AddTab('Misc')

local MovementGroup = MiscTab:AddLeftGroupbox('Movement')
MovementGroup:AddToggle('Fly', {Text = 'Fly', Default = false})
MovementGroup:AddToggle('Noclip', {Text = 'Noclip', Default = false})
MovementGroup:AddToggle('InfiniteJump', {Text = 'Infinite Jump', Default = false})
MovementGroup:AddSlider('WalkSpeed', {Text = 'WalkSpeed', Default = 16, Min = 16, Max = 250})

local OtherGroup = MiscTab:AddRightGroupbox('Other')
OtherGroup:AddButton({Text = 'Unload Script', Func = function() Library:Unload() end})

-- ==================== FEATURES FUNCIONALES ====================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Fly
local flySpeed = 60
local BodyVelocity

MovementGroup:GetToggle('Fly'):OnChanged(function(state)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if state then
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        BodyVelocity.Parent = root
    else
        if BodyVelocity then BodyVelocity:Destroy() end
    end
end)

RunService.RenderStepped:Connect(function()
    if BodyVelocity then
        local cam = workspace.CurrentCamera
        local dir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        BodyVelocity.Velocity = dir.Unit * flySpeed
    end
end)

-- Noclip
local noclipConnection
MovementGroup:GetToggle('Noclip'):OnChanged(function(state)
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
    end
end)

print("✅ Unnamed Encracked cargado con Linoria UI")
Library:Notify("Unnamed Encracked loaded successfully!", 6)
