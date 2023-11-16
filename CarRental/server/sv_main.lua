ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('Hekson:RemoveMoney')
AddEventHandler('Hekson:RemoveMoney', function(target)
    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer.money >= Config.Amound then
        xPlayer.removeMoney(Config.Amound)
    else
        TriggerEvent('esx:showNotification', 'Shoma Pole Kafi Nadarid !')
    end
end)