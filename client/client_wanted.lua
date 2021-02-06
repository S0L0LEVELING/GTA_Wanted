config.setLanguage(tostring(Config.language))
local isDisplayOn = false


RegisterNetEvent("GTA_Prediction:UpdateDisplayFormulaire")
AddEventHandler("GTA_Prediction:UpdateDisplayFormulaire", function(bool)
    isDisplayOn = bool
    SetNuiFocus(isDisplayOn, isDisplayOn)

    SendNUIMessage({
        type = "enableui",
        activate = isDisplayOn
    })
end)

RegisterNetEvent("GTA_Prediction:ShowWanted")
AddEventHandler("GTA_Prediction:ShowWanted", function(fName, lName, reason)
    TriggerServerEvent('InteractSound_SV:PlayOnAll', 'wanted', 0.2)

    SendNUIMessage({
        type = "wantedAnnouce",
        activate = true,
        firstName = fName,
        lastName = lName,
        dataReason = reason
    })

    --> Timer to show the announce :
    Wait(Config.TimerAnnounce)
    
    SendNUIMessage({
        type = "wantedAnnouce",
        activate = false,
        firstName = fName,
        lastName = lName,
        dataReason = reason
    })
end)

--> Command Warn : 
RegisterCommand("warn", function(source)
    TriggerServerEvent('GTA_Prediction:ValueFormulaireWanted', true)
    TriggerServerEvent('GTA_Prediction:OpenFormulaire')
    TriggerServerEvent("InteractSound_SV:PlayOnSource", 'click', 0.2)
end, false)

--> CallBack Main from NUI : used to show the wanted announce.
RegisterNUICallback("main", function(data)
    local fName = data.fName
    local lName = data.lName
    local reason = data.vreason
    TriggerServerEvent('GTA_Prediction:ValueFormulaireWanted', false)
    TriggerServerEvent('GTA_Prediction:RequestShowWanted', fName, lName, reason)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", 'click', 0.2)
end)

--> CallBack Error from NUI : used to exit the nui + show the data error.
RegisterNUICallback("error", function(data)
    print("NUI WANTED ERROR : ", data.error)
    TriggerServerEvent('GTA_Prediction:ValueFormulaireWanted', false)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", 'click', 0.2)
end)

--> CallBack Exit from NUI : used to exit the nui without error.
RegisterNUICallback("exit", function(data)
    --print("NUI WANTED EXITED")
    TriggerServerEvent('GTA_Prediction:ValueFormulaireWanted', false)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", 'click', 0.2)
end)



-------------------------------> ONLY EXECUTED WHEN THE FORM IS OPEN :
Citizen.CreateThread(function()
    while isDisplayOn do
        Citizen.Wait(0)
        DisableControlAction(0, 1, isDisplayOn) -- LookLeftRight
        DisableControlAction(0, 29, isDisplayOn) -- POINTING TOUCH B
        DisableControlAction(0, 2, isDisplayOn) -- LookUpDown
        DisableControlAction(0, 142, isDisplayOn) -- MeleeAttackAlternate
        DisableControlAction(0, 18, isDisplayOn) -- Enter
        DisableControlAction(0, 322, isDisplayOn) -- ESC
        DisableControlAction(0, 106, isDisplayOn) -- VehicleMouseControlOverride
    end
end)