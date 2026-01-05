-- server.lua
-- این بخش اطلاعات تمام پلیرهای آنلاین را جمع‌آوری می‌کند

RegisterNetEvent('fbitrack:requestPlayers')
AddEventHandler('fbitrack:requestPlayers', function()
    local src = source
    local playersData = {}
    
    -- دریافت لیست تمام پلیرهای متصل
    local players = GetPlayers()

    for _, playerId in ipairs(players) do
        local ped = GetPlayerPed(playerId)
        local coords = GetEntityCoords(ped)
        local name = GetPlayerName(playerId)
        
        table.insert(playersData, {
            id = playerId,
            name = name,
            coords = coords
        })
    end

    -- ارسال اطلاعات به کلاینت درخواست کننده
    TriggerClientEvent('fbitrack:receivePlayers', src, playersData)
end)