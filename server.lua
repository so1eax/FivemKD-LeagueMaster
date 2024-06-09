RegisterNetEvent('kdsys:addPlayerKd')
RegisterNetEvent('kdsys:playerCreationDB')
RegisterNetEvent('kdsys:getPlayerKd')
RegisterNetEvent('kdsys:resetPlayerKd')
RegisterNetEvent('kdsys:getKillLeader')
RegisterNetEvent('kdsys:getPlayerData')


local function GetPlayerData(playerSvId)
    local identifier = GetPlayerIdentifierByType(playerSvId, 'license')
    local data = nil

    if not identifier then
        return nil
    end

    while not MySQL do
        Wait(0)
    end

    data = MySQL.Sync.fetchAll("SELECT * FROM kdsys_users WHERE identifier = @identifier", {['identifier'] = identifier})

    return data[1]
end

local function GetPlayerKd(playerSvId)
    local plykd = nil
    if not GetPlayerData(playerSvId) then
       return nil
    else
        if GetPlayerData(playerSvId).deaths <= 0 then
            plykd = tonumber(string.format("%.2f", GetPlayerData(playerSvId).kills / 1))
        else
            plykd = tonumber(string.format("%.2f", GetPlayerData(playerSvId).kills / GetPlayerData(playerSvId).deaths))
        end
    end

    return plykd
end

local function GetPlayerLeague(playerSvId)
    local league = "Unranked"
    local plyscore = 0

    if not GetPlayerData(playerSvId) then
        return nil
    end

    plyscore = (GetPlayerData(playerSvId).kills * 0.7) + (GetPlayerKd(playerSvId) * 100 * 0.3)

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

AddEventHandler('kdsys:addKdForPaddPlayerKdlayers', function (killerSvId, data)
    local victimIdentifier = GetPlayerIdentifierByType(source, 'license')
    local killerIdentifier = GetPlayerIdentifierByType(killerSvId, 'license')

    while not MySQL do
        Wait(0)
    end

    MySQL.Async.fetchAll("UPDATE kdsys_users SET deaths = deaths + @deaths WHERE identifier = @identifier", {['deaths'] = 1, ['identifier'] = victimIdentifier})
    MySQL.Async.fetchAll("UPDATE kdsys_users SET kills = kills + @kills WHERE identifier = @identifier", {['kills'] = 1, ['identifier'] = killerIdentifier})
end)

AddEventHandler('kdsys:playerCreationDB', function ()
    local plysource = source
    local identifier = GetPlayerIdentifierByType(source, 'license')

    while not MySQL do
        Wait(0)
    end

    MySQL.Async.fetchAll("SELECT * FROM kdsys_users", {}, function (result)
        if not result[1] then
            MySQL.Async.fetchAll("INSERT INTO kdsys_users (identifier, username, kills, deaths) VALUES (@identifier, @username, @kills, @deaths)", { ['identifier'] = identifier, ['username'] = GetPlayerName(plysource), ['kills'] = 0, ['deaths'] = 0})
        end
    end)
end)

AddEventHandler('kdsys:getPlayerKd', function ()
    TriggerClientEvent("kdsys:getPlayerKdCallBack", source, GetPlayerKd(source))
end)

AddEventHandler('kdsys:resetPlayerKd', function ()
    local identifier = GetPlayerIdentifierByType(source, 'license')
    while not MySQL do
        Wait(0)
    end
    MySQL.Async.fetchAll("UPDATE kdsys_users SET kills = @kills, deaths = @deaths WHERE identifier = @identifier", {['kills'] = 0, ['deaths'] = 0, ['identifier'] = identifier})
end)

AddEventHandler('kdsys:getKillLeader', function ()
    local plysource = source

    while not MySQL do
        Wait(0)
    end

    MySQL.Async.fetchAll("SELECT * FROM kdsys_users ORDER BY kills DESC LIMIT 1", {}, function (result)
        if #result > 0 then
            local leader = result[1]
            local leaderKd = nil
            if leader.deaths <= 0 then
                leaderKd = tonumber(string.format("%.2f",leader.kills / 1))
            else
                leaderKd = tonumber(string.format("%.2f", leader.kills / leader.deaths))
            end
            TriggerClientEvent('kdsys:getKillLeaderCallBack', plysource, leader.username, leader.kills, leaderKd, leader.id)
        end
    end)
end)

AddEventHandler('kdsys:getPlayerData', function ()
    local identifier = GetPlayerIdentifierByType(source, 'license')
    local data = nil
    local plysrc = source

    while not MySQL do
        Wait(0)
    end

    MySQL.Async.fetchAll("SELECT * FROM kdsys_users WHERE identifier = @identifier",{['identifier'] = identifier}, function (result)
        data = result[1]
    end)

    while not data do
        Wait(0)
    end

    TriggerClientEvent("kdsys:getPlayerDataCallBack", plysrc, data)
end)