local Core = exports.vorp_core:GetCore()
bcs_Spawn = {}

AddEventHandler("bcs_connector:customSpawn", function(source)
    TriggerClientEvent("bcs_customSpawn:loadSpawnSelect", source)
end)

RegisterServerEvent("bcs_customSpawn:connector")
AddEventHandler("bcs_customSpawn:connector", function(spawnCoords, UseClothingStoreBeforeSpawn)
    local _source = source
    local exitCoords
    if UseClothingStoreBeforeSpawn then
        local clothingStores = ConfigShops.Locations or {}
        local nearestClothingStore, dist
        for _, clothingStore in ipairs(clothingStores) do
            if (clothingStore.TypeOfShop == "clothing") then
                local clothingExitCoords = vector3(
                    clothingStore.SpawnBack.Position.x,
                    clothingStore.SpawnBack.Position.y,
                    clothingStore.SpawnBack.Position.z
                )
                local calculatedDist = #(spawnCoords.position - clothingExitCoords)
                if not dist or calculatedDist < dist then
                    dist = calculatedDist
                    nearestClothingStore = clothingStore
                    exitCoords = clothingExitCoords
                end
            end
        end
        TriggerClientEvent('bcs_customSpawn:PrepareClothingStore', _source, nearestClothingStore)
    end

    SetTimeout(6000, function()
        -- Implement bln_notify https://github.com/blnStudio/bln_notify
    end)

    repeat
        local coords = GetEntityCoords(GetPlayerPed(_source))
        local dist = #(coords - exitCoords)
        Wait(100)
    until dist <= 1.5

    bcs_Spawn[_source] = spawnCoords
end)