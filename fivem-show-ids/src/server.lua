-- Server-side logic for managing player connections and providing player IDs to clients

local players = {}

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local playerId = source
    players[playerId] = playerName
end)

AddEventHandler('playerDropped', function(reason)
    local playerId = source
    players[playerId] = nil
end)

RegisterServerEvent('getPlayerIDs')
AddEventHandler('getPlayerIDs', function()
    local playerIDs = {}
    for id, name in pairs(players) do
        table.insert(playerIDs, {id = id, name = name})
    end
    TriggerClientEvent('displayPlayerIDs', source, playerIDs)
end)