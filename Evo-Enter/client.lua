ESX = exports["es_extended"]:getSharedObject()

AddEventHandler('playerSpawned', function()
    SpawnEnter()
end)

local isEnter = false
local display = false

function SpawnEnter()
    local playerPed = PlayerPedId()
    isEnter = true
	DisplayRadar(false)
    SetEntityVisible(playerPed, false, false)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    SetFocusEntity(playerPed)
    DoScreenFadeIn(500)
    introcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamActive(introcam, true)
    SetFocusArea(-648.680, -155.785, 269.57, 0.0, 0.0, 0.0)
    SetCamParams(introcam, -648.680, -155.785, 269.57, 0, 0.0, 221.74, 82.2442, 0, 1, 1, 2) 
    ShakeCam(introcam, "HAND_SHAKE", 0.50)
    RenderScriptCams(true, false, 3000, 1, 1)
	TriggerScreenblurFadeIn(0)
    SetDisplay(true)
end

RegisterNUICallback("exit", function(data)
    if isEnter == true then
        SetDisplay(false)
        local playerPed = PlayerPedId()
        ESX.ShowNotification("~b~Vous avez validé votre entrée.", "#4287f5")
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        DoScreenFadeOut(0)
        SetEntityVisible(playerPed, true, false)
        FreezeEntityPosition(playerPed, false)
        RenderScriptCams(0, 0, 1, 1, 1)
        ClearTimecycleModifier("scanline_cam_cheap")
        SetFocusEntity(playerPed)
        DoScreenFadeIn(1500)
        DisplayRadar(true)
        TriggerScreenblurFadeOut(0)
        isEnter = false
    else
        return
    end
end)

function SetDisplay(bool)
    display = bool
    Wait(100)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterCommand("testenter", function()
    SpawnEnter()
end)