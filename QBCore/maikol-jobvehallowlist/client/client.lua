local QBCore = exports['qb-core']:GetCoreObject()

local playerJob = nil
local jobAllowlisted = false

local enteringVehicle = nil

local listening = false

local veh = nil

local function startListening()
    
    listening = true

    Citizen.CreateThread(function()
        while listening == true do 
            enteringVehicle = GetVehiclePedIsEntering(PlayerPedId())
            doorCheck = GetPedUsingVehicleDoor(enteringVehicle,	0)
            if doorCheck == PlayerPedId() then
                vehModel = GetEntityModel(enteringVehicle)
                for a, b in pairs(Config.AllowlistedVehicles) do
                   if GetHashKey(a) == vehModel then
                        veh = a
                        for a, b in pairs(Config.AllowlistedVehicles[veh].jobs) do
                            if b == playerJob then
                                jobAllowlisted = true
                                return
                            end
                        end

                        if jobAllowlisted == false then
                            ClearPedTasksImmediately(PlayerPedId())
                            sendNotification(Lang:t('error.not_allowed'), 1000, "error")     
                        end
                    
                        break
                   end
                end
            end
            Citizen.Wait(250)
        end
    end)

    Citizen.CreateThread(function()
        while listening == true do 
            enteredVehicle = GetVehiclePedIsIn(PlayerPedId())
            seatCheck = GetPedInVehicleSeat(enteredVehicle, -1)
            if seatCheck == PlayerPedId() then
                vehModel = GetEntityModel(enteredVehicle)
                for a, b in pairs(Config.AllowlistedVehicles) do
                   if GetHashKey(a) == vehModel then
                    veh = a
                    for a, b in pairs(Config.AllowlistedVehicles[veh].jobs) do
                        if b == playerJob then
                            jobAllowlisted = true
                            return
                        end
                    end

                    if jobAllowlisted == false then
                        ClearPedTasksImmediately(PlayerPedId())
                        sendNotification(Lang:t('error.not_allowed'), 1000, "error")     
                    end

                    break
                    
                   end
                end
            end
            Citizen.Wait(500)
        end
    end)

end


local function setupClient()

    playerJob = QBCore.Functions.GetPlayerData().job.name

    listening = false

    jobAllowlisted = false
    
    Citizen.Wait(500)

    startListening()


end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    setupClient()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function()
    setupClient()
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
      setupClient()
    end
end)
