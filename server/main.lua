ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local muerto = {}
local administrando = false


if Setting.LogConsola then 
    ESX.RegisterServerCallback('jc_admin:loadtoadmin', function(source, cb)
        local player = ESX.GetPlayerFromId(source)
    
        if player ~= nil then
            local playerGroup = player.getGroup()
    
            if playerGroup ~= nil then 
                cb(playerGroup)
            else
                cb('user')
            end
            local name = GetPlayerName(source)
    
            if playerGroup == 'superadmin' then
                    playerGroup = 'Super Administrador'
                    print ('^6Administrador ^5[^1' ..name.. '^5]^6 registrado con permisos de ^5[^1' ..playerGroup..'^5]^6 ID:^5[^1' ..source..'^5]^0')
                end
                if playerGroup == 'admin' then
                    playerGroup = 'Administrador'
                    print ('^6Administrador ^5[^1' ..name.. '^5]^6 registrado con permisos de ^5[^1' ..playerGroup..'^5]^6 ID:^5[^1' ..source..'^5]^0')
                end
                if playerGroup == 'mod' then
                    playerGroup = 'Moderador'
                    print ('^6Administrador ^5[^1' ..name.. '^5]^6 registrado con permisos de ^5[^1' ..playerGroup..'^5]^6 ID:^5[^1' ..source..'^5]^0')
                end
                if playerGroup == 'user' then
                    playerGroup = 'PUTA'
                end
        else
            cb('user')
        end
    end)
end

