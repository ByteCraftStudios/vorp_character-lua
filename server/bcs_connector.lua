bcs_Spawn = {}

AddEventHandler("bcs_connector:customSpawn", function(source)
    TriggerClientEvent("bcs_customSpawn:loadSpawnSelect", source)
end)

RegisterServerEvent("bcs_customSpawn:connector")
AddEventHandler("bcs_customSpawn:connector", function(spawnCoords)
    bcs_Spawn = spawnCoords
end)