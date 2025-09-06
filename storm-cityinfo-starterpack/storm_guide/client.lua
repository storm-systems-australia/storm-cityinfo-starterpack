
local pedModel = `cs_bankman` -- Change ped model here
local pedCoords = vector3(-540.10, -218.94, 37.65 -1) -- Ped location
local pedHeading = 3

CreateThread(function()
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(0) end


    local groundZ = pedCoords.z
    local found, z = GetGroundZFor_3dCoord(pedCoords.x, pedCoords.y, pedCoords.z, false)
    if found then groundZ = z end

    local ped = CreatePed(0, pedModel, pedCoords.x, pedCoords.y, groundZ, pedHeading, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, false)

    local blip = AddBlipForCoord(pedCoords.x, pedCoords.y, groundZ)
    SetBlipSprite(blip, 280)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("City Info & Starter Pack")
    EndTextCommandSetBlipName(blip)

  
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'city_info',
            icon = 'fa-solid fa-circle-info',
            label = 'Ask about the City / Starter Pack',
            onSelect = function()
                lib.registerContext({
                    id = 'city_info_menu',
                    title = 'Welcome to Storm Systems',
                    options = {
                        {
                            title = 'Jobs',
                            description = 'Learn about legal and illegal jobs',
                            event = 'cityinfo:jobs'
                        },
                        {
                            title = 'Police & EMS',
                            description = 'How emergency services work here',
                            event = 'cityinfo:services'
                        },
                        {
                            title = 'Businesses',
                            description = 'Shops, restaurants, mechanics and more',
                            event = 'cityinfo:business'
                        },
                        {
                            title = 'Activities',
                            description = 'Racing, clubs, fishing, hunting and more',
                            event = 'cityinfo:activities'
                        },
                        {
                            title = 'Claim Starter Pack',
                            description = 'Get your one-time starter pack',
                            event = 'starterpack:claimMenu'
                        },
                    }
                })
                lib.showContext('city_info_menu')
            end
        }
    })
end)

RegisterNetEvent('cityinfo:jobs', function()
    lib.alertDialog({
        header = 'Jobs in Storm Systems',
        content = [[
- Legal jobs: Police, EMS, Mechanic, Transit, Window Cleaning, Trucking, Mining, Fishing
- Illegal jobs: Drugs, Robberies, Boosting, Heists]],
        centered = true,
        cancel = false
    })
end)

RegisterNetEvent('cityinfo:services', function()
    lib.alertDialog({
        header = 'Emergency Services',
        content = [[
- Melbourne Police: Protect & enforce law
- Ambulance Melbourne: Save lives
- Both are fully player-run, apply in the city!]],
        centered = true,
        cancel = false
    })
end)

RegisterNetEvent('cityinfo:business', function()
    lib.alertDialog({
        header = 'Businesses',
        content = [[
- Mechanic shops, Dealerships, Gas Stations
- Run by players, jobs always hiring
- You can start your own business too!]],
        centered = true,
        cancel = false
    })
end)

RegisterNetEvent('cityinfo:activities', function()
    lib.alertDialog({
        header = 'Things to Do',
        content = [[
- Car Meets, Street Racing, Hunting
- Diving & Treasure Hunts
- Social Clubs, Gangs, Events & more]],
        centered = true,
        cancel = false
    })
end)

-- Starter Pack Menu
RegisterNetEvent('starterpack:claimMenu', function()
    local hasClaimed = lib.callback.await('starterpack:check', false)
    if hasClaimed then
        lib.notify({title = "Starter Pack", description = "You have already claimed your starter pack!", type = "error"})
        return
    end

    TriggerServerEvent('starterpack:claim')
end)

-- Notifications
RegisterNetEvent('starterpack:claimed', function()
    lib.notify({title = "Starter Pack", description = "You have successfully claimed your starter pack!", type = "success"})
end)

RegisterNetEvent('starterpack:alreadyClaimed', function()
    lib.notify({title = "Starter Pack", description = "You have already claimed your starter pack!", type = "error"})
end)

