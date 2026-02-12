local ESX = nil
local QBCore = nil
local Framework = nil

-- Framework Detection
CreateThread(function()
    Wait(1000) -- Wait for other resources to load
    
    -- Try to get ESX
    local esxState = GetResourceState('es_extended')
    if esxState == 'started' or esxState == 'starting' then
        local attempts = 0
        while not ESX and attempts < 50 do
            local success, result = pcall(function()
                return exports['es_extended']:getSharedObject()
            end)
            if success and result then
                ESX = result
            end
            attempts = attempts + 1
            Wait(100)
        end
        if ESX then
            Framework = 'ESX'
        else
            Framework = 'STANDALONE'
        end
    else
        -- Try to get QB-Core
        local qbState = GetResourceState('qb-core')
        if qbState == 'started' or qbState == 'starting' then
            local attempts = 0
            while not QBCore and attempts < 50 do
                local success, result = pcall(function()
                    return exports['qb-core']:GetCoreObject()
                end)
                if success and result then
                    QBCore = result
                end
                attempts = attempts + 1
                Wait(100)
            end
            if QBCore then
                Framework = 'QB'
            else
                Framework = 'STANDALONE'
            end
        else
            Framework = 'STANDALONE'
        end
    end
end)

-- Configuration
local Config = {
    UpdateInterval = 200, -- Update every 200ms
    ShowHUD = true,
    DisableDefaultHUD = true
}

-- Variables
local isHudVisible = true
local currentHealth = 100
local currentArmor = 0

-- Disable default HUD elements
if Config.DisableDefaultHUD then
    CreateThread(function()
        while true do
            Wait(0)
            -- Disable health and armor HUD
            HideHudComponentThisFrame(3)  -- SP_HEALTH
            HideHudComponentThisFrame(4)  -- SP_ARMOUR
            HideHudComponentThisFrame(6)  -- VEHICLE_NAME
            HideHudComponentThisFrame(7)  -- AREA_NAME
            HideHudComponentThisFrame(8)  -- VEHICLE_CLASS
            HideHudComponentThisFrame(9)  -- STREET_NAME
            -- Disable minimap
            HideHudComponentThisFrame(2)  -- MP_CASH
            DisplayRadar(false) -- Hide minimap completely
        end
    end)
end

-- Get player health
function GetPlayerHealthPercent()
    local health = GetEntityHealth(PlayerPedId())
    local maxHealth = GetEntityMaxHealth(PlayerPedId())
    return math.floor((health / maxHealth) * 100)
end

-- Get player armor
function GetPlayerArmorPercent()
    return GetPedArmour(PlayerPedId())
end

-- Send data to NUI
function UpdateHUD()
    local health = GetPlayerHealthPercent()
    local armor = GetPlayerArmorPercent()
    
    if health ~= currentHealth or armor ~= currentArmor then
        currentHealth = health
        currentArmor = armor
        
        SendNUIMessage({
            action = 'updateHUD',
            health = health,
            armor = armor
        })
    end
end

-- Toggle HUD visibility
function ToggleHUD(show)
    isHudVisible = show
    SendNUIMessage({
        action = 'toggleHUD',
        show = show
    })
end

-- Main HUD loop
CreateThread(function()
    while true do
        if isHudVisible and not IsPlayerDead(PlayerId()) then
            UpdateHUD()
        end
        Wait(Config.UpdateInterval)
    end
end)

-- Handle player death/respawn
CreateThread(function()
    local isDead = false
    
    while true do
        local playerPed = PlayerPedId()
        local health = GetEntityHealth(playerPed)
        
        if health <= 0 and not isDead then
            isDead = true
            ToggleHUD(false)
        elseif health > 0 and isDead then
            isDead = false
            ToggleHUD(true)
        end
        
        Wait(1000)
    end
end)

-- Commands
RegisterCommand('hud', function()
    ToggleHUD(not isHudVisible)
    
    -- Use ox_lib notification
    local success, result = pcall(function()
        return exports.ox_lib:notify({
            title = 'PVP HUD',
            description = isHudVisible and 'HUD zapnut' or 'HUD vypnut',
            type = isHudVisible and 'success' or 'inform',
            duration = 2000
        })
    end)
    
    -- Silent fallback if ox_lib not available
end, false)

-- Events for framework compatibility
if Framework == 'ESX' then
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ToggleHUD(true)
    end)
    
    RegisterNetEvent('esx:onPlayerDeath')
    AddEventHandler('esx:onPlayerDeath', function()
        ToggleHUD(false)
    end)
    
    RegisterNetEvent('esx:onPlayerSpawn')
    AddEventHandler('esx:onPlayerSpawn', function()
        ToggleHUD(true)
    end)
    
elseif Framework == 'QB' then
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        ToggleHUD(true)
    end)
    
    RegisterNetEvent('hospital:client:Revive')
    AddEventHandler('hospital:client:Revive', function()
        ToggleHUD(true)
    end)
    
    RegisterNetEvent('qb-medical:client:playerDied')
    AddEventHandler('qb-medical:client:playerDied', function()
        ToggleHUD(false)
    end)
end

-- Initialize when resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Wait(1000)
        ToggleHUD(true)
    end
end)

-- Cleanup when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        ToggleHUD(false)
    end
end)

-- Reload HUD event
RegisterNetEvent('pvphud:client:reload')
AddEventHandler('pvphud:client:reload', function()
    ToggleHUD(false)
    Wait(100)
    ToggleHUD(true)
end)
