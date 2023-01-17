local RSGCore = exports['rsg-core']:GetCoreObject()
-- Notifys
function Notify(msg)
    RSGCore.Functions.Notify(msg)
end

-- Progressbars
function progressBar(msg)
    RSGCore.Functions.Progressbar("ems bag", msg, 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()end)
end