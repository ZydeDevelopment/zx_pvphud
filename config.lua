Config = {}

-- General Settings
Config.UpdateInterval = 200 -- Update interval in milliseconds (200ms = 5 times per second)
Config.ShowHUD = true -- Show HUD by default
Config.DisableDefaultHUD = true -- Disable GTA default health/armor HUD

-- HUD Position (you can modify these in CSS if needed)
Config.HUDPosition = {
    top = '20px',
    left = '20px'
}

-- Framework Settings
Config.Framework = 'auto' -- 'auto', 'esx', 'qb', or 'standalone'

-- Notifications
Config.Notifications = {
    enabled = true,
    hudToggle = true -- Show notification when toggling HUD
}

-- Keybinds
Config.Keybinds = {
    toggleHUD = 'F2' -- Key to toggle HUD visibility
}

-- Debug Settings
Config.Debug = false -- Enable debug prints

-- HUD Elements
Config.Elements = {
    health = {
        enabled = true,
        showIcon = true
    },
    armor = {
        enabled = true,
        showIcon = true,
        showSegments = true,
        showValue = true
    }
}

-- Disable these default HUD components
Config.DisableHudComponents = {
    3,  -- SP_HEALTH
    4,  -- SP_ARMOUR
    6,  -- VEHICLE_NAME
    7,  -- AREA_NAME
    8,  -- VEHICLE_CLASS
    9   -- STREET_NAME
}
