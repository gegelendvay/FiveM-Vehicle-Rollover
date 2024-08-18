local isFlipped = false

local function Notification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage("CHAR_CALL911", "CHAR_CALL911", true, 1, "Warning!", "~r~Vehicle Accident")
    DrawNotification(false, false)
end

CreateThread(function()
    while true do
        Wait(100)
        local player = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(player, false)
        if vehicle ~= 0 then
            if IsEntityUpsidedown(vehicle) and not isFlipped then
                isFlipped = true
                SetVehicleEngineHealth(vehicle, 300)
                SetVehicleUndriveable(vehicle, true)
                Notification("Your vehicle has flipped over!\nThe engine is damaged.")
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
            end

            if not IsEntityUpsidedown(vehicle) and isFlipped then
                isFlipped = false
            end
        else
            isFlipped = false
        end
    end
end)
