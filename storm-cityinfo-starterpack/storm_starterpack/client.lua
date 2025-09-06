local Config = {
}
CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(100)
    end
    Wait(1000)


    RequestModel(Config.PedModel)
    while not HasModelLoaded(Config.PedModel) do Wait(10) end

    local groundZ = Config.StarterPed.z
    local found, z = GetGroundZFor_3dCoord(Config.StarterPed.x, Config.StarterPed.y, Config.StarterPed.z, false)
    if found then groundZ = z end

    local ped = CreatePed(4, Config.PedModel, Config.StarterPed.x, Config.StarterPed.y, groundZ, Config.StarterPed.w, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, false)


    local blip = AddBlipForCoord(Config.StarterPed.x, Config.StarterPed.y, groundZ)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipScale(blip, Config.Blip.scale)
    SetBlipAsShortRange(false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.name)
    EndTextCommandSetBlipName(blip)
end)



CreateThread(function()
    exports.ox_target:addBoxZone({
        coords = Config.StarterPed,
        size = vector3(1.5, 1.5, 2.0),
        rotation = Config.Heading,
        debug = false,
        options = {
            {
                name = 'starter_pack',
                icon = 'fa-solid fa-gift',
                label = 'Claim Starter Pack',
                onSelect = function()
                    local hasClaimed = lib.callback.await('starterpack:check', false)
                    if hasClaimed then
                        lib.notify({title = "Starter Pack", description = "You have already claimed your starter pack!", type = "error"})
                        return
                    end
                    TriggerServerEvent('starterpack:claim')
                end
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent('starterpack:claimed', function()
    lib.notify({title = "Starter Pack", description = "You have successfully claimed your starter pack!", type = "success"})
end)

RegisterNetEvent('starterpack:alreadyClaimed', function()
    lib.notify({title = "Starter Pack", description = "You have already claimed your starter pack!", type = "error"})
end)

