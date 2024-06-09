
# s1_kdsys

**s1_kdsys** is a versatile and easy-to-configure script designed to enhance your server by tracking and displaying player kill/death ratios in real time. Perfect for roleplay and competitive servers.

## Features

- Configurable league system with tiered progression.
- Customizable commands.
- Optional player hud.

## Configuration Options

- `Leagues` Configurable league system with tiered progression
- `enableCommand` Enables the command for each commands.
- `commandName` Name of the command for each commands.
- `enableHud` true/false to toggle the HUD display.
- `hudRefreshRate` Recommended 500 milliseconds for updating HUD information.

## Installation

1. **Download the Script**: Download the script and place the `s1_kdsys` folder in your `resources` directory.

2. **Download oxmysql**: Download the latest release of oxmysql(https://github.com/overextended/oxmysql/releases) and place the `oxmysql` folder in your `resources` directory.

3. **Import kdsys_users**: Imoport the kdsys_users.sql in your database.

4. **Add to server.cfg**: Add the following line to your `server.cfg` file to ensure the resource starts with your server:
   \`\`\`
   start oxmysql
   start s1_ksys
   \`\`\`

5. **Configure the Script**: Open the `config.lua` file and customize the configuration options to suit your server's needs.

## Usage

Once installed and configured, the script will automatically enforce the jump limit and apply the ragdoll effect as per your settings. If debug mode is enabled, debug messages will be printed to the server console for monitoring purposes.

## Configuration

Edit the `config.lua` file to configure the following options:

\`\`\`lua
Config.Leagues = { -- You can change the number of points required for each leagues, and you can create as many leagues as you want.
    {name = "Bronze", pointsRequired = 499},
    {name = "Silver", pointsRequired = 999},
    {name = "Gold", pointsRequired = 1499},
    {name = "Platinum", pointsRequired = 2499},
    {name = "Diamond", pointsRequired = 3499},
    {name = "Master", pointsRequired = 4999},
    {name = "Grandmaster", pointsRequired = 7000},
}

Config.Commands = { -- You can enable / disable commands by setting the `enableCommand` to true / false, and change their names with the `commandName`
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
    enableHud = true, -- true / false to enable / disable the player hud
    hudRefreshRate = 500, -- Refresh rate in milliseconds (0.5 seconds)
}
\`\`\`

## Support

For support and suggestions, feel free to reach out on the Cfx.re forum thread or in my Discord DM (so1eaxx). Contributions and feedback are always welcome!

Enjoy this script!

## License

This project is licensed under the MIT License - see the LICENSE file for details.
