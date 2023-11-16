ESX = nil
RentalVeh = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Create blips
Citizen.CreateThread(function()
    for k,v in pairs(Config.Rental) do
        if not Config.EnableBlips then return end
        local Coord = v.Spawner;
        local blip = AddBlipForCoord(Coord)
        print(Coord)
        SetBlipSprite (blip, 225)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 81)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Vehicle Rental')
        EndTextCommandSetBlipName(blip)
    end
end)

-------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        for k,v in pairs(Config.Rental) do
            local Coord = v.Spawner
            local coords = GetEntityCoords(PlayerPedId())
            local distance = #(Coord - coords)
            if distance < Config.DrawDistance + 10.0 then
                DrawMarker(36, Coord.x, Coord.y, Coord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                DrawMarker(6, Coord.x, Coord.y, Coord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                if distance < Config.DrawDistance then
                    ESX.ShowHelpNotification('~h~Press ~r~[E]~w~ To Open Car Rental')
                    if IsControlJustReleased(1, 38) then
                        SendNUIMessage({
                            action = "open",
                            SpawnCoords = v.SpawnPoint,
                            HeadingPoint = v.HeadingPoint
                        })
                        SetNuiFocus(true, true)
                        TriggerScreenblurFadeIn(500)
                    end
                end
            end
        end
    end
end)


RegisterNUICallback('createveh', function(data)
    CreateVeh(data.vehname, data.SpawnCoords, data.HeadingPoint)
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(500)
end)

-----------------------------------------------------------------------------------

function CreateVeh(VehName, SpawnCoords, HeadingPoint)
    if ESX.GetPlayerData().money >= Config.Amound then
        if RentalVeh == nil then
            ESX.Game.SpawnVehiclex(GetHashKey(VehName), SpawnCoords, HeadingPoint, function(vehicle)
                RentalVeh = vehicle
                SetVehicleNumberPlateText(RentalVeh, "Rental")
                TaskWarpPedIntoVehicle(PlayerPedId(), RentalVeh, -1)
                ESX.ShowNotification('~h~~r~1~w~ Min ~g~'..Config.Amound..'$~w~ ~r~Remove~w~', 1)
            end)
        else
            ESX.ShowNotification('You Already ~g~Rented~w~ A Car')
        end
    else
        ESX.ShowNotification('~h~You Dont Have ~r~Money~w~ !')
    end
end

Citizen.CreateThread(function()
    local sleep = 1000
    while true do 
        local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        Citizen.Wait(sleep)
        if veh == RentalVeh then
            sleep = 5000
            if ESX.GetPlayerData().money >= Config.Amound then
                TriggerServerEvent('Hekson:RemoveMoney', GetPlayerServerId(PlayerId()))
            else
                DeleteVehicle(RentalVeh)
                RentalVeh = nil
            end
        end
    end
end)