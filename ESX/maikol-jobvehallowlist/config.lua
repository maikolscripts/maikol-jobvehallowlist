
----- SETUP YOUR NOTIFICATIONS HERE // NO NEED TO TOUCH UNLESS USING A CUSTOM NOTIFICATION SCRIPT
function sendNotification(message, time, type)
    notiType = type

    if notiType == 'success' then

        notiType = 'success' -- VeniceNotifcations = 'check' / Mythic Notify = 'success' / QB-Notify = 'success'

    elseif notiType == 'info' then

        notiType = 'info' -- VeniceNotifcations = 'info' / Mythic Notify = 'inform' 

    elseif notiType == 'error' then

        notiType = 'error' -- change me if needed

    end

    ESX.ShowNotification(message, type, time)

    -- MYTHIC NOTIFY --> exports['mythic_notify']:DoCustomHudText(notiType, message, time)
    -- VENICE NOTIFICATIONS --> exports["Venice-Notification"]:Notify(message, time, notiType) 
end

Config = {}

Config.Locale = 'en'  -- en, es | you may add your own translations at the bottom of this file

Config.SharedObject = 'esx:getSharedObject' -- Do not touch unless you know what you're doing

Config.AllowlistedVehicles = {

    -- You may add as many cars & jobs as you'd like
    --
    -- Example 
    -- ['VEHICLEMODEL'] = {jobs = {'JOBNAME', 'JOBNAME'}},

    ['police'] = {jobs = {'police', 'ems'}},
    ['ambulance'] = {jobs = {'police', 'ems'}},
}

Config.Locales = {
    ['en'] = { -- english
      ["denied"] = 'You\'re not allowed to drive this vehicle!',
    },
    ['es'] = { -- spanish
      ["denied"] = 'No tienes permiso a este vehiculo!',
    }
  }