-- // Unnamed Encracked | Linoria UI + Features
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2Swiftz/UI-Library/refs/heads/main/Libraries/Pepsi%20-%20Example.lua"))() wait() -- O usa el código que pegaste completo

-- Si prefieres usar el que pegaste, reemplaza la línea de arriba por todo el código de Linoria que tienes.

local Window = Library:CreateWindow({
    Title = 'Unnamed Encracked',
    Center = true,
    AutoShow = true,
})

-- ==================== COMBAT ====================
local CombatTab = Window:AddTab('Combat')

local RageSection = CombatTab:AddLeftGroupbox('RageBot')
RageSection:AddToggle('Ragebot', {Text = 'Enable Ragebot', Default = false})
RageSection:AddToggle('SilentAim', {Text = 'Silent Aim', Default = false})
RageSection:AddToggle('Aimbot', {Text = 'Aimbot', Default = false})
RageSection:AddToggle('TriggerBot', {Text = 'TriggerBot', Default = false})
RageSection:AddToggle('Resolver', {Text = 'Resolver', Default = false})
RageSection:AddToggle('AutoShoot', {Text = 'Auto Shoot', Default = false})

local AimSettings = CombatTab:AddRightGroupbox('Aim Settings')
AimSettings:AddSlider('FOV', {Text = 'FOV', Default = 120, Min = 10, Max = 800, Rounding = 0})
AimSettings:AddSlider('Smoothness', {Text = 'Smoothness', Default = 8, Min = 1, Max = 30, Rounding = 1})

-- ==================== VISUALS ====================
local VisualsTab = Window:AddTab('Visuals')

local ESPSection = VisualsTab:AddLeftGroupbox('ESP')
ESPSection:AddToggle('ESPBoxes', {Text = 'ESP Boxes', Default = false})
ESPSection:AddToggle('ESPNames', {Text = 'ESP Names', Default = false})
ESPSection:AddToggle('ESPHealth', {Text = 'ESP Health Bar', Default = false})
ESPSection:AddToggle('Skeleton', {Text = 'Skeleton', Default = false})
ESPSection:AddToggle('Tracers', {Text = 'Tracers', Default = false})

-- Color Picker para Health Bar
ESPSection:AddColorPicker('HealthColorLow', {Text = 'Health Low Color', Default = Color3.fromRGB(255, 0, 0)})
ESPSection:AddColorPicker('HealthColorHigh', {Text = 'Health High Color', Default = Color3.fromRGB(0, 255, 0)})

local UnlockSection = VisualsTab:AddRightGroupbox('Unlocks')
UnlockSection:AddButton({
    Text = ' Unlock All Emotes + Skins + Wraps',
    Func = function()
        pcall(function()
            for _, v in pairs(game:GetDescendants()) do
                if v.Name:find("Emote") or v.Name:find("Skin") or v.Name:find("Wrap") or v.Name:find("Cosmetic") then
                    for _, child in pairs(v:GetDescendants()) do
                        if child:IsA("BoolValue") or child:IsA("StringValue") or child:IsA("NumberValue") then
                            child.Value = true
                        end
                    end
                end
            end
        end)
        Library:Notify('Unlock All Activado!', 4)
    end
})

-- ==================== MISC ====================
local MiscTab = Window:AddTab('Misc')

local Movement = MiscTab:AddLeftGroupbox('Movement')
Movement:AddToggle('Fly', {Text = 'Fly', Default = false})
Movement:AddToggle('Noclip', {Text = 'Noclip', Default = false})
Movement:AddToggle('InfiniteJump', {Text = 'Infinite Jump', Default = false})
Movement:AddSlider('WalkSpeed', {Text = 'WalkSpeed', Default = 16, Min = 16, Max = 200, Rounding = 0})

local Other = MiscTab:AddRightGroupbox('Other')
Other:AddButton({Text = 'Unload Script', Func = function() Library:Unload() end})

-- ==================== FEATURES FUNCIONALES ====================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Fly
local flySpeed = 50
local flying = false
local flyBody = nil

Movement:GetToggle('Fly'):OnChanged(function(state)
    flying = state
    local character = LocalPlayer.Character
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if flying then
        flyBody = Instance.new("BodyVelocity")
        flyBody.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyBody.Velocity = Vector3.new(0,0,0)
        flyBody.Parent = root
    else
        if flyBody then flyBody:Destroy() end
    end
end)

RunService.RenderStepped:Connect(function()
    if flying and flyBody then
        local camera = workspace.CurrentCamera
        local moveDirection = Vector3.new()
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + camera.CFrame.LookVector end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - camera.CFrame.LookVector end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - camera.CFrame.RightVector end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + camera.CFrame.RightVector end
        flyBody.Velocity = moveDirection.Unit * flySpeed
    end
end)

-- Noclip
local noclipping = false
Movement:GetToggle('Noclip'):OnChanged(function(state)
    noclipping = state
end)

RunService.Stepped:Connect(function()
    if noclipping then
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

print(" Unnamed Encracked cargado correctamente | Linoria UI")
Library:Notify("Unnamed Encracked loaded!", 5)
