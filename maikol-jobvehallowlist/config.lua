
----- SETUP YOUR NOTIFICATIONS HERE 
function sendNotification(message, time, type)
    notiType = type

    if notiType == 'success' then

        notiType = 'success' -- VeniceNotifcations = 'check' / Mythic Notify = 'success' / QB-Notify = 'success'

    elseif notiType == 'info' then

        notiType = 'info' -- VeniceNotifcations = 'info' / Mythic Notify = 'inform' 

    elseif notiType == 'error' then

        notiType = 'error' -- change me if needed

    end

    TriggerEvent('QBCore:Notify', message, notiType) -- Default QB-NOTIFY

    -- MYTHIC NOTIFY --> exports['mythic_notify']:DoCustomHudText(notiType, message, time)
    -- VENICE NOTIFICATIONS --> exports["Venice-Notification"]:Notify(message, time, notiType) 
end

Config = {}

Config.AllowlistedVehicles = {

    -- You may add as many cars & jobs as you'd like
    --
    -- Example 
    -- ['VEHICLEMODEL'] = {jobs = {'JOBNAME', 'JOBNAME'}},

    ['police'] = {jobs = {'police', 'ems'}},
    ['ambulance'] = {jobs = {'police', 'ems'}},
}