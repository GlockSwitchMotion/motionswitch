--!nocheck
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

local cloneref = cloneref or function(obj) return obj end
local inputService = cloneref(game:GetService('UserInputService'))
local gui

local color = {}
local tween = { tweens = {}, tweenstwo = {} }
local uipallet = {
	Main = Color3.fromRGB(26, 25, 26),
	Text = Color3.fromRGB(200, 200, 200),
	Font = Font.fromEnum(Enum.Font.Arial),
	FontSemiBold = Font.fromEnum(Enum.Font.Arial, Enum.FontWeight.SemiBold),
	Tween = TweenInfo.new(0.16, Enum.EasingStyle.Linear)
}

local getcustomassets = {
	['motionswitch/assets/new/close.png'] = 'rbxassetid://14368309446',
	['motionswitch/assets/new/blur.png'] = 'rbxassetid://14898786664',
	['motionswitch/assets/new/blurnotif.png'] = 'rbxassetid://16738720137'
}

local function addCorner(parent, radius)
	local corner = Instance.new('UICorner')
	corner.CornerRadius = radius or UDim.new(0, 5)
	corner.Parent = parent
	return corner
end

function mainapi:CreateNotification(title, text, duration, notiftype)
	local notif = Instance.new('TextLabel')
	notif.Size = UDim2.fromOffset(200, 45)
	notif.Position = UDim2.new(1, -210, 1, -60)
	notif.BackgroundColor3 = uipallet.Main
	notif.TextColor3 = uipallet.Text
	notif.Text = '['..title..'] '..text
	notif.TextScaled = true
	notif.FontFace = uipallet.FontSemiBold
	notif.Parent = gui
	addCorner(notif, UDim.new(0, 6))
	
	task.delay(duration or 3, function()
		pcall(function() notif:Destroy() end)
	end)
end

function mainapi:Load()
	if self.Loaded then return end
	self.Loaded = true

	local screengui = Instance.new('ScreenGui')
	screengui.Name = 'MotionSwitchGUI'
	screengui.ResetOnSpawn = false
	screengui.Parent = gethui and gethui() or cloneref(game:GetService('CoreGui'))
	gui = screengui
	self.gui = screengui

	local mainFrame = Instance.new('Frame')
	mainFrame.Name = 'MainFrame'
	mainFrame.Size = UDim2.fromOffset(450, 320)
	mainFrame.Position = UDim2.fromScale(0.35, 0.3)
	mainFrame.BackgroundColor3 = uipallet.Main
	mainFrame.BorderSizePixel = 0
	mainFrame.Visible = true
	mainFrame.Parent = screengui
	addCorner(mainFrame, UDim.new(0, 8))

	local titleLabel = Instance.new('TextLabel')
	titleLabel.Size = UDim2.new(1, 0, 0, 35)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = '  MotionSwitch'
	titleLabel.TextColor3 = uipallet.Text
	titleLabel.FontFace = uipallet.FontSemiBold
	titleLabel.TextSize = 16
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = mainFrame

	inputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed then
			if input.KeyCode == Enum.KeyCode.RightShift then
				mainFrame.Visible = not mainFrame.Visible
			end
		end
	end)
end

function mainapi:Save()
end

mainapi.Libraries = {
	color = color,
	tween = tween,
	uipallet = uipallet,
}

return mainapi
