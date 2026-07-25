--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.
local license = ... or {}
local mainapi = {
	Categories = {},
	GUIColor = {
		Hue = 0.46,
		Sat = 0.96,
		Value = 0.52
	},
	HeldKeybinds = {},
	Keybind = {'RightShift'},
	Loaded = false,
	Libraries = {},
	Modules = {},
	Place = game.PlaceId,
	Profile = 'default',
	Profiles = {},
	RainbowSpeed = {Value = 1},
	RainbowUpdateSpeed = {Value = 60},
	RainbowTable = {},
	Scale = {Value = 1},
	ThreadFix = setthreadidentity and true or false,
	ToggleNotifications = {},
	Version = '6.11',
	ToggleMode = {Value = 'Toggle'},
	Windows = {}
}

local cloneref = cloneref or function(obj)
	return obj
end
local tweenService = cloneref(game:GetService('TweenService'))
local inputService = cloneref(game:GetService('UserInputService'))
local textService = cloneref(game:GetService('TextService'))
local guiService = cloneref(game:GetService('GuiService'))
local runService = cloneref(game:GetService('RunService'))
local httpService = cloneref(game:GetService('HttpService'))

local fontsize = Instance.new('GetTextBoundsParams')
fontsize.Width = math.huge
local notifications
local assetfunction = getcustomasset
local getcustomasset
local clickgui
local scaledgui
local toolblur
local tooltip
local scale
local gui

local color = {}
local tween = {
	tweens = {},
	tweenstwo = {}
}
local uipallet = {
	Main = Color3.fromRGB(26, 25, 26),
	Text = Color3.fromRGB(200, 200, 200),
	Font = Font.fromEnum(Enum.Font.Arial),
	FontSemiBold = Font.fromEnum(Enum.Font.Arial, Enum.FontWeight.SemiBold),
	Tween = TweenInfo.new(0.16, Enum.EasingStyle.Linear)
}

