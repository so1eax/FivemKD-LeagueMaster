RegisterNetEvent('baseevents:onPlayerKilled')
RegisterNetEvent('onClientResourceStart')
RegisterNetEvent('kdsys:getKillLeaderCallBack')
RegisterNetEvent('kdsys:getPlayerKdCallBack')
RegisterNetEvent('kdsys:getPlayerDataCallBack')

local function GetPlayerData()
    local data = nil

    TriggerServerEvent("kdsys:getPlayerData")
    AddEventHandler("kdsys:getPlayerDataCallBack", function (datasv)
        data = datasv
    end)

    while not data do
        Wait(0)
    end

    return data
end

local function GetPlayerKd()
    local plykd = nil
    if not GetPlayerData() then
        return nil
    else
        if GetPlayerData().deaths <= 0 then
            plykd = tonumber(string.format("%.2f",GetPlayerData().kills / 1))
        else
            plykd = tonumber(string.format("%.2f",GetPlayerData().kills / GetPlayerData().deaths))
        end

        while not plykd do
            Wait(0)
        end
    end

    return plykd
end

local function GetPlayerLeague()
    local league = "Unranked"
    local plyscore = 0

    if not GetPlayerData() then
        return nil
    end

    plyscore = (GetPlayerData().kills * 0.7) + (GetPlayerKd() * 100 * 0.3)

    for _, v in ipairs(Config.Leagues) do
        if plyscore >= v.pointsRequired then
            league = v.name
        end
    end

    return league
end

exports("GetPlayerData", GetPlayerData)
exports("GetPlayerKd", GetPlayerKd)
exports("GetPlayerLeague", GetPlayerLeague)

AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
    local killerEntity = NetworkGetEntityKillerOfPlayer(PlayerId())
    local killerSvId = GetPlayerServerId(NetworkGetEntityOwner(killerEntity))

    TriggerServerEvent('kdsys:addPlayerKd', killerSvId, data)
end)

AddEventHandler('onClientResourceStart', function (resource)
    if GetCurrentResourceName() == resource then
        TriggerServerEvent('kdsys:playerCreationDB')
    end
end)

if Config.Commands.resetKd.enableCommand then
    RegisterCommand(Config.Commands.resetKd.commandName, function ()
        TriggerServerEvent('kdsys:resetPlayerKd')
    end, false)
end

if Config.Commands.myKd.enableCommand then
    RegisterCommand(Config.Commands.myKd.commandName, function ()
        SetNotificationTextEntry("STRING")
        AddTextComponentString("Your kd is: " .. GetPlayerKd())
        DrawNotification(false, false)
    end, false)
end

if Config.Commands.myKills.enableCommand then
    RegisterCommand(Config.Commands.myKills.commandName, function ()
        SetNotificationTextEntry("STRING")
        AddTextComponentString("You have: " .. GetPlayerData().kills .. " kills")
        DrawNotification(false, false)
    end, false)
end


if Config.Commands.myDeaths.enableCommand then
    RegisterCommand(Config.Commands.myDeaths.commandName, function ()
        SetNotificationTextEntry("STRING")
        AddTextComponentString("You have: " .. GetPlayerData().deaths .. " deaths")
        DrawNotification(false, false)
    end, false)
end


if Config.Commands.myLeague.enableCommand then
    RegisterCommand(Config.Commands.myLeague.commandName, function ()
        SetNotificationTextEntry("STRING")
        AddTextComponentString("You are in the league: " .. GetPlayerLeague())
        DrawNotification(false, false)
    end, false)
end


if Config.Commands.killLeader.enableCommand then
    RegisterCommand(Config.Commands.killLeader.commandName, function ()
        TriggerServerEvent("kdsys:getKillLeader")
        AddEventHandler('kdsys:getKillLeaderCallBack', function (usrnm, kills, kd, uuid)
            SetNotificationTextEntry("STRING")
            AddTextComponentString("The kill leader is " .. usrnm .. " with " .. kills .. " kills (K/D: " .. kd .. ") in the ".. GetPlayerLeague() .." league (UUID : " .. uuid .. ")")
            DrawNotification(false, false)
        end)
    end, false)
end

if Config.Hud.enableHud then
    while true do
        SendNUIMessage({
            plykills = GetPlayerData().kills,
            plydeaths = GetPlayerData().deaths,
            plykd = GetPlayerKd(),
            plyleague = GetPlayerLeague()
        })
        Wait(Config.Hud.hudRefreshRate)
    end
else
    Wait(1000)
    SendNUIMessage({
        hudstatus = false
    })
end