if Setting.KillPLayer then
    RegisterCommand('killplayer', function(source, args)	
        if administrando then 
            if source ~= 0 then
                if args[1] and tonumber(args[1]) then
                    local targetId = tonumber(args[1])
                    local name = GetPlayerName(source)
                    local playerPing = GetPlayerPing(source)
                      local xTarget = ESX.GetPlayerFromId(targetId)
                      local xPlayer = ESX.GetPlayerFromId(source)
                      if SoyAdmin(xPlayer) then
                        if xTarget then
                            TriggerClientEvent('ASFadgASDGsdgbSDGsdgSDGsdgSDGBSdbasddfvbASDG: : : : :', source)
                            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 Has sido ejecutado por un administrador ^3[^1'..GetPlayerName(source)..'^3]^0'))
                            TriggerEvent('jc_logs:funcionlog', '👁 Logs Administración 👁', '**\nAdmnistrador: **'..tostring(name)..'**\nID: **'..tostring(targetId)..'**\nJugador: **'..tostring(GetPlayerName(targetId))..'**\nPing Player: **'..tostring(playerPing)..'\n**Acción Realizada:** Kill Player', 255243)
                          else
                            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0El jugador no está online'))
                        end
                    else
                        TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
                     end
                else
                      TriggerClientEvent('chatMessage', source, ('Error en el sistema'))
                end
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
end

if Setting.ALPlayers then 
    RegisterCommand('reviveall', function(source, args)	
        if administrando then 
            canRevive = false
            local name = GetPlayerName(source)
            if source == 0 then
                canRevive = true
            else
                local xPlayer = ESX.GetPlayerFromId(source)
                if Superior(xPlayer) then
                    canRevive = true
                    local playerPing = GetPlayerPing(source)
                    TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 Has revivido a todo el servidor'))
                    TriggerEvent('jc_logs:funcionlogavanzado', '👁 Logs Administración Superior 👁', '**\nAdmnistrador: **'..tostring(name)..'**\nID: **'..tostring(source)..'**\nPlayer Ping: **'..tostring(playerPing)..'\n**Acción Realizada:** Revive ALL Payers', 23543)
                else
                    TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
                end
            end
            if canRevive then
                for i,data in pairs(muerto) do
                    TriggerClientEvent('esx_ambulancejob:revive', i)
                end
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
    
    RegisterCommand('dvall',function(source, args)
        if administrando then 
            local xPlayer = ESX.GetPlayerFromId(source)
            local name = GetPlayerName(source)
            if Superior(xPlayer) then
                TriggerClientEvent('jc_admin:eliminarveh', -1)
                TriggerEvent('jc_logs:funcionlogavanzado', '👁 Logs Administración Superior 👁', '**\nAdmnistrador: **'..tostring(name)..'**\nID: **'..tostring(source)..'\n**Acción Realizada:** Dv ALL', 23543)
            else
                TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)

    RegisterCommand('bringall',function(source, args)
        if administrando then 
            local xPlayer = ESX.GetPlayerFromId(source)
            local name = GetPlayerName(source)
            if Superior(xPlayer) then
                local coords = GetEntityCoords(GetPlayerPed(source))
                for _, playerId in ipairs(GetPlayers()) do
                    SetEntityCoords(GetPlayerPed(playerId), coords.x, coords.y, coords.z + 0.5)
                    TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 Has traido a todo el servidor'))
                    TriggerEvent('jc_logs:funcionlogavanzado', '👁 Logs Administración Superior 👁', '**\nAdmnistrador: **'..tostring(name)..'**\nID: **'..tostring(source)..'\n**Acción Realizada:** Bring ALL Players', 23543)
                end
            else
                TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
end

if Setting.AdminChat then 
    RegisterCommand('a',function(source, args, rawCommand)
        local xPlayer = ESX.GetPlayerFromId(source)
        if SoyAdmin(xPlayer) and args[1] then
            local a = string.gsub(rawCommand, 'a ', '')
            local admin = GetPlayerName(source)
            for _, playerId in ipairs(GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(source)
                local playerPing = GetPlayerPing(source)
                if SoyAdmin(xPlayer) then
                    TriggerClientEvent('chat:addMessage', playerId, { args = { '^6[^4Admin Chat^6] ^1[^2'..admin..'^1] ^0', a } })
                    TriggerEvent('jc_logs:funcionlogavanzado', '👁 Logs Administración Admin Chat 👁', '**\nAdministrador: **'..tostring(admin)..'\n**ID**: '..tostring(args[1])..'\n**Player Ping**: '..tostring(playerPing)..'**\nChat: **'..tostring(a), 255)
                end
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
        end
    end)
end

-- Basic

if Setting.Basic then 
    RegisterCommand('goto',function(source, args)
        if administrando then 
            local xPlayer = ESX.GetPlayerFromId(source)
            if SoyAdmin(xPlayer) and args[1] then
                if GetPlayerName(args[1]) then
                    local playerId = args[1]
                    local coords = GetEntityCoords(GetPlayerPed(playerId))
                    SetEntityCoords(GetPlayerPed(source), coords.x, coords.y, coords.z + 0.5)
                else
                    TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 ID Incorrecta'))
                end
            else
                TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
    RegisterCommand('bring',function(source, args)
        if administrando then 
            local xPlayer = ESX.GetPlayerFromId(source)
            if SoyAdmin(xPlayer) and args[1] then
                if GetPlayerName(args[1]) then
                    local playerId = args[1]
                    local coords = GetEntityCoords(GetPlayerPed(source))
                    SetEntityCoords(GetPlayerPed(playerId), coords.x, coords.y, coords.z + 0.5)
                else
                    TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 ID Incorrecta'))
                end
            else
                TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
    RegisterCommand('fix',function(source, args)
        if administrando then 
            local xPlayer = ESX.GetPlayerFromId(source)
            if SoyAdmin(xPlayer) then
                TriggerClientEvent('jc_admin:repararveh', source)
                TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 Has reparado el vehiculo'))
            else
                TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
    RegisterCommand('announce', function(source, args, rawCommand)
        if administrando then 
            if source ~= 0 then
                local xPlayer = ESX.GetPlayerFromId(source)
                if args[1] then
                    local message = string.sub(rawCommand, 10)
                    local playerPing = GetPlayerPing(source)
                    if xPlayer then
                        if SoyAdmin(xPlayer) then
                            TriggerClientEvent('chatMessage', source, ('^6[^1Anuncio Administrativo^6] ^6||^0 ' ..message))
                            TriggerEvent('jc_logs:funcionlogavanzado', '👁 Logs Administración Announce 👁', '**\nAdministrador: **'..tostring(admin)..'\n**ID**: '..tostring(args[1])..'\n**Player Ping**: '..tostring(playerPing)..'**\nChat: **'..tostring(message), 255)
                        else
                            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
                        end
                    end
                else
                    TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 Error en el sistema'))
                 end
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
    RegisterCommand('kick',function(source, args, rawCommand)
        if administrando then 
            local xPlayer = ESX.GetPlayerFromId(source)
            if SoyAdmin(xPlayer) and args[1] and args[2] then
                if GetPlayerName(args[1]) then
                    local playerId = args[1]
                    local playerName = GetPlayerName(args[1])
                    local reason = string.gsub(rawCommand, 'kick '..args[1]..' ', '')
                    local admin = GetPlayerName(source)
                    TriggerEvent('jc_logs:funcionlogavanzado', '👁 Logs Administración Kick 👁', '**\nAdministrador: **'..tostring(admin)..'\n**Jugador**: '..tostring(playerName)..'**\nRazon del Kick: **'..tostring(reason), 255)
                    DropPlayer(playerId, reason)
                else
                    TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 ID del jugador no correcta'))
                end
            else
               -- TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
end

-- Reportes

if Setting.Reportes then 
    RegisterCommand(Setting.CommandReport,function(source, args, rawCommand)
        local reason = string.gsub(rawCommand, 'report ', '')
        local playerName = GetPlayerName(source)
        for _, playerId in ipairs(GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(source)
            if administrando then 
                if SoyAdmin(xPlayer) and args[1] then
                    TriggerClientEvent('chat:addMessage', playerId, { args = { '^3[^1Reportes^3] ^3[^1ID^3] ^1'..source..' ^4| ^3[^6Nombre: ^1'..playerName..'^3] ^4| ^0', reason } })
                    TriggerEvent('jc_logs:funcionlogavanzado', '👁 Logs Administración Reportes 👁', '**\nUsuario: **'..tostring(playerName)..'\n**ID**: '..tostring(source)..'**\nRazon del reporte: **'..tostring(reason), 255)
                end
            end
        end
        TriggerClientEvent('chat:addMessage', source, { args = { '^3[^1Reporte^3]', 'Reporte enviado, espere a ser atendido...' } })
    end)
end

-- Spectate

if Setting.Spectateplayer then 
    RegisterCommand('spectear',function(source, args)
        if administrando then 
            local xPlayer = ESX.GetPlayerFromId(source)
            if SoyAdmin(xPlayer) and args[1] then
                if GetPlayerName(args[1]) then
                    local playerId = args[1]
                    local playerName = GetPlayerName(args[1])
                    local admin = GetPlayerName(source)
                    local coords = GetEntityCoords(GetPlayerPed(playerId))
                    if coords.x ~= 0 and coords.y ~= 0 and coords.z ~= 0 then
                        TriggerClientEvent('jc_admin:specteando', source, coords, playerId)
                        TriggerEvent('jc_logs:funcionlogavanzado', '👁 Logs Administración Especteando 👁', '**\nAdmnistrador: **'..tostring(admin)..'**\nID del Administrador: **'..tostring(source)..'\n**Jugador**: '..tostring(playerName)..'\n**ID**: '..tostring(args[1]), 255)
                    end
                else
                    TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0ID del jugador no valida'))
                end
            else
                TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
            end
        else
            TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No estas administrando para utilizar comandos de admin'))
        end
    end)
end

RegisterCommand('administrar',function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if SoyAdmin(xPlayer) then
        TriggerClientEvent('jc_admin:adminstracion:entrar', source)
        administrando = true
    else
        TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
    end
end)

RegisterCommand('enviarclock',function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if SoyAdmin(xPlayer) then
        TriggerClientEvent('jc_admin:adminstracion:contar', source)
        administrando = false
    else
        TriggerClientEvent('chatMessage', source, ('^4[^1'..Setting.ServerName..'^4] || ^0 No tienes suficientes permisos para acceder al comando'))
    end
end)


-- Logs 

local imagen = Setting.ImagenBot
local nombre = Setting.NombreBot

RegisterServerEvent('jc_logs:funcionlog')
AddEventHandler('jc_logs:funcionlog', function(name, message, color)
local connect = {
        {
            ['color'] = color,
            ['title'] = '**'.. name ..'**',
                        ['description'] = message,
            ['footer'] = {
                                ['text'] = 'Administración || '..os.date('%c')..' ',
            },
        }
    }
  PerformHttpRequest(Setting.LogsBasicos, function(err, text, headers) end, 'POST', json.encode({username = nombre, embeds = connect, avatar_url = imagen}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('jc_logs:funcionlogavanzado')
AddEventHandler('jc_logs:funcionlogavanzado', function(name, message, color)
local connect = {
        {
            ['color'] = color,
            ['title'] = '**'.. name ..'**',
                        ['description'] = message,
            ['footer'] = {
                                ['text'] = 'Administración || '..os.date('%c')..' ',
            },
        }
    }
  PerformHttpRequest(Setting.LogsAvanzados, function(err, text, headers) end, 'POST', json.encode({username = nombre, embeds = connect, avatar_url = imagen}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('jc_logs:clocktime')
AddEventHandler('jc_logs:clocktime', function(name, message, color)
local connect = {
        {
            ['color'] = color,
            ['title'] = '**'.. name ..'**',
                        ['description'] = message,
            ['footer'] = {
                                ['text'] = 'Administración Clock || '..os.date('%c')..' ',
            },
        }
    }
  PerformHttpRequest(Setting.Clock, function(err, text, headers) end, 'POST', json.encode({username = nombre, embeds = connect, avatar_url = imagen}), { ['Content-Type'] = 'application/json' })
end)


RegisterServerEvent('jc_logs:conex')
AddEventHandler('jc_logs:conex', function(name, message, color)
local connect = {
        {
            ['color'] = color,
            ['title'] = '**'.. name ..'**',
                        ['description'] = message,
            ['footer'] = {
                                ['text'] = 'Administración || '..os.date('%c')..' ',
            },
        }
    }
  PerformHttpRequest(Setting.LogsEntradas, function(err, text, headers) end, 'POST', json.encode({username = nombre, embeds = connect, avatar_url = imagen}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('jc_logs:desconex')
AddEventHandler('jc_logs:desconex', function(name, message, color)
local connect = {
        {
            ['color'] = color,
            ['title'] = '**'.. name ..'**',
                        ['description'] = message,
            ['footer'] = {
                                ['text'] = 'Administración || '..os.date('%c')..' ',
            },
        }
    }
  PerformHttpRequest(Setting.LogsSalidas, function(err, text, headers) end, 'POST', json.encode({username = nombre, embeds = connect, avatar_url = imagen}), { ['Content-Type'] = 'application/json' })
end)

RegisterNetEvent('jc_logs:log:client')
AddEventHandler('jc_logs:log:client', function(reason)
                local name = GetPlayerName(source)
                local scr = source
                TriggerEvent('jc_logs:funcionlog', '👁 Logs Administración 👁', '**\nAdmnistrador: **'..tostring(name)..'**\nID: **'..tostring(scr)..'\n'..tostring(reason), 255)
end)

RegisterNetEvent('jc_logs:log:client:administrando')
AddEventHandler('jc_logs:log:client:administrando', function(reason)
                local name = GetPlayerName(source)
                local ping = GetPlayerPing(source)
                local scr = source
                TriggerEvent('jc_logs:clocktime', '🎫 Logs Administración Clock 🎫', '**\nAdmnistrador: **'..tostring(name)..'**\nID: **'..tostring(scr)..'**\nPing: **'..tostring(ping)..'\n'..tostring(reason), 255)
end)

-- Conex Deconex

AddEventHandler('playerConnecting', function(name) 
    local src = source
    local steamid = nil
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
		if string.match(v, 'steam') then
			steamid = v
			break
		end
	end
    local ids = ExtractIdentifiers(src);
    local steam = ids.steam:gsub('steam:', '');
    local steamDec = tostring(tonumber(steam,16));
    steam = 'https://steamcommunity.com/profiles/' .. steamDec;
    Citizen.Wait(0);
    if Setting.LogConsola then 
        print ('^5[^1Admin System^5] ^6|| ^5El jugador ^5[^1'..GetPlayerName(src)..'^5] ^5está conectandose al servidor.^0')
    end
    if Setting.LogsEntradasS then 
        TriggerEvent('jc_logs:conex', '👁 Logs Administración 👁 Conexiones', '\n**Nombre:** '..GetPlayerName(src)..'\n**Player Ping**'..GetPlayerPing(src)..'\n**Steam URL: **' .. steam .. '\n**Steam Hex: **' .. steamid .. '\n**Discord Tag: ** <@' .. ids.discord:gsub('discord:', '') .. '> \n**Discord ID: **' .. ids.discord:gsub('discord:', '') .. '\n**Licencia FiveM:** '.. ids.license:gsub('license:', '') .. '\n**IP:** ||'.. ids.ip:gsub('ip:', '').. '||');
    end
end)

AddEventHandler('playerDropped', function (reason)
    local src = source
    local nombre = GetPlayerName(src)
    local ping = GetPlayerPing(src)
    local steamid = nil
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
		if string.match(v, 'steam') then
			steamid = v
			break
		end
	end
    local ids = ExtractIdentifiers(src);
    local steam = ids.steam:gsub('steam:', '');
    local steamDec = tostring(tonumber(steam,16));
    steam = 'https://steamcommunity.com/profiles/' .. steamDec;
    Citizen.Wait(0);
    if Setting.LogsSalidasS then 
        TriggerEvent('jc_logs:desconex', '👁 Logs Administración 👁 Desconexiones',  '\n**Razón de salida:** '..reason..'\n**Nombre:** '..nombre..'\n**Player Ping:** '..ping..'\n**Steam URL: **' .. steam .. '\n**Steam Hex: **' .. steamid .. '\n**Discord Tag: ** <@' .. ids.discord:gsub('discord:', '') .. '> \n**Discord ID: **' .. ids.discord:gsub('discord:', '') .. '\n**Licencia FiveM:** '.. ids.license:gsub('license:', '') .. '\n**IP:** ||'.. ids.ip:gsub('ip:', '').. '||');
    end
end)

-- Funciones

function SoyAdmin(xPlayer, exclude)
	if exclude and type(exclude) ~= 'table' then exclude = nil;print('^1 Error en el sistema ^0') end

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Setting.Rangos) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

function Superior(xPlayer, exclude)
	if exclude and type(exclude) ~= 'table' then exclude = nil;print('^1 Error en el sistema ^0') end

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Setting.Superior) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end


RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	muerto[source] = data
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if muerto[source] then
		muerto[source] = nil
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if muerto[playerId] then
		muerto[playerId] = nil
	end
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = '',
        ip = '',
        discord = '',
        license = '',
        xbl = '',
        live = ''
    }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, 'steam') then
            identifiers.steam = id
        elseif string.find(id, 'ip') then
            identifiers.ip = id
        elseif string.find(id, 'discord') then
            identifiers.discord = id
        elseif string.find(id, 'license') then
            identifiers.license = id
        elseif string.find(id, 'xbl') then
            identifiers.xbl = id
        elseif string.find(id, 'live') then
            identifiers.live = id
        end
end
    return identifiers
end
