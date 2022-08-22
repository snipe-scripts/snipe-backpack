local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("snipe-backpack:client:openBackPack", function(backpackid, size, slots)
    QBCore.Functions.Progressbar("open_backpack", "Opening BackPack", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("inventory:server:OpenInventory", "stash", backpackid, {
            maxweight = size,
            slots = slots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", backpackid)
    end)
end)

RegisterNetEvent("snipe-backpack:client:openStore", function()
    local OpenMenu = {
        {
            header = "Backpack Store",
            isMenuHeader = true
        }, {
            header = "Buy Small BackPack",
            txt = "Price: $"..Config.BackPacks["smallbackpack"].price,
            params = {
                isServer = true,
                event = "snipe-backpack:server:buyBag",
                args = {
                    price = Config.BackPacks["smallbackpack"].price,
                    item = "smallbackpack",
                }
            }
        },
        {
            header = "Buy Medium BackPack",
            txt = "Price: $"..Config.BackPacks["mediumbackpack"].price,
            params = {
                isServer = true,
                event = "snipe-backpack:server:buyBag",
                args = {
                    price = Config.BackPacks["mediumbackpack"].price,
                    item = "mediumbackpack",
                }
            }
        },
        {
            header = "Buy Large BackPack",
            txt = "Price: $"..Config.BackPacks["largebackpack"].price,
            params = {
                isServer = true,
                event = "snipe-backpack:server:buyBag",
                args = {
                    price = Config.BackPacks["largebackpack"].price,
                    item = "largebackpack",
                }
            }
        },
    }
    exports['qb-menu']:openMenu(OpenMenu)
end)
local spawnedEntity = nil

local function SpawnPed()
    RequestModel(Config.BuyModel)
    while not HasModelLoaded(Config.BuyModel) do
        Wait(0)
    end
    local entity = CreatePed(0, GetHashKey(Config.BuyModel), Config.BuyLocation.x, Config.BuyLocation.y, Config.BuyLocation.z - 1.0, Config.BuyLocation.w,  false, false)
    FreezeEntityPosition(entity, true)
    SetEntityInvincible(entity, true)
    SetBlockingOfNonTemporaryEvents(entity, true)
    exports['qb-target']:AddTargetEntity(entity, { 
    options = { 
    { 
        type = "client", 
        event = "snipe-backpack:client:openStore",
        icon = 'fas fa-circle',
        label = 'Store',
        }
    },
        distance = 2.5, 
    })
    return entity
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - vector3(Config.BuyLocation.x, Config.BuyLocation.y, Config.BuyLocation.z)) < 50.0 then
            if spawnedEntity == nil or not DoesEntityExist(spawnedEntity) then
                spawnedEntity = SpawnPed()
            end
        else
            if spawnedEntity ~= nil and DoesEntityExist(spawnedEntity) then
                DeleteEntity(spawnedEntity)
            end
        end
    end
end)