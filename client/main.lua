ESX = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local administrando = false 

TriggerEvent('chat:addSuggestion', '/'..'report', 'Informa de cualquier problema a la admnistración', {{ name='Descripción del reporte'}})
TriggerEvent('chat:addSuggestion', '/'..'a', 'Admin chat')
TriggerEvent('chat:addSuggestion', '/'..'kick', 'Kickear Jugador', {{ name='player', help='player id' }, { name='reason', help='kick reason' }})
TriggerEvent('chat:addSuggestion', '/'..'killplayer', 'Matar a un Jugador', {{ name='ID'}})
TriggerEvent('chat:addSuggestion', '/'..'bringall', 'Traer a todo el servidor a tu posición')
TriggerEvent('chat:addSuggestion', '/'..'reviveall', 'Revivir a todo el servidor')
TriggerEvent('chat:addSuggestion', '/'..'dvall', 'Eliminar vehiculos en todo el servidor')
TriggerEvent('chat:addSuggestion', '/'..'administrar', 'Entrar ha administrar y contar el tiempo administrado')
TriggerEvent('chat:addSuggestion', '/'..'enviarclock', 'Dejar de administrar y enviar el tiempo administrado')



print 'Admin by juancA#3946'


-- TPM

if Setting.Basic then 
    RegisterNetEvent('jc_admin:tpmtopoint', function()
		if administrando then 
			local WaypointHandle = GetFirstBlipInfoId(8)
			if DoesBlipExist(WaypointHandle) then
				local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
		
				for height = 1, 1000 do
					SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords['x'], waypointCoords['y'], height + 0.0)
		
					local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords['x'], waypointCoords['y'], height + 0.0)
		
					if foundGround then
						SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords['x'], waypointCoords['y'], height + 0.0)
		
						break
					end
		
					Citizen.Wait(5)
				end
				TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0 Has sido teletransportado.'))
				TriggerServerEvent('jc_logs:log:client', '**Acción realizada**: TPM')
			else
				TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0 Marque una opcion en su mapa para poder hacer el TPM'))
			end
		else
			TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0No estas administrando para utilizar comandos de admin'))
		end
    end)
    
    TPM = function()
        ESX.TriggerServerCallback('jc_admin:loadtoadmin', function(playerRank)
            if playerRank == 'superadmin' then
                TriggerEvent('jc_admin:tpmtopoint')
            end
            if playerRank == 'admin' then
                TriggerEvent('jc_admin:tpmtopoint')
            end
            if playerRank == 'mod' then
                TriggerEvent('jc_admin:tpmtopoint')
            end
            if playerRank == 'user' then
                TriggerEvent('esx:showNotification', 'No contienes suficientes permisos para acceder al sistema de administración')
            end
        end)
    end
    RegisterCommand('tpm', function()
        TPM()
    end)
end

