local playtime = 0

CreateThread(function()
    while true do
        playtime = playtime + 1
        TriggerServerEvent('log:server:playtime', playtime)
        Citizen.Wait(60000)
    end
end)