local discordwebhook = ''
local playertimes = {}

RegisterServerEvent('log:server:playtime', function(playtime)
    local L = source
    playertimes[L] = playtime
end)

local function Data(L)
    local idtablemb = {
        license = "No License found", 
        license2 = "No license2 found",
        identifier = "No Hex-ID found",
        discord = "No Discord found",
        xbl = "No xbl ID found",
        live = "No Live ID found",
        fivem = "No FiveM ID found"
    }
    for k,v in ipairs(GetPlayerIdentifiers(L))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            idtablemb.license = v
        elseif string.sub(v, 1, string.len("license2:")) == "license2:" then
            idtablemb.license2 = v
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
            idtablemb.identifier = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            idtablemb.discord = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            idtablemb.xbl = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            idtablemb.live = v
        elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
            idtablemb.fivem = v
        end
    end
    return idtablemb
end

local function Discord(color, name, message, footer)
    local webbi = '' --discord webhook here
    local footer = 'Static Roleplay - '..os.date("%d/%m/%Y - %X")
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    PerformHttpRequest(discordwebhook, function(err, text, headers) end, 'POST', json.encode(
        {
            username = 'Data',
            embeds = embed
        }), {
            ['Content-Type'] = 'application/json'
        }
    )
end

AddEventHandler('playerConnecting', function()
    local L = source
    local name = GetPlayerName(L)
    local mb = Data(L)
    Discord(3158326, '`✅` | PLAYER CONNECTING',' Player: `' .. name .. '`\n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n License2: `' ..mb.license2.. '` \n Discord Tag: <@' ..mb.discord:gsub('discord:', '').. '>\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n IP: `' ..GetPlayerEndpoint(L).. '`')
end)

AddEventHandler('playerDropped', function(reason)
    local L = source
    local name = GetPlayerName(L)
    local playtime = playertimes[L] or 0
    local mb = Data(L)
    Discord(3158326, '`❌` | PLAYER DROPPED',' Player: `' .. name .. '`\n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n License2: `' ..mb.license2.. '` \n Discord Tag: <@' ..mb.discord:gsub('discord:', '').. '>\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n IP: `' ..GetPlayerEndpoint(L).. '`')
end)