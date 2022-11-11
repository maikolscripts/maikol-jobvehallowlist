local ESX = nil

ESX = exports['es_extended']:getSharedObject()
if ESX == nil then   
    TriggerEvent(Config.SharedObject, function(obj) 
        ESX = obj 
    end)
end

local playerJob = nil
local jobAllowlisted = false

local enteringVehicle = nil

local listening = false

local veh = nil

function Lang(translation)
    local lang = Config.Locales[Config.Locale]
    if lang and lang[translation] then
        return lang[translation]
    end
    return translation
end

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
                            sendNotification(Lang('denied'), 1000, "error")     
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
                        sendNotification(Lang('denied'), 1000, "error")     
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

    playerJob = ESX.PlayerData.job.name

    listening = false

    jobAllowlisted = false
    
    Citizen.Wait(500)

    startListening()


end

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
    setupClient()
end)

RegisterNetEvent('esx:onPlayerLogout',function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
    setupClient()
end)

RegisterNetEvent('esx:setJob',function(job)
	ESX.PlayerData.job = job
    setupClient()
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
      setupClient()
    end
end)