local getcustomassets = {
	['motionrewrite/assets/new/add.png'] = 'rbxassetid://14368300605',
	['motionrewrite/assets/new/alert.png'] = 'rbxassetid://14368301329',
	['motionrewrite/assets/new/allowedicon.png'] = 'rbxassetid://14368302000',
	['motionrewrite/assets/new/allowedtab.png'] = 'rbxassetid://14368302875',
	['motionrewrite/assets/new/arrowmodule.png'] = 'rbxassetid://14473354880',
	['motionrewrite/assets/new/back.png'] = 'rbxassetid://14368303894',
	['motionrewrite/assets/new/bind.png'] = 'rbxassetid://14368304734',
	['motionrewrite/assets/new/bindbkg.png'] = 'rbxassetid://14368305655',
	['motionrewrite/assets/new/blatanticon.png'] = 'rbxassetid://14368306745',
	['motionrewrite/assets/new/blockedicon.png'] = 'rbxassetid://14385669108',
	['motionrewrite/assets/new/blockedtab.png'] = 'rbxassetid://14385672881',
	['motionrewrite/assets/new/blur.png'] = 'rbxassetid://14898786664',
	['motionrewrite/assets/new/blurnotif.png'] = 'rbxassetid://16738720137',
	['motionrewrite/assets/new/close.png'] = 'rbxassetid://14368309446',
	['motionrewrite/assets/new/closemini.png'] = 'rbxassetid://14368310467',
	['motionrewrite/assets/new/colorpreview.png'] = 'rbxassetid://14368311578',
	['motionrewrite/assets/new/combaticon.png'] = 'rbxassetid://14368312652',
	['motionrewrite/assets/new/customsettings.png'] = 'rbxassetid://14403726449',
	['motionrewrite/assets/new/discord.png'] = '',
	['motionrewrite/assets/new/dots.png'] = 'rbxassetid://14368314459',
	['motionrewrite/assets/new/edit.png'] = 'rbxassetid://14368315443',
	['motionrewrite/assets/new/expandicon.png'] = 'rbxassetid://14368353032',
	['motionrewrite/assets/new/expandright.png'] = 'rbxassetid://14368316544',
	['motionrewrite/assets/new/expandup.png'] = 'rbxassetid://14368317595',
	['motionrewrite/assets/new/friendstab.png'] = 'rbxassetid://14397462778',
	['motionrewrite/assets/new/guisettings.png'] = 'rbxassetid://14368318994',
	['motionrewrite/assets/new/guislider.png'] = 'rbxassetid://14368320020',
	['motionrewrite/assets/new/guisliderrain.png'] = 'rbxassetid://14368321228',
	['motionrewrite/assets/new/guiv4.png'] = 'rbxassetid://105285248394660',
	['motionrewrite/assets/new/guivape.png'] = 'rbxassetid://77835130675073',
	['motionrewrite/assets/new/info.png'] = 'rbxassetid://14368324807',
	['motionrewrite/assets/new/inventoryicon.png'] = 'rbxassetid://14928011633',
	['motionrewrite/assets/new/legit.png'] = 'rbxassetid://14425650534',
	['motionrewrite/assets/new/legittab.png'] = 'rbxassetid://14426740825',
	['motionrewrite/assets/new/miniicon.png'] = 'rbxassetid://14368326029',
	['motionrewrite/assets/new/notification.png'] = 'rbxassetid://16738721069',
	['motionrewrite/assets/new/overlaysicon.png'] = 'rbxassetid://14368339581',
	['motionrewrite/assets/new/overlaystab.png'] = 'rbxassetid://14397380433',
	['motionrewrite/assets/new/pin.png'] = 'rbxassetid://14368342301',
	['motionrewrite/assets/new/profilesicon.png'] = 'rbxassetid://14397465323',
	['motionrewrite/assets/new/radaricon.png'] = 'rbxassetid://14368343291',
	['motionrewrite/assets/new/rainbow_1.png'] = 'rbxassetid://14368344374',
	['motionrewrite/assets/new/rainbow_2.png'] = 'rbxassetid://14368345149',
	['motionrewrite/assets/new/rainbow_3.png'] = 'rbxassetid://14368345840',
	['motionrewrite/assets/new/rainbow_4.png'] = 'rbxassetid://14368346696',
	['motionrewrite/assets/new/range.png'] = 'rbxassetid://14368347435',
	['motionrewrite/assets/new/rangearrow.png'] = 'rbxassetid://14368348640',
	['motionrewrite/assets/new/rendericon.png'] = 'rbxassetid://14368350193',
	['motionrewrite/assets/new/rendertab.png'] = 'rbxassetid://14397373458',
	['motionrewrite/assets/new/search.png'] = 'rbxassetid://14425646684',
	['motionrewrite/assets/new/targetinfoicon.png'] = 'rbxassetid://14368354234',
	['motionrewrite/assets/new/targetnpc1.png'] = 'rbxassetid://14497400332',
	['motionrewrite/assets/new/targetnpc2.png'] = 'rbxassetid://14497402744',
	['motionrewrite/assets/new/targetplayers1.png'] = 'rbxassetid://14497396015',
	['motionrewrite/assets/new/targetplayers2.png'] = 'rbxassetid://14497397862',
	['motionrewrite/assets/new/targetstab.png'] = 'rbxassetid://14497393895',
	['motionrewrite/assets/new/textguiicon.png'] = 'rbxassetid://14368355456',
	['motionrewrite/assets/new/textv4.png'] = 'rbxassetid://105285248394660',
	['motionrewrite/assets/new/textvape.png'] = 'rbxassetid://77835130675073',
	['motionrewrite/assets/new/utilityicon.png'] = 'rbxassetid://14368359107',
	['motionrewrite/assets/new/vape.png'] = 'rbxassetid://14373395239',
	['motionrewrite/assets/new/warning.png'] = 'rbxassetid://14368361552',
	['motionrewrite/assets/new/worldicon.png'] = 'rbxassetid://14368362492'
}

local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end

local getfontsize = function(text, size, font)
	fontsize.Text = text
	fontsize.Size = size
	if typeof(font) == 'Font' then
		fontsize.Font = font
	end
	return textService:GetTextBoundsAsync(fontsize)
end

local function addBlur(parent, notif)
	local blur = Instance.new('ImageLabel')
	blur.Name = 'Blur'
	blur.Size = UDim2.new(1, 89, 1, 52)
	blur.Position = UDim2.fromOffset(-48, -31)
	blur.BackgroundTransparency = 1
	blur.Image = getcustomasset('motionrewrite/assets/new/'..(notif and 'blurnotif' or 'blur')..'.png')
	blur.ScaleType = Enum.ScaleType.Slice
	blur.SliceCenter = Rect.new(52, 31, 261, 502)
	blur.Parent = parent

	return blur
end

local function addCorner(parent, radius)
	local corner = Instance.new('UICorner')
	corner.CornerRadius = radius or UDim.new(0, 5)
	corner.Parent = parent

	return corner
end