if Setting.Noclip then 

	local noclip = false
	local NoclipSpeed = Setting.VelocidadNoclip
	local oldSpeed = Setting.VelocidadNoclip
	
	local function GetSeatThatPeadIsIn(ped)
		if not IsPedInAnyVehicle(ped, false) then return
		else
			local veh = GetVehiclePedIsIn(ped)
			for i = 0, GetVehicleMaxNumberOfPassengers(veh) do
			if GetPedInVehicleSeat(veh) then return i end
			end
		end
	end
	
	local function getcamdirection()
		local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
		local pitch = GetGameplayCamRelativePitch()
	
		local x = -math.sin(heading * math.pi / 180.0)
		local y = math.cos(heading * math.pi / 180.0)
		local z = math.sin(pitch * math.pi / 180.0)
	
		local len = math.sqrt(x * x + y * y + z * z)
		if len ~= 0 then
			x = x / len
			y = y / len
			z = z / len
		end
	
		return x, y, z
	end
	
	local function requestControlOnce(entity)
		if not NetworkIsInSession or NetworkHasControlOfEntity(entity) then
			return true
		end
		SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), true)
		return NetworkRequestControlOfEntity(entity)
	end
	
	RegisterNetEvent('jc_admin:noclipplayer', function()

		if noclip == true then 
            TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0 Has desactivado el ^8noclip.^0'))
			TriggerServerEvent('jc_logs:log:client', '**Acción realizada**: Desactivar Noclip')
		else
			TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0 Has activado el ^9noclip.^0'))
			TriggerServerEvent('jc_logs:log:client', '**Acción realizada**: Activar Noclip')
		end
	
		noclip = not noclip
		while true do
			Citizen.Wait(0)
			if noclip then
			local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), 0)
			local k = nil
			local x, y, z = nil
			if not isInVehicle then
				k = PlayerPedId()
				x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 2))
			else
				k = GetVehiclePedIsIn(PlayerPedId(), 0)
				x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 1))
			end
			if isInVehicle and GetSeatThatPeadIsIn(PlayerPedId()) ~= -1 then requestControlOnce(k) end
			local dx, dy, dz = getcamdirection()
			SetEntityVisible(PlayerPedId(), 0, 0)
			SetEntityVisible(k, 0, 0)
			SetEntityVelocity(k, 0.0001, 0.0001, 0.0001)
			if IsDisabledControlJustPressed(0, 21) then 
				oldSpeed = NoclipSpeed
				NoclipSpeed = NoclipSpeed * 6
			end
			if IsDisabledControlJustReleased(0, 21) then 
				NoclipSpeed = oldSpeed
			end
			if IsDisabledControlPressed(0, 32) then 
				x = x + NoclipSpeed * dx
				y = y + NoclipSpeed * dy
				z = z + NoclipSpeed * dz
			end
			if IsDisabledControlPressed(0, 269) then 
				x = x - NoclipSpeed * dx
				y = y - NoclipSpeed * dy
				z = z - NoclipSpeed * dz
			end
			if IsDisabledControlPressed(0, 22) then 
				z = z + NoclipSpeed
			end
			if IsDisabledControlPressed(0, 36) then 
				z = z - NoclipSpeed
			end
			SetEntityCoordsNoOffset(k, x, y, z, true, true, true)
			else
			SetEntityVisible(PlayerPedId(), true)
			if IsPedInAnyVehicle(PlayerPedId(), 0) then
				SetEntityVisible(GetVehiclePedIsIn(PlayerPedId(), 0), true)
			end
			Citizen.Wait(200)
			break
			end
		end
	end)

	NOCLIP = function()
        ESX.TriggerServerCallback('jc_admin:loadtoadmin', function(playerRank)
            if playerRank == 'superadmin' then 
				TriggerEvent('jc_admin:noclipplayer')
            end
            if playerRank == 'admin' then
				TriggerEvent('jc_admin:noclipplayer')
            end
            if playerRank == 'mod' then
				TriggerEvent('jc_admin:noclipplayer')
            end
            if playerRank == 'user' then
                TriggerEvent('esx:showNotification', 'No contienes suficientes permisos para acceder al sistema de administración')
            end
        end)
    end

	RegisterCommand('noclip', function()
		if administrando then 
			NOCLIP()
		else
			TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0No estas administrando para utilizar comandos de admin'))
		end
    end)
end

if Setting.KillPLayer then 
	RegisterNetEvent('ASFadgASDGsdgbSDGsdgSDGsdgSDGBSdbasddfvbASDG: : : : :', function()
		TriggerEvent('chat:addSuggestion', '/'..'killplayer', 'Matar un jugador por ID', {{ name='ID', help='player id' }})
		SetEntityHealth(PlayerPedId(), 0)
	end)
end

if Setting.ALPlayers then 
	RegisterNetEvent('jc_admin:eliminarveh', function()
		TriggerEvent('chat:addSuggestion', '/'.. 'dvall', 'Eliminar todos los vehiculos')
		TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0Has eliminado todos los vehiculos del servidor.'))
		for veh in EnumerateVehicles() do
			if not IsPedAPlayer(GetPedInVehicleSeat(veh, -1)) then 
				SetEntityAsMissionEntity(veh, false, false)
				DeleteEntity(veh)
			end
		end
	end)
end

if Setting.Spectateplayer then
	local cdspectate = false
	local spectate = false
	local lastcoords = nil
	local positionped = nil
	local spectateped = nil
	RegisterNetEvent('jc_admin:specteando', function(coords, playerId)
		if not cdspectate then
			cdspectate = true
			if spectate then
				spectate = false
				Wait(300)
				RequestCollisionAtCoord(positionped)
				NetworkSetInSpectatorMode(false, spectateped)
				FreezeEntityPosition(PlayerPedId(), false)
				SetEntityCoords(PlayerPedId(), lastcoords)
				SetEntityVisible(PlayerPedId(), true)
				lastcoords = nil
				positionped = nil
				spectateped = nil
				cdspectate = false
			else
				spectate = true
				foundplayer = false
				lastcoords = GetEntityCoords(PlayerPedId())
				SetEntityVisible(PlayerPedId(), false)
				SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z + 10.0)
				FreezeEntityPosition(PlayerPedId(), true)
				Wait(1500)
				SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z - 10.0)
				for _, i in ipairs(GetActivePlayers()) do
					if NetworkIsPlayerActive(i) and tonumber(GetPlayerServerId(i)) == tonumber(playerId) then
						foundplayer = true
						ped = GetPlayerPed(i)
						positionped = GetEntityCoords(ped)
						spectateped = ped
						RequestCollisionAtCoord(positionped)
						NetworkSetInSpectatorMode(true, spectateped)
						cdspectate = false
						while spectate do
							Wait(100)
							local cped = GetEntityCoords(spectateped)
							if cped.x == 0 and cped.y == 0 and cped.z == 0 then
								spectate = false
								Wait(300)
								RequestCollisionAtCoord(positionped)
								NetworkSetInSpectatorMode(false, spectateped)
								FreezeEntityPosition(PlayerPedId(), false)
								SetEntityCoords(PlayerPedId(), lastcoords)
								SetEntityVisible(PlayerPedId(), true)
								lastcoords = nil
								positionped = nil
								spectateped = nil
								cdspectate = false
							else
								SetEntityCoords(PlayerPedId(), cped.x, cped.y, cped.z - 10.0)
							end
						end
						break
					end
				end
				if not foundplayer then
					FreezeEntityPosition(PlayerPedId(), false)
					SetEntityCoords(PlayerPedId(), lastcoords)
					SetEntityVisible(PlayerPedId(), true)
					lastcoords = nil
					spectate = false
					cdspectate = false
				end
			end
		end
	end)
	TriggerEvent('chat:addSuggestion', '/'..'spectear', 'espectear a un jugador', {{ name='ID', help='Spectea a un jugador' }})
end

local contminutos = 0
local conthoras = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000 * 60)
	if administrando then
		contminutos = contminutos + 1
		
		if contminutos == 60 then
			contminutos = 0
			conthoras = conthoras + 1
		end
	else 
		contminutos = 0 
		conthoras = 0
	end
	end
end)

RegisterNetEvent('jc_admin:adminstracion:entrar', function()
	administrando = true
--	print 'tu putamdre'
	TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0Has entrado ha administrar, /enviarclock cuando termines de administrar y enviaras un registro del tiempo administrado, recuerda estar al menos 2 minutos administrando para enviar el registro.'))
	TriggerServerEvent('jc_logs:log:client:administrando', '**Ha activado el clock contando tiempo de admnistración**')
end)


RegisterNetEvent('jc_admin:adminstracion:contar', function()
	if administrando then 
		if conthoras == 0 and contminutos <= 1 then -- 1 min
			TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0Tienes que estar al menos 2 minutos administrando para poder enviar el registro.'))
		else
			TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0Has enviado un registro del tiempo administrado.'))
			TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^2[^0Horas^2]:^0 '..conthoras..' ^2[^0Minutos^2]^0: ' ..contminutos))
			TriggerServerEvent('jc_logs:log:client:administrando', '**Horas**: '..conthoras..'\n**Minutos**: ' ..contminutos)
			conthoras = 0 
			contminutos = 0
		end 
	else
		TriggerEvent('chatMessage', ('^4[^1'..Setting.ServerName..'^4] || ^0No estas adminstrando para enviar un registro.'))
	end
	administrando = false
end)


RegisterNetEvent('jc_admin:repararveh', function()
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), false))
	SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)
	SetVehicleLights(GetVehiclePedIsIn(PlayerPedId(), false), 0)
	SetVehicleBurnout(GetVehiclePedIsIn(PlayerPedId(), false), false)
	Citizen.InvokeNative(0x1FD09E7390A74D54, GetVehiclePedIsIn(PlayerPedId(), false), 0)
	SetVehicleUndriveable(veh, false)
end)
