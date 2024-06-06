local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-rental:rentVehicle')
AddEventHandler('qb-rental:rentVehicle', function(totalPrice, hours, pedCoords, vehicleModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('cash', totalPrice) then
        TriggerClientEvent('qb-rental:startRental', src, pedCoords, vehicleModel)
    else
        if Player.Functions.RemoveMoney('bank', totalPrice) then
            TriggerClientEvent('qb-rental:startRental', src, pedCoords, vehicleModel)
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Texts.notEnoughMoney, "error")
        end
    end
end)

RegisterNetEvent('qb-rental:returnVehicle')
AddEventHandler('qb-rental:returnVehicle', function(duration)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local allowedDuration = rentalDuration / 60000 -- Allowed duration in minutes
    local extraMinutes = duration - allowedDuration
    local extraCharge = 0

    if extraMinutes > 0 then
        extraCharge = extraMinutes * Config.ExtraChargePerMinute
    end

    TriggerClientEvent('qb-rental:endRental', src)

    if extraCharge > 0 then
        if Player.Functions.RemoveMoney('cash', extraCharge) then
            TriggerClientEvent('QBCore:Notify', src, string.format(Config.Texts.extraCharge, extraCharge), "error")
        else
            if Player.Functions.RemoveMoney('bank', extraCharge) then
                TriggerClientEvent('QBCore:Notify', src, string.format(Config.Texts.extraCharge, extraCharge), "error")
            else
                TriggerClientEvent('QBCore:Notify', src, Config.Texts.notEnoughMoney, "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, string.format(Config.Texts.vehicleReturned, duration), "success")
    end
end)
