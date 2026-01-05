-- client.lua

local isUiOpen = false

-- ثبت دستور /fbitrack
RegisterCommand('fbitrack', function()
    if not isUiOpen then
        -- درخواست اطلاعات از سرور
        TriggerServerEvent('fbitrack:requestPlayers')
    end
end)

-- دریافت اطلاعات از سرور و باز کردن UI
RegisterNetEvent('fbitrack:receivePlayers')
AddEventHandler('fbitrack:receivePlayers', function(players)
    SetNuiFocus(true, true)
    isUiOpen = true
    
    SendNUIMessage({
        action = 'open',
        players = players
    })
end)

-- کال‌بک برای بستن منو
RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    isUiOpen = false
    cb('ok')
end)

-- کال‌بک برای ردیابی (مارک کردن روی نقشه)
RegisterNUICallback('track', function(data, cb)
    local x = tonumber(data.x)
    local y = tonumber(data.y)
    
    SetNewWaypoint(x, y)
    
    -- نمایش نوتیفیکیشن در بازی
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("~b~[FBI]~w~ Hadaf Roote GPS Moshkhas Shod: " .. data.name)
    EndTextCommandThefeedPostTicker(false, true)
    
    cb('ok')
end)