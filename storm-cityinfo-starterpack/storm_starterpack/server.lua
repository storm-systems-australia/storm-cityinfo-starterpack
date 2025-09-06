local QBCore = exports['qb-core']:GetCoreObject()
local Config = {
    Framework = 'QBCore', -- or 'ESX'
    StarterItems = {
        {name = "redbull", amount = 10},
        {name = "burger", amount = 10},
    },
    StarterMoney = 5000 -- cash to give
}

-- Table to track players currently claiming
local claimingPlayers = {}

-- Check if player has already claimed starter pack
lib.callback.register('starterpack:check', function(source, cb)
    local xPlayer = Config.Framework == 'QBCore' and QBCore.Functions.GetPlayer(source) or ESX.GetPlayerFromId(source)
    if not xPlayer then cb(false) return end

    local identifier = xPlayer.PlayerData.license or xPlayer.identifier or xPlayer.getIdentifier()
    exports.oxmysql:scalar('SELECT id FROM starter_pack_claims WHERE identifier = ?', {identifier}, function(result)
        cb(result ~= nil)
    end)
end)

-- Give starter pack
RegisterNetEvent('starterpack:claim', function()
    local src = source

    -- Anti-spam: if player is already claiming, kick them
    if claimingPlayers[src] then
        DropPlayer(src, "Kicked for spamming the starter pack claim.")
        return
    end

    claimingPlayers[src] = true -- lock player

    local xPlayer = Config.Framework == 'QBCore' and QBCore.Functions.GetPlayer(src) or ESX.GetPlayerFromId(src)
    if not xPlayer then
        claimingPlayers[src] = nil
        return
    end

    local identifier = xPlayer.PlayerData.license or xPlayer.identifier or xPlayer.getIdentifier()

    exports.oxmysql:scalar('SELECT id FROM starter_pack_claims WHERE identifier = ?', {identifier}, function(result)
        if result then
            TriggerClientEvent('starterpack:alreadyClaimed', src)
            claimingPlayers[src] = nil -- unlock
            return
        end

        -- Give items
        if Config.Framework == 'QBCore' then
            for _, item in ipairs(Config.StarterItems) do
                xPlayer.Functions.AddItem(item.name, item.amount)
            end
            xPlayer.Functions.AddMoney('cash', Config.StarterMoney)
        else -- ESX
            for _, item in ipairs(Config.StarterItems) do
                xPlayer.addInventoryItem(item.name, item.amount)
            end
            xPlayer.addMoney(Config.StarterMoney)
        end

        -- Mark as claimed
        exports.oxmysql:insert('INSERT INTO starter_pack_claims (identifier) VALUES (?)', {identifier}, function(id)
            if id then
                TriggerClientEvent('starterpack:claimed', src)
            end
            claimingPlayers[src] = nil -- unlock after completion
        end)
    end)
end)
