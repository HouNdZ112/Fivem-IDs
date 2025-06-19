print("Config.KeyToShowIDs:", Config and Config.KeyToShowIDs)
function DrawText3D(x, y, z, text, scale, color)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    if onScreen then
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, Config.KeyToShowIDs) then
            for _, player in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(player)
                local coords = GetEntityCoords(ped)
                local myCoords = GetEntityCoords(PlayerPedId())
                if #(myCoords - coords) < Config.DisplayDistance then
                    DrawText3D(coords.x, coords.y, coords.z + 1.2, tostring(GetPlayerServerId(player)), Config.TextScale, Config.TextColor)
                end
            end
            -- Draw special message above your own head
            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)
            DrawText3D(myCoords.x, myCoords.y, myCoords.z + 1.4, "~ws~PEERS BEHIND CURTAIN~ws~", Config.PeersTextScale, {r=255, g=255, b=255, a=255})
        end
    end
end)