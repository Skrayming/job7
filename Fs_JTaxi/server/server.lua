TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'taxi', 'alerte taxi', true, true)

TriggerEvent('esx_society:registerSociety', 'taxi', 'taxi', 'society_taxi', 'society_taxi', 'society_taxi', {type = 'public'})

RegisterServerEvent('Ouvre:taxi')
AddEventHandler('Ouvre:taxi', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		-- TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Taxi', '~y~Entreprise', 'Les Taxi sont ~g~disponibles ~s~!', 'CHAR_MICHAEL', 8)
        TriggerClientEvent('okokNotify:Alert', xPlayers[i], "Entreprise Taxi", "Les Taxi sont disponibles !", 5000, 'neutral')
	end
end)


-- Mission 

RegisterNetEvent("taxi:FinishMission")
AddEventHandler("taxi:FinishMission", function(bonus)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "taxi" then
        TriggerEvent("AC:Violations", 24, "Event: taxi:FinishMission job: "..xPlayer.job.name, source)
        return
    end

    local gain = math.random(50,100) + bonus
    xPlayer.addAccountMoney('bank', gain)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxi', function(account)
        if account ~= nil then
            societyAccount = account
            societyAccount.addMoney(gain * 2)
        end
    end)

    -- TriggerClientEvent("esx:showNotification", source, "Vous avez terminé votre mission.\nGain: ~g~"..gain.."€", "CHAR_FLOYD", 5000, "danger")
    TriggerClientEvent('okokNotify:Alert', source, "Taxi", "Vous avez terminé votre mission.\n Gain : "..gain.."€", 8000, 'info')
end)