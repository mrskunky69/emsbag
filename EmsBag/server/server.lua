local RSGCore = exports['rsg-core']:GetCoreObject()

local Objects = {}

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

RSGCore.Functions.CreateUseableItem('emsbag', function(source, item)TriggerClientEvent("EmsBag:Client:spawnLight", source)end)

RegisterNetEvent('EmsBag:Server:SpawnAmbulanceBag', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("EmsBag:Client:SpawnAmbulanceBag", src, objectId, type, src)
end)

RegisterNetEvent('EmsBag:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)

RegisterNetEvent('EmsBag:Server:AddItem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount)
end)


