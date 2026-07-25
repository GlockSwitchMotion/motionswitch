local license = ... or {}
license.Key = script_key or license.Key or nil
local Loaded = game:IsLoaded()
if not Loaded then
	repeat task.wait() until game:IsLoaded()
	task.wait(5)
end
if shared.vape then shared.vape:Uninject() end

local vape
local loadstring = function(...)
	local res, err = loadstring(...)
	if err and vape then
		vape:CreateNotification('MotionSwitch', 'Failed to load : '..err, 30, 'alert')
	end
	return res
end
local queue_on_teleport = queue_on_teleport or function() end
local clear_teleport_queue = clear_teleport_queue or clearteleportqueue or function() end
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
local cloneref = cloneref or function(obj)
	return obj
end
local playersService = cloneref(game:GetService('Players'))
local httpService = cloneref(game:GetService('HttpService'))

local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/GlockSwitchMotion/motionswitch/'..readfile('motionswitch/profiles/commit.txt')..'/'..select(1, path:gsub('motionswitch/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			task.spawn(error, res)
		end
		if suc then
			if path:find('.lua') then
				res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after updates.\n'..res
			end
			writefile(path, res)
		end
	end
	return (func or readfile)(path)
end

local function finishLoading()
	vape.Init = nil
	vape:Load()
	task.spawn(function()
		repeat
			vape:Save()
			task.wait(10)
		until not vape.Loaded
	end)

	local teleportedServers
	(function()
		if (not shared.VapeIndependent) then
			teleportedServers = true
			local teleportScript = [[
				shared.vapereload = true
				if shared.VapeDeveloper then
					loadstring(readfile('motionswitch/main.lua'), 'main')(_scriptconfig)
				end
			]]
			local teleportConfig = httpService:JSONEncode(license)
			teleportConfig = teleportConfig:gsub('":true', "=true"):gsub('{"', '{')
			teleportConfig = teleportConfig:gsub(',"', ','):gsub('":', '=')
			teleportConfig = teleportConfig:gsub('%[', '{'):gsub('%]', '}')
			teleportScript = teleportScript:gsub('_key', tostring(license.Key or '_key'))
			teleportScript = teleportScript:gsub('_scriptconfig', teleportConfig)
			if identifyexecutor() == 'Potassium' then
				teleportScript = 'task.wait(12)\n'.. teleportScript
			end
			if shared.VapeDeveloper then
				teleportScript = 'shared.VapeDeveloper = true\n'..teleportScript
			end
			if shared.VapeCustomProfile then
				teleportScript = 'shared.VapeCustomProfile = "'..shared.VapeCustomProfile..'"\n'..teleportScript
			end
			queue_on_teleport(teleportScript)
		end
	end)()

	if not vape.Categories then return end
	if vape.Categories.Main.Options['GUI bind indicator'].Enabled then
		if not shared.vapereload then
			vape:CreateNotification('Finished Loading', (vape.VapeButton and 'Press the button in the top right' or 'Press '..table.concat(vape.Keybind, ' + '):upper())..' to open GUI', 5)
			task.delay(0.05 + cloneref(game:GetService('RunService')).PostSimulation:Wait(), function()
				if shared.updated then
					vape:CreateNotification('MotionSwitch', `Script has updated from {shared.updated} to {readfile('motionswitch/profiles/commit.txt')}`, 10, 'info')
				end
			end)
		end
	end
end

if not isfile('motionswitch/profiles/gui.txt') then
	writefile('motionswitch/profiles/gui.txt', 'new')
end
local gui = 'new'

if not isfolder('motionswitch/assets/'..gui) then
	makefolder('motionswitch/assets/'..gui)
end
if not isfile('motionswitch/profiles/commit.txt') then
	writefile('motionswitch/profiles/commit.txt', 'main')
end

getgenv().used_init = true
vape = loadstring(downloadFile('motionswitch/guis/'..gui..'.lua'), 'gui')(license)
_G.vape = vape
shared.vape = vape
shared.vapesmooth = true

if not shared.VapeIndependent then
	loadstring(downloadFile('motionswitch/games/universal.lua'), 'universal')(license)
	if isfile('motionswitch/games/'..game.PlaceId..'.lua') then
		loadstring(readfile('motionswitch/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(license)
	else
		if not shared.VapeDeveloper then
			local suc, res = pcall(function()
				return game:HttpGet('https://raw.githubusercontent.com/GlockSwitchMotion/motionswitch/'..readfile('motionswitch/profiles/commit.txt')..'/games/'..game.PlaceId..'.lua', true)
			end)
			if suc and res ~= '404: Not Found' then
				loadstring(downloadFile('motionswitch/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(license)
			end
		end
	end
	if vape.ThreadFix then
		setthreadidentity(8)
	end
	loadstring(downloadFile('motionswitch/libraries/premium.lua'), 'premium')(license)
	finishLoading()
else
	vape.Init = finishLoading
	return vape
end
