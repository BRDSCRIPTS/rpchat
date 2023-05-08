ESX = nil

Config.WebHook = "" 
Config.Name = "Relox - FiveM" 
Config.SteamApiKey = "" 
Config.DiscordImage = "" 
local DISCORD_WEBHOOK = Config.WebHook
local DISCORD_NAME = Config.Name
local STEAM_KEY = Config.SteamApiKey
local DISCORD_IMAGE = Config.DiscordImage 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
  CancelEvent()
  TriggerClientEvent('chat:addMessage', source, {
	  template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(205, 0, 0, 0.45);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(205, 0, 0, 0.45); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Toto není platný příkaz <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>',
        args = {}
    })
end)

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if true then
			if false then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end

AddEventHandler('chatMessage', function(source, name, message)
  if string.sub(message, 1, string.len('/')) ~= '/' then
    CancelEvent()

    if Config.OnlyICNames then name = GetRealPlayerName(source) end

    TriggerClientEvent('esx_rpchat:sendLocalOOC', -1, source, name, message, {30, 144, 255});
  end
end)

RegisterCommand('announce', function(source,args,raw)
  local xPlayer = ESX.GetPlayerFromId(source)
  local toSay = ''
    for i=1,#args do
     toSay = toSay .. args[i] .. ' ' 
   end

   if Config.AdminGroups[xPlayer.getGroup()] == true then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb((252, 7, 31);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(252, 7, 31); border-radius: 5px; font-size: 15px;"> <b> ADMIN OZNÁMENÍ</b></font>   <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> |</b></font>   <font style=" font-weight: 800; font-size: 15px; margin-left: 5px; padding-bottom: 3px; border-radius: 0px;"><b></b></font><font style=" font-weight: 200; font-size: 14px; border-radius: 0px;"> {0} </font></div>',
      args = { toSay }
  })
  end
end,false)

RegisterCommand('bm', function(source, args, raw)
  local playerName = GetPlayerName(source)
  fal = GetRealPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "blackmarket"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

if xPlayer.job.name ~= 'police' then
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(252, 7, 31);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(252, 7, 31); border-radius: 5px; font-size: 15px;"> <b> BLACKMARKET</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>',
      args = {toSay}
  })
end
PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
end, false)


RegisterCommand('reklama', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)

  fal = GetRealPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "reklama"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(4, 255, 97);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(4, 255, 97); border-radius: 5px; font-size: 15px;"> <b> REKLAMA</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
      args = {toSay}
  })
end, false)


RegisterCommand('police', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "police"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' ' 
end

  if xPlayer.job.name == 'police' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(0, 0, 255);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(0, 0, 255); border-radius: 5px; font-size: 15px;"> <b> LSPD</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako lspd aby si mohl použit /police <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('sheriff', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "sheriff"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'sheriff' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(230, 161, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(230, 161, 0); border-radius: 5px; font-size: 15px;"> <b> BCSO</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako sheriff aby si mohl použit /sheriff <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('ems', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "ambulance"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'ambulance' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(230, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(230, 0, 0); border-radius: 5px; font-size: 15px;"> <b> AMBULANCE</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako lekár aby si mohl použit /ems <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('bennys', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "bennys"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'bennys' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(230, 161, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(230, 161, 0); border-radius: 5px; font-size: 15px;"> <b> BENNYS</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b>CHYBA</b></font></i> | Musíš pracovat ako bennys aby si mohl použit /bennys <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('bahama', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "bahama"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'bahama' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(249, 10, 241);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(249, 10, 241); border-radius: 5px; font-size: 15px;"> <b> BAHAMA</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako bahama aby si mohl použit /bahama <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('beanmachine', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "beanmachine"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'beanmachine' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(34, 139, 34);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(34, 139, 34); border-radius: 5px; font-size: 15px;"> <b> BEAN MACHINE</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako beanmachine aby si mohl použit /beanmachine <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('fib', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "fib"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'fib' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(70, 2, 67);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(70, 2, 67); border-radius: 5px; font-size: 15px;"> <b> FIB</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako fib aby si mohl použit /fib <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('pivovar', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "pivovar"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'pivovar' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(146, 220, 36);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(146, 220, 36); border-radius: 5px; font-size: 15px;"> <b> PIVOVAR</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako pivar aby si mohl použit /pivar <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('sand', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "sand"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'sand' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(122, 103, 7);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(122, 103, 7); border-radius: 5px; font-size: 15px;"> <b> SAND</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako sand aby si mohl použit /sand <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('sandymechanic', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "sandymechanic"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'sandy_mechanic' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(17, 216, 136);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(17, 216, 136); border-radius: 5px; font-size: 15px;"> <b> SANDY MECHANIC</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako sandy mechanic aby si mohl použit /sandy mechanic<font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('unicorn', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "unicorn"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'unicorn' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(247, 0, 255);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(247, 0, 255); border-radius: 5px; font-size: 15px;"> <b> UNICORN</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako vanilla aby si mohl použit /vanilla<font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('vigne', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "vigne"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'vigne' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(84, 4, 87);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(84, 4, 87); border-radius: 5px; font-size: 15px;"> <b> VINICE</b></font></i> | {0}  <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.9); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(255, 0, 0); border-radius: 5px; font-size: 15px;"> <b> CHYBA</b></font></i> | Musíš pracovat ako vinař aby si mohl použit /vinař<font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;""></div>', 
    args = {}
  })
end
end, false)

RegisterCommand('mluvit', function(source, args, raw)
  if source == 0 then
    return
  end

  local args = table.concat(args, ' ')
  local name = GetCharacterName(source)

  TriggerClientEvent('esx_rpchat:sendMluvit', -1, source, name, args, { 196, 33, 246 })
  TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
end)


RegisterCommand('me', function(source, args, raw)
  local args = table.concat(args, ' ')
  local name = GetCharacterName(source)

  TriggerClientEvent('esx_rpchat:sendMe', -1, source, name, args, { 196, 33, 246 })
  TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
end)

RegisterCommand('do', function(source, args, raw)
  local args = table.concat(args, ' ')
  local name = GetCharacterName(source)

  TriggerClientEvent('esx_rpchat:sendDo', -1, source, name, args, { 255, 198, 0 })
  TriggerClientEvent('3ddo:triggerDisplay', -1, args, source)
end)

RegisterCommand('doc', function(source, args, raw)
  local name = GetCharacterName(source)
  if args[1] ~= nil then 
    local counter_doc = 0
    local pocetOpakovani = tonumber(args[1])
    if pocetOpakovani < 101 then
      while counter_doc < pocetOpakovani do
          counter_doc = counter_doc + 1 
          TriggerClientEvent('esx_rpchat:sendDoc', -1, source, name, counter_doc .. "/" .. pocetOpakovani , { 255, 198, 0 })
          TriggerClientEvent('3ddoa:triggerDisplay', -1, counter_doc .. "/" .. pocetOpakovani, source)
          Wait(2000)
      end 
    end
  end
end)

function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "rpchat",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end