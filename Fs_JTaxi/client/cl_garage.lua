Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('', 'Garage')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenMenu6()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 

              RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local playerPed = PlayerPedId()
      
                  if IsPedSittingInAnyVehicle(playerPed) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
            
                    if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                      exports['okokNotify']:Alert("Taxi", "La voiture a été mis en dans le garage", 5000, 'success')
                      ESX.Game.DeleteVehicle(vehicle)
                       
                    else
                      exports['okokNotify']:Alert("Taxi", "Met toi place conducteur, ou sortez de la voiture.", 5000, 'info')
                    end
                  else
                    local vehicle = ESX.Game.GetVehicleInDirection()
            
                    if DoesEntityExist(vehicle) then
                      exports['okokNotify']:Alert("Taxi", "La voiture à été placer dans le garage.", 5000, 'info')
                      ESX.Game.DeleteVehicle(vehicle)
            
                    else
                      exports['okokNotify']:Alert("Taxi", "Aucune voitures autours", 5000, 'error')
                    end
                  end
              end,})

              RageUI.Separator("~y~↓ Véhicules ↓")

                RageUI.Button("Taxi", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                      local model = GetHashKey("taxi")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      SetVehicleExtra(vehicle, 1, 1)
                      local vehicle = CreateVehicle(model, 190.64385986328, 2787.7043457031, 45.617721557617, 273.1569519042969, true, true)
                      RageUI.CloseAll()
                    end
                })

            end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
  {x = 180.30792236328, y = 2793.4157714844, z = 45.655178070068} 
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 5.0 then
            wait = 0
            DrawMarker(22, 180.30497741699, 2793.4145507813, 45.655178070068, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 235, 59, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour ~y~intéragir", 1) 
                if IsControlJustPressed(1,51) then
                  OpenMenu6()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

--- BLIPS ---

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(198.53135681152, 2789.4602050781, 45.655193328857)

    SetBlipSprite (blip, 198) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.9) -- Taille du blip
    SetBlipColour (blip, 5) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Taxi') -- Nom du blip
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
  local hash = GetHashKey("a_m_y_stbla_02")
  while not HasModelLoaded(hash) do
  RequestModel(hash)
  Wait(20)
  end
  ped = CreatePed("PED_TYPE_CIVMALE", "a_m_y_stbla_02", 180.06512451172, 2793.3225097656, 44.655174255371, 268.6457824707031, false, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  FreezeEntityPosition(ped, true)
  SetEntityInvincible(ped, true)
end)
