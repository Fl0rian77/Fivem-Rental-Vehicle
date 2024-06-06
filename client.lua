local QBCore = exports['qb-core']:GetCoreObject()
local renting = false
local rentStartTime = 0
local rentedVehicle = nil
local rentalDuration = 0

CreateThread(function()
    for _, pedData in ipairs(Config.Peds) do
        local pedHash = Config.PedHash
        RequestModel(pedHash)
        while not HasModelLoaded(pedHash) do
            Wait(1)
        end
        local ped = CreatePed(4, pedHash, pedData.coords.x, pedData.coords.y, pedData.coords.z, pedData.coords.w, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        exports.ox_target:addLocalEntity(ped, {
            {
                label = Config.Texts.rentVehicle,
                onSelect = function()
                    if not renting then
                        OpenRentalMenu(pedData.coords)
                    else
                        lib.notify({type = 'error', description = Config.Texts.noVehicleToReturn})
                    end
                end
            },
            {
                label = Cofnig.Texts.returnVehicle,
                onSelect = function()
                    ReturnRental(pedData.coords)
                end
            }
        })
    end

    for _, blipData in ipairs(Config.Blips) do
        local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
        SetBlipSprite(blip, blipData.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, blipData.scale)
        SetBlipColour(blip, blipData.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipData.name)
        EndTextCommandSetBlipName(blip)
    end
end)

function OpenRentalMenu(pedCoords)
    local hoursInput = lib.inputDialog(Config.Texts.rentalMenuTitle, {
        {type = 'number', label = Config.Texts.rentalMenuPrompt, min = 1}
    })

    if not hoursInput then return end
    local hours = tonumber(hoursInput[1])
    if not hours or hours <= 0 then
        lib.notify({type = 'error', description = Config.Texts.invalidHours})
        return
    end

    local vehicleOptions = {}
    for _, vehicle in ipairs(Config.Vehicles) do
        table.insert(vehicleOptions, {
            label = vehicle.label,
            value = vehicle.model
        })
    end

    local vehicleInput = lib.inputDialog(Config.Texts.chooseVehicle, {
        {type = 'select', label = Config.Texts.chooseVehicle, options = vehicleOptions}
    })
    if not vehicleInput then return end
    local selectedVehicleModel = vehicleInput[1]

    local totalPrice = hours * Config.RentalPricePerHour
    rentalDuration = hours * 3600000
    TriggerServerEvent('qb-rental:rentVehicle', totalPrice, hours, pedCoords, selectedVehicleModel)
end

function ReturnRental(pedCoords)
    if renting then
        local duration = (GetGameTimer() - rentStartTime) / 60000
        TriggerServerEvent('qb-rental:returnVehicle', duration)
    else
        lib.notify({type = 'error', description = Config.Texts.noVehicleToReturn})
    end
end

RegisterNetEvent('qb-rental:startRental')
AddEventHandler('qb-rental:startRental', function(pedCoords, vehicleModel)
    renting = true
    rentStartTime = GetGameTimer()
    local playerPed = PlayerPedId()
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(1)
    end
    local vehicle = CreateVehicle(vehicleModel, pedCoords.x, pedCoords.y, pedCoords.z, pedCoords.w, true, false)
    SetVehicleNumberPlateText(vehicle, Config.VehiclePlate)
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    SetModelAsNoLongerNeeded(vehicleModel)
    rentedVehicle = vehicle
    CreateThread(function()
        Wait(rentalDuration)
        if renting then
            PlaySoundFrontend(-1, Config.Sounds.rentalExpiredSound, Config.Sounds.rentalExpired, true)
            lib.notify({type = 'error', description = Config.Texts.rentalExpired})
            Wait(5000)
            if DoesEntityExist(rentedVehicle) then
                DeleteVehicle(rentedVehicle)
            end
            renting = false
            rentedVehicle = nil
        end
    end)
end)

RegisterNetEvent('qb-rental:endRental')
AddEventHandler('qb-rental:endRental', function()
    if DoesEntityExist(rentedVehicle) then
        DeleteVehicle(rentedVehicle)
    end
    renting = false
    rentedVehicle = nil
end)

RegisterNetEvent('qb-rental:notify')
AddEventHandler('qb-rental:notify', function(type, message)
    lib.notify({type = type, description = message})
end)
