Config = {}

Config.Leagues = {
    {name = "Bronze", pointsRequired = 499},
    {name = "Silver", pointsRequired = 999},
    {name = "Gold", pointsRequired = 1499},
    {name = "Platinum", pointsRequired = 2499},
    {name = "Diamond", pointsRequired = 3499},
    {name = "Master", pointsRequired = 4999},
    {name = "Grandmaster", pointsRequired = 7000},
}

Config.Commands = {
    resetKd = {
        enableCommand = true,
        commandName = "resetkd"
    },
    myKd = {
        enableCommand = true,
        commandName = "mykd"
    },
    myKills = {
        enableCommand = true,
        commandName = "mykills"
    },
    myDeaths = {
        enableCommand = true,
        commandName = "mydeaths"
    },
    myLeague = {
        enableCommand = true,
        commandName = "myleague"
    },
    killLeader = {
        enableCommand = true,
        commandName = "killleader"
    },
}

Config.Hud = {
    enableHud = true,
    hudRefreshRate = 500, -- In milliseconds
}