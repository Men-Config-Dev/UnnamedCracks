-- // Unnamed Encracked | Linoria UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = 'Unnamed Encracked',
    Center = true,
    AutoShow = true,
})

-- Tabs
local Combat = Window:AddTab('Combat')
local Visuals = Window:AddTab('Visuals')
local Misc = Window:AddTab('Misc')

-- Combat
local Rage = Combat:AddLeftGroupbox('RageBot')
Rage:AddToggle('SilentAim', {Text = 'Silent Aim', Default = false})
Rage:AddToggle('Aimbot', {Text = 'Aimbot', Default = false})
Rage:AddToggle('Ragebot', {Text = 'Ragebot', Default = false})
Rage:AddToggle('TriggerBot', {Text = 'TriggerBot', Default = false})
Rage:AddToggle('Resolver', {Text = 'Resolver', Default = false})

local AimSettings = Combat:AddRightGroupbox('Aim Settings')
AimSettings:AddSlider('FOV', {Text = 'FOV', Default = 120, Min = 10, Max = 800, Rounding = 0})
AimSettings:AddSlider('Smoothness', {Text = 'Smoothness', Default = 8, Min = 1, Max = 30, Rounding = 1})

-- Visuals
local ESPGroup = Visuals:AddLeftGroupbox('ESP')
ESPGroup:AddToggle('ESPBoxes', {Text = 'ESP Boxes', Default = false})
ESPGroup:AddToggle('ESPNames', {Text = 'ESP Names', Default = false})
ESPGroup:AddToggle('ESPHealth', {Text = 'ESP Health Bar', Default = false})
ESPGroup:AddToggle('Skeleton', {Text = 'Skeleton', Default = false})
ESPGroup:AddToggle('Tracers', {Text = 'Tracers', Default = false})

local UnlockGroup = Visuals:AddRightGroupbox('Unlocks')
UnlockGroup:AddButton({
    Text = ' Unlock All Emotes + Skins + Wraps',
    Func = function()
        Library:Notify('Unlock All Activado!', 5)
        -- Unlock básico
        for _, v in pairs(game:GetDescendants()) do
            if v.Name:lower():find("emote") or v.Name:lower():find("skin") or v.Name:lower():find("wrap") then
                for _, child in pairs(v:GetDescendants()) do
                    if child:IsA("BoolValue") then child.Value = true end
                end
            end
        end
    end
})

-- Misc
local Movement = Misc:AddLeftGroupbox('Movement')
Movement:AddToggle('Fly', {Text = 'Fly', Default = false})
Movement:AddToggle('Noclip', {Text = 'Noclip', Default = false})
Movement:AddToggle('InfiniteJump', {Text = 'Infinite Jump', Default = false})

Misc:AddRightGroupbox('Script'):AddButton({
    Text = 'Unload',
    Func = function() Library:Unload() end
})

Library:Notify("Unnamed Encracked cargado correctamente", 6)
print(" Unnamed Encracked | Linoria UI")
