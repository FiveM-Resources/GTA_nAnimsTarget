--||Script made by Super.Cool.Ninja||--
--------------------------------------------------------------------------------------------------
--[[    
                    SOME GOOD LINK:
ANIMS LINK        : https://alexguirre.github.io/animations-list/
TaskPlayAnim link : https://runtime.fivem.net/doc/natives/#_0xEA47FE3719165B94
]]
--------------------------------------------------------------------------------------------------
local isRequestAnim = false

--||Command to send request anim||--
RegisterCommand('hello', function()
    target, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("nServerSendRequest:Anims", GetPlayerServerId(target))
    else
        SimpleNotify("~r~Nobody in front of you.")
    end
end, false)

--||Anims Example||--
RegisterNetEvent("GiveAnims") --> this event is for play anim when the player accept.
AddEventHandler("GiveAnims", function()
    local ped = PlayerPedId()
    local giveAnim = "mp_common" --> Here is your animLib that u want use.
    RequestAnimDict(giveAnim)
    while not HasAnimDictLoaded(giveAnim) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(ped, giveAnim, "givetake1_a", 8.0, 8.0, -1, 50, 0, false, false, false)
    Citizen.Wait(1200)
    ClearPedTasks(ped)
end)

--||Bip notification to accept or refuse anims||--
RegisterNetEvent("nClientSendRequest:Anims") --> This event should be call every time when we need use anim request.
AddEventHandler("nClientSendRequest:Anims", function()
    isRequestAnim = true
    PlaySound(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
    SimpleNotify("~y~ Y ~w~to accept, ~r~L ~w~ to refuse")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        target, distance = GetClosestPlayer()
        if IsControlJustPressed(1, 246) and isRequestAnim then --Y
            if(distance ~= -1 and distance < 3) then
                TriggerServerEvent("nServerValidRequest:Anims", GetPlayerServerId(target))
                isRequestAnim = false
                TriggerServerEvent("nServerValidRequest:Anims", GetPlayerServerId(target))
            else
                SimpleNotify("~r~Nobody in front of you.")
            end
        elseif IsControlJustPressed(1, 182) and isRequestAnim then --L
            SimpleNotify("Animation refused.")
            isRequestAnim = false
        end
    end
end)