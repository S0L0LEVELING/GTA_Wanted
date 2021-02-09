local isDisplayOn = false
local TimerAnnounce = 15000 --> change here the wanted timer as u needed to let open.
local isWantedON = false

--> Used to show the form to the player : 
RegisterNetEvent("GTA_Prediction:UpdateDisplayFormulaire")
AddEventHandler("GTA_Prediction:UpdateDisplayFormulaire", function(bool)
    isDisplayOn = bool
    SetNuiFocus(isDisplayOn, isDisplayOn)

    SendNUIMessage({
        type = "enableui",
        activate = isDisplayOn
    })
end)

--> Used to show the wanted to all the player : 
RegisterNetEvent("GTA_Prediction:ShowWanted")
AddEventHandler("GTA_Prediction:ShowWanted", function(fName, lName, reason, targetID)
    isWantedON = true
    for i = 1, 255, 1 do
        if NetworkIsPlayerActive(i) then
            local me = GetPlayerServerId(i)
            if me == tonumber(targetID) then

                -- Get the ped headshot image.
                local handle = RegisterPedheadshot(GetPlayerPed(i))
                while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
                    Citizen.Wait(0)
                end
                local txd = GetPedheadshotTxdString(handle)

                TriggerServerEvent('InteractSound_SV:PlayOnAll', 'wanted', 0.2) --> play sound.

                --> We show the wanted nui : 
                SendNUIMessage({
                    type = "wantedAnnouce",
                    activate = true,
                    firstName = fName,
                    lastName = lName,
                    dataReason = reason,
                    dataTargetID = targetID
                })
            
                Citizen.CreateThread(function()
                    while isWantedON do
                    Citizen.Wait(0)
                        DrawSprite(txd, txd, 0.610, 0.248, 0.055, 0.120, 0.0, 255, 255, 255, 1000)
                    end
                end)
            
                --> Timer to show the announce :
                Wait(TimerAnnounce)
            
                -- Cleanup after yourself!
                UnregisterPedheadshot(txd)
            
                --> We remove the wanted nui : 
                SendNUIMessage({
                    type = "wantedAnnouce",
                    activate = false,
                    firstName = fName,
                    lastName = lName,
                    dataReason = reason,
                    dataTargetID = targetID
                })
                break
            end
        end
    end
    isWantedON = false
end)

--> Used when the player enter the command warn we request to open the nui form :
RegisterCommand("warn", function(source)
    TriggerServerEvent('GTA_Prediction:ValueFormulaireWanted', true) --> request to show the nui form.
    TriggerServerEvent("InteractSound_SV:PlayOnSource", 'click', 0.2) --> play sound.
end, false)


--> CallBack Main from NUI : used to show the wanted announce.
RegisterNUICallback("main", function(data)
    local fName = data.fName
    local lName = data.lName
    local reason = data.vreason
    local targetID = data.targetId
    TriggerServerEvent('GTA_Prediction:ValueFormulaireWanted', false) --> request to show off the nui form.
    TriggerServerEvent('GTA_Prediction:RequestShowWanted', fName, lName, reason, targetID) --> request to show the nui wanted.
    TriggerServerEvent("InteractSound_SV:PlayOnSource", 'click', 0.2) --> play sound.
end)


--> CallBack Error from NUI : used to exit the nui + show the data error.
RegisterNUICallback("error", function(data)
    print("NUI WANTED ERROR : ", data.error)
    TriggerServerEvent('GTA_Prediction:ValueFormulaireWanted', false) --> request to show off the nui.
    TriggerServerEvent("InteractSound_SV:PlayOnSource", 'click', 0.2) --> play sound.
end)

--> CallBack Exit from NUI : used to exit the nui without error.
RegisterNUICallback("exit", function(data)
    --print("NUI WANTED EXITED")
    TriggerServerEvent('GTA_Prediction:ValueFormulaireWanted', false) --> request to show off the nui.
    TriggerServerEvent("InteractSound_SV:PlayOnSource", 'click', 0.2) --> play sound.
end)