local inDialog = false
local showUI = false
local npcCoords = vector3(-304.53372192383, -836.50024414062, 31.673746109009)
local npcPed = nil


Citizen.CreateThread(function()
    local model = GetHashKey("a_m_m_business_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    npcPed = CreatePed(4, model, npcCoords.x, npcCoords.y, npcCoords.z - 1.0, 90.0, false, true)
    SetEntityInvincible(npcPed, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    FreezeEntityPosition(npcPed, true)
    exports['esx_npcnames']:addNametag( npcPed, "Nagy Zoltán [Kalauz]" )
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local dist = #(coords - npcCoords)

        if dist < 2.0 and not inDialog then
            DrawInteractionBox("Nyomd meg az ~g~[E]~s~ gombot a beszélgetéshez")

            if IsControlJustReleased(0, 38) then
                SetNuiFocus(true, true)
                SendNUIMessage({ action = "openDialog" })
                inDialog = true
            end
        end
    end
end)


RegisterNUICallback("selectOption", function(data, cb)
    local choice = data.option

    if choice == "1" then
        TriggerEvent("chat:addMessage", { args = { "Kis Zoltán mondja:", "Üdvözöllek a városban! Ha bármi kérdésed van, a környéken megtalálsz!" } })
    elseif choice == "2" then
        TriggerEvent("chat:addMessage", { args = { "Kis Zoltán mondja:", "Munkát a ^2városházán^7 tudsz felvenni. ((lila blip a térképen))" } })
    elseif choice == "3" then 
         TriggerEvent("chat:addMessage", { args = { "Kis Zoltán mondja:", "A szerver szabályzatát a ^2www.szerver.hu^7 oldalon találod!" } })
    elseif choice == "4" then 
        TriggerEvent("chat:addMessage", { args = { "Kis Zoltán mondja:", "Viszlát!" } })
    end

    SetNuiFocus(false, false)
    inDialog = false
    cb('ok')
end)

RegisterNUICallback("closeUI", function(data, cb)
    SetNuiFocus(false, false)
    inDialog = false
    cb('ok')
end)

function DrawInteractionBox(text)
    local boxWidth = 0.32
    local boxHeight = 0.05
    local x = 0.5
    local y = 0.93

    DrawRect(x, y + 0.015, boxWidth, boxHeight, 35, 35, 35, 200)

    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.4, 0.4)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