local function addCloseButton(parent, offset)
	local close = Instance.new('ImageButton')
	close.Name = 'Close'
	close.Size = UDim2.fromOffset(24, 24)
	close.Position = UDim2.new(1, -35, 0, offset or 9)
	close.BackgroundColor3 = Color3.new(1, 1, 1)
	close.BackgroundTransparency = 1
	close.AutoButtonColor = false
	close.Image = getcustomasset('motionrewrite/assets/new/close.png')
	close.ImageColor3 = color.Light(uipallet.Text, 0.2)
	close.ImageTransparency = 0.5
	close.Parent = parent
	addCorner(close, UDim.new(1, 0))

	close.MouseEnter:Connect(function()
		close.ImageTransparency = 0.3
		tween:Tween(close, uipallet.Tween, {
			BackgroundTransparency = 0.6
		})
	end)
	close.MouseLeave:Connect(function()
		close.ImageTransparency = 0.5
		tween:Tween(close, uipallet.Tween, {
			BackgroundTransparency = 1
		})
	end)

	return close
end

local function addMaid(object)
	object.Connections = {}
	function object:Clean(callback)
		if typeof(callback) == 'Instance' then
			table.insert(self.Connections, {
				Disconnect = function()
					callback:ClearAllChildren()
					callback:Destroy()
				end
			})
		elseif type(callback) == 'function' then
			table.insert(self.Connections, {
				Disconnect = callback
			})
		elseif type(callback) == 'thread' then
			table.insert(self.Connections, {
				Disconnect = function()
					pcall(task.cancel, callback)
				end
			})
		else
			table.insert(self.Connections, callback)
		end
	end
end

local function addTooltip(gui, text)
	if not text then return end

	local function tooltipMoved(x, y)
		local right = x + 16 + tooltip.Size.X.Offset > (scale.Scale * 1920)
		tooltip.Position = UDim2.fromOffset(
			(right and x - (tooltip.Size.X.Offset * scale.Scale) - 16 or x + 16) / scale.Scale,
			((y + 11) - (tooltip.Size.Y.Offset / 2)) / scale.Scale
		)
		tooltip.Visible = toolblur.Visible
	end

	gui.MouseEnter:Connect(function(x, y)
		local tooltipSize = getfontsize(text, tooltip.TextSize, uipallet.Font)
		tooltip.Size = UDim2.fromOffset(tooltipSize.X + 10, tooltipSize.Y + 10)
		tooltip.Text = text
		tooltipMoved(x, y)
	end)
	gui.MouseMoved:Connect(tooltipMoved)
	gui.MouseLeave:Connect(function()
		tooltip.Visible = false
	end)
end

local function checkKeybinds(compare, target, key)
	if type(target) == 'table' then
		if table.find(target, key) then
			for i, v in target do
				if not table.find(compare, v) then
					return false
				end
			end
			return true
		end
	end

	return false
end

local function createDownloader(text)
	if mainapi.Loaded ~= true then
		local downloader = mainapi.Downloader
		if not downloader and not license.Closet then
			downloader = Instance.new('TextLabel')
			downloader.Size = UDim2.new(1, 0, 0, 40)
			downloader.BackgroundTransparency = 1
			downloader.TextStrokeTransparency = 0
			downloader.TextSize = 20
			downloader.TextColor3 = Color3.new(1, 1, 1)
			downloader.FontFace = uipallet.Font
			downloader.Parent = mainapi.gui
			mainapi.Downloader = downloader
		end
		pcall(function()
			downloader.Text = 'Downloading '..text
		end)
	end
end

local function downloadFile(path, func)
	if not isfile(path) then
		createDownloader(path)
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/MaxlaserTech/CatV6/'..readfile('motionrewrite/profiles/commit.txt')..'/'..select(1, path:gsub('motionrewrite/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			error(res)
		end
		if path:find('.lua') then
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res
		end
		writefile(path, res)
	end
	return (func or readfile)(path)
end

getcustomasset = assetfunction and function(path)
	local suc, res = pcall(downloadFile, path, assetfunction)
	if suc then
		return res
	end
	return getcustomassets[path] or ''
end or function(path)
	return getcustomassets[path] or ''
end

-- Automatically download all assets defined in getcustomassets upon script execution
task.spawn(function()
	pcall(function()
		for path, _ in pairs(getcustomassets) do
			downloadFile(path)
		end
	end)
end)

local function getTableSize(tab)
	local ind = 0
	for _ in tab do ind += 1 end
	return ind
end

local function loopClean(tab)
	for i, v in tab do
		if type(v) == 'table' then
			loopClean(v)
		end
		tab[i] = nil
	end
