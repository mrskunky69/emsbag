local RSGCore = exports['qr-core']:GetCoreObject()

local ObjectList = {}

RegisterNetEvent('EmsBag:Client:SpawnAmbulanceBag', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    local spawnedObj = CreateObject(Config.Bag.AmbulanceBag[type].model, x, y, coords.z-1, true, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Bag.AmbulanceBag[type].freeze)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = vector3(x, y, z - 0.3),
    }
    TriggerServerEvent("EmsBag:Server:RemoveItem","emsbag",1)
end)

RegisterNetEvent('EmsBag:Client:spawnLight', function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
    progressBar("Putting the Ems Bag...")
    Wait(2500)
    TriggerServerEvent("EmsBag:Server:SpawnAmbulanceBag", "emsbag")
end)

RegisterNetEvent('EmsBag:Client:GuardarAmbulanceBag')
AddEventHandler("EmsBag:Client:GuardarAmbulanceBag", function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
    local AmbulanceBag = GetClosestObjectOfType(playerPedPos, 10.0, GetHashKey("p_bag01x"), false, false, false)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
    progressBar("Taking Back the Ems Bag...")
    Wait(2500)
    Notify("Ems Bag Taken Back with success.")
    SetEntityAsMissionEntity(AmbulanceBag, 1, 1)
    DeleteObject(AmbulanceBag)
    TriggerServerEvent("EmsBag:Server:AddItem","emsbag",1)
end)

local citizenid = nil
AddEventHandler("EmsBag:Client:StorageAmbulanceBag", function()
    local charinfo = RSGCore.Functions.GetPlayerData().charinfo
    citizenid = RSGCore.Functions.GetPlayerData().citizenid
    TriggerEvent("inventory:client:SetCurrentStash", "Ambulance Bag",citizenid)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Ambulance Bag",citizenid, {
        maxweight = 40000,
        slots = 48,
    })
end)

local AmbulanceBags = {
    `p_bag01x`,
}

exports['qr-target']:AddTargetModel(AmbulanceBags, {
    options = {{event   = "EmsBag:Client:MenuAmbulanceBag",icon    = "fa-solid fa-suitcase-medical",label   = "Ems Bag"},
    {event   = "EmsBag:Client:GuardarAmbulanceBag",icon    = "fa-solid fa-suitcase-medical",label   = "Take Back Ems Bag"},},distance = 2.0 })
