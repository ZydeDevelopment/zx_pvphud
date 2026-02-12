-- PVP HUD Server-side Script
-- This file is currently minimal but can be extended for future features

-- Server events for future use
RegisterNetEvent('pvphud:server:updatePlayerData')
AddEventHandler('pvphud:server:updatePlayerData', function(data)
    local src = source
    -- Future server-side logic can be added here
end)

-- Command to reload HUD for all players (admin only)
RegisterCommand('reloadhud', function(source, args, rawCommand)
    if source == 0 then -- Console command
        TriggerClientEvent('pvphud:client:reload', -1)
    else
        -- Add admin check here if needed
        local player = source
        TriggerClientEvent('pvphud:client:reload', player)
    end
end, true)