end

local function loadJson(path)
	local suc, res = pcall(function()
		return httpService:JSONDecode(readfile(path))
	end)
	return suc and type(res) == 'table' and res or nil
end

downloadFile('motionrewrite/profiles/features.json')
local moduleData = loadJson('motionrewrite/profiles/features.json')
local newModules = moduleData.new or {}
local updModules = moduleData.updated or {}
local function makeDraggable(gui, window)
	gui.InputBegan:Connect(function(inputObj)
		if window and not window.Visible then return end
		if
			(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
			and (inputObj.Position.Y - gui.AbsolutePosition.Y < 40 or window)
		then
			local dragPosition = Vector2.new(
				gui.AbsolutePosition.X - inputObj.Position.X,
				gui.AbsolutePosition.Y - inputObj.Position.Y + guiService:GetGuiInset().Y
			) / scale.Scale

			local changed = inputService.InputChanged:Connect(function(input)
				if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
					local position = input.Position
					if inputService:IsKeyDown(Enum.KeyCode.LeftShift) then
						dragPosition = (dragPosition // 3) * 3
						position = (position // 3) * 3
					end
					gui.Position = UDim2.fromOffset((position.X / scale.Scale) + dragPosition.X, (position.Y / scale.Scale) + dragPosition.Y)
				end
			end)

			local ended
			ended = inputObj.Changed:Connect(function()
				if inputObj.UserInputState == Enum.UserInputState.End then
					if changed then
						changed:Disconnect()
					end
					if ended then
						ended:Disconnect()
					end
				end
			end)
		end
	end)
end

local function randomString()
	local array = {}
	for i = 1, math.random(10, 100) do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local function removeTags(str)
	str = str:gsub('<br%s*/>', '\n')
	return str:gsub('<[^<>]->', '')
end

do
	local res = isfile('motionrewrite/profiles/color.txt') and loadJson('motionrewrite/profiles/color.txt')
	if res then
		uipallet.Main = res.Main and Color3.fromRGB(unpack(res.Main)) or uipallet.Main
		uipallet.Text = res.Text and Color3.fromRGB(unpack(res.Text)) or uipallet.Text
		uipallet.Font = res.Font and Font.new(
			res.Font:find('rbxasset') and res.Font
			or string.format('rbxasset://fonts/families/%s.json', res.Font)
		) or uipallet.Font
		uipallet.FontSemiBold = Font.new(uipallet.Font.Family, Enum.FontWeight.SemiBold)
	end
	fontsize.Font = uipallet.Font
end

do
	function color.Dark(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, uipallet.Main:ToHSV()) > 0.5 and v + num or v - num, 0, 1))
	end

	function color.Light(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, uipallet.Main:ToHSV()) > 0.5 and v - num or v + num, 0, 1))
	end

	function mainapi:Color(h)
		local s = 0.75 + (0.15 * math.min(h / 0.03, 1))
		if h > 0.57 then
			s = 0.9 - (0.4 * math.min((h - 0.57) / 0.09, 1))
		end
		if h > 0.66 then
			s = 0.5 + (0.4 * math.min((h - 0.66) / 0.16, 1))
		end
		if h > 0.87 then
			s = 0.9 - (0.15 * math.min((h - 0.87) / 0.13, 1))
		end
		return h, s, 1
	end

	function mainapi:TextColor(h, s, v)
		if v >= 0.7 and (s < 0.6 or h > 0.04 and h < 0.56) then
			return Color3.new(0.19, 0.19, 0.19)
		end
		return Color3.new(1, 1, 1)
	end
end

do
	function tween:Tween(obj, tweeninfo, goal, tab)
		tab = tab or self.tweens
		if tab[obj] then
			tab[obj]:Cancel()
			tab[obj] = nil
		end

		if obj.Parent and obj.Visible then
			tab[obj] = tweenService:Create(obj, tweeninfo, goal)
			tab[obj].Completed:Once(function()
				if tab then
					tab[obj] = nil
					tab = nil
				end
			end)
			tab[obj]:Play()
		else
			for i, v in goal do
				obj[i] = v
			end
		end
	end

	function tween:Cancel(obj)
		if self.tweens[obj] then
			self.tweens[obj]:Cancel()
			self.tweens[obj] = nil
		end
	end
end

mainapi.Libraries = {
	color = color,
	getcustomasset = getcustomasset,
	getfontsize = getfontsize,
	tween = tween,
	uipallet = uipallet,
}
