local RSGCore = exports['rsg-core']:GetCoreObject()


-- Simple Event's , you can create yours and put on qb-menu :)


RegisterNetEvent('EmsBag:Client:Givebandage')
AddEventHandler("EmsBag:Client:Givebandage", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, 0, true)
    progressBar("Taking Bandage ...")
    TriggerServerEvent("EmsBag:Server:AddItem", "bandage", 1)
    TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items["bandage"], "add", 1)
end)
RegisterNetEvent('EmsBag:Client:Givepainkillers')
AddEventHandler("EmsBag:Client:Givepainkillers", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, 0, true)
    progressBar("Taking Painkillers ...")
    TriggerServerEvent("EmsBag:Server:AddItem", "painkillers", 1)
    TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items["painkillers"], "add", 1)
end)
RegisterNetEvent('EmsBag:Client:Givefirstaid')
AddEventHandler("EmsBag:Client:Givefirstaid", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, 0, true)
    progressBar("Taking Firstaid ...")
    TriggerServerEvent("EmsBag:Server:AddItem", "firstaid", 1)
    TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items["firstaid"], "add", 1)
end)



RegisterNetEvent('EmsBag:Client:MenuAmbulanceBag', function()
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then return Notify("You cannot Open Bag while dead", "error") end
    if IsPedSwimming(playerPed) then return Notify("You cannot Open Bag in the water.", "error") end
    if IsPedSittingInAnyVehicle(playerPed) then return Notify("You cannot Open Bag inside a vehicle", "error") end
    local job = RSGCore.Functions.GetPlayerData().job.name
    if Config.Bag.NeedJob == true then
        if job ~= Config.Bag.Job then
            Notify("You dont have permissions to Open The Bag")
            return false
        end
    end
    exports['rsg-menu']:openMenu({
        { header = "[🚑] Ambulance Box", txt = "", isMenuHeader = true },
        { header = "[👜] Open AmbulanceBag",  params = { event = "EmsBag:Client:StorageAmbulanceBag" } },
        { header = "[🩹]Take Bandage ",  params = { event = "EmsBag:Client:Givebandage" } },
        { header = "[💊] Take Painkillers ",  params = { event = "EmsBag:Client:Givepainkillers" } },
        { header = "[💉] Take Firstaid ",  params = { event = "EmsBag:Client:Givefirstaid" } },

        -- You can add more menus with your's personal events...
        { header = "", txt = "❌ Close", params = { event = "qr-menu:closeMenu" } },
    })
end)

