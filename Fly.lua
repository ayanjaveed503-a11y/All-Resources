-- Smooth Unfrozen Fly GUI (Extra Compact + ✈️ Background + 🔒/🔓 Emoji + PC & All Executors)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local flying = false
local guiLocked = false

-- Default Speeds (Custom speed box se live change honge)
local baseSpeed = 52
local flySpeed = 52
local strafeSpeed = 68
local verticalSpeed = 45
local smoothness = 12

local bodyGyro, bodyVel
local currentVel = Vector3.zero

local function getRootAndHum()
	local char = player.Character
	if not char then return nil, nil end
	return char:FindFirstChild("HumanoidRootPart"), char:FindFirstChildOfClass("Humanoid")
end

local function startFly()
	local root, hum = getRootAndHum()
	if not root or not hum then return end

	flying = true
	hum.PlatformStand = false
	currentVel = root.AssemblyLinearVelocity

	if bodyGyro then bodyGyro:Destroy() end
	if bodyVel then bodyVel:Destroy() end

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.P = 3500
	bodyGyro.D = 350
	bodyGyro.MaxTorque = Vector3.new(0, 9e5, 0)
	bodyGyro.CFrame = root.CFrame
	bodyGyro.Parent = root

	bodyVel = Instance.new("BodyVelocity")
	bodyVel.Velocity = currentVel
	bodyVel.MaxForce = Vector3.new(9e5, 9e5, 9e5)
	bodyVel.Parent = root
end

local function stopFly()
	flying = false
	currentVel = Vector3.zero
	if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
	if bodyVel then bodyVel:Destroy() bodyVel = nil end

	local _, hum = getRootAndHum()
	if hum then
		hum.PlatformStand = false
		hum:ChangeState(Enum.HumanoidStateType.Freefall)
	end
end

-- Parent helper for cross-executor compatibility
local function getGuiParent()
	local ok, coreGui = pcall(function()
		return game:GetService("CoreGui")
	end)
	if ok and coreGui then
		local testOk = pcall(function()
			local f = Instance.new("Folder")
			f.Parent = coreGui
			f:Destroy()
		end)
		if testOk then return coreGui end
	end
	return player:WaitForChild("PlayerGui")
end

local parentTarget = getGuiParent()
if parentTarget:FindFirstChild("FlyCardGui") then
	parentTarget.FlyCardGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "FlyCardGui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = parentTarget

-- Extra Compact Main Card (Aur chota size)
local mainCard = Instance.new("Frame")
mainCard.Name = "MainCard"
mainCard.Size = UDim2.new(0, 58, 0, 102)
mainCard.Position = UDim2.new(0.80, 0, 0.25, 0)
mainCard.BackgroundColor3 = Color3.fromRGB(43, 38, 40)
mainCard.BackgroundTransparency = 0.08
mainCard.BorderSizePixel = 0
mainCard.Active = true
mainCard.Parent = gui

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 12)
cardCorner.Parent = mainCard

local cardStroke = Instance.new("UIStroke")
cardStroke.Color = Color3.fromRGB(255, 255, 255)
cardStroke.Transparency = 0.88
cardStroke.Thickness = 1
cardStroke.Parent = mainCard

-- Background ✈️ Emoji inside Card
local bgPlaneEmoji = Instance.new("TextLabel")
bgPlaneEmoji.Name = "BackgroundPlaneEmoji"
bgPlaneEmoji.Size = UDim2.new(1, 0, 1, 0)
bgPlaneEmoji.Position = UDim2.new(0, 0, 0, -4)
bgPlaneEmoji.BackgroundTransparency = 1
bgPlaneEmoji.Text = "✈️"
bgPlaneEmoji.TextScaled = true
bgPlaneEmoji.TextTransparency = 0.72
bgPlaneEmoji.Font = Enum.Font.GothamBold
bgPlaneEmoji.ZIndex = 1
bgPlaneEmoji.Parent = mainCard

-- Top Label: "Shift F"
local topHint = Instance.new("TextLabel")
topHint.Name = "ShiftFLabel"
topHint.Size = UDim2.new(1, -2, 0, 15)
topHint.Position = UDim2.new(0, 1, 0, 3)
topHint.BackgroundTransparency = 1
topHint.Text = "Shift F"
topHint.TextColor3 = Color3.fromRGB(185, 175, 178)
topHint.Font = Enum.Font.GothamBold
topHint.TextSize = 10
topHint.ZIndex = 2
topHint.Parent = mainCard

-- Middle Toggle Button (Status Dot)
local flyToggleBtn = Instance.new("TextButton")
flyToggleBtn.Name = "FlyToggle"
flyToggleBtn.Size = UDim2.new(1, -6, 0, 48)
flyToggleBtn.Position = UDim2.new(0, 3, 0, 20)
flyToggleBtn.BackgroundTransparency = 1
flyToggleBtn.Text = ""
flyToggleBtn.AutoButtonColor = false
flyToggleBtn.ZIndex = 3
flyToggleBtn.Parent = mainCard

local statusDot = Instance.new("Frame")
statusDot.Name = "StatusDot"
statusDot.Size = UDim2.new(0, 10, 0, 10)
statusDot.Position = UDim2.new(0.5, -5, 0.5, -5)
statusDot.BackgroundColor3 = Color3.fromRGB(120, 120, 125)
statusDot.BorderSizePixel = 0
statusDot.ZIndex = 3
statusDot.Parent = flyToggleBtn

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = statusDot

-- Bottom Custom Speed Box
local speedBox = Instance.new("TextBox")
speedBox.Name = "SpeedBox"
speedBox.Size = UDim2.new(1, -8, 0, 20)
speedBox.Position = UDim2.new(0, 4, 1, -24)
speedBox.BackgroundColor3 = Color3.fromRGB(24, 21, 23)
speedBox.BorderSizePixel = 0
speedBox.Text = tostring(baseSpeed)
speedBox.PlaceholderText = "Speed"
speedBox.TextColor3 = Color3.fromRGB(245, 245, 245)
speedBox.PlaceholderColor3 = Color3.fromRGB(135, 130, 132)
speedBox.Font = Enum.Font.GothamBold
speedBox.TextSize = 10
speedBox.ClearTextOnFocus = false
speedBox.ZIndex = 3
speedBox.Parent = mainCard

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 6)
speedCorner.Parent = speedBox

local speedStroke = Instance.new("UIStroke")
speedStroke.Color = Color3.fromRGB(255, 255, 255)
speedStroke.Transparency = 0.85
speedStroke.Thickness = 1
speedStroke.Parent = speedBox

-- Top-Right Compact Lock / Unlock Emoji Button (🔒 / 🔓)
local lockBtn = Instance.new("TextButton")
lockBtn.Name = "LockButton"
lockBtn.Size = UDim2.new(0, 20, 0, 20)
lockBtn.Position = UDim2.new(1, -8, 0, -8)
lockBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
lockBtn.BorderSizePixel = 0
lockBtn.Text = "🔓"
lockBtn.TextSize = 10
lockBtn.Font = Enum.Font.GothamBold
lockBtn.ZIndex = 5
lockBtn.Parent = mainCard

local lockCorner = Instance.new("UICorner")
lockCorner.CornerRadius = UDim.new(1, 0)
lockCorner.Parent = lockBtn

local function updateVisualState()
	if flying then
		statusDot.BackgroundColor3 = Color3.fromRGB(45, 215, 95)
		bgPlaneEmoji.TextTransparency = 0.45
	else
		statusDot.BackgroundColor3 = Color3.fromRGB(120, 120, 125)
		bgPlaneEmoji.TextTransparency = 0.72
	end

	if guiLocked then
		lockBtn.Text = "🔒"
		cardStroke.Color = Color3.fromRGB(255, 195, 55)
		cardStroke.Transparency = 0.55
	else
		lockBtn.Text = "🔓"
		cardStroke.Color = Color3.fromRGB(255, 255, 255)
		cardStroke.Transparency = 0.88
	end
end

local function toggleFly()
	if flying then
		stopFly()
	else
		startFly()
	end
	updateVisualState()
end

flyToggleBtn.MouseButton1Click:Connect(toggleFly)

lockBtn.MouseButton1Click:Connect(function()
	guiLocked = not guiLocked
	updateVisualState()
end)

-- Custom Speed Input Handler
local function applySpeed(val)
	local num = tonumber(val)
	if num then
		num = math.clamp(num, 5, 500)
		baseSpeed = num
		flySpeed = num
		strafeSpeed = math.round(num * 1.3)
		verticalSpeed = math.round(num * 0.86)
		speedBox.Text = tostring(num)
	else
		speedBox.Text = tostring(baseSpeed)
	end
end

speedBox.FocusLost:Connect(function()
	applySpeed(speedBox.Text)
end)

-- PC Shortcut: Shift + F
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
		toggleFly()
	end
end)

-- Smooth Dragging (Stops completely when guiLocked == true)
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

mainCard.InputBegan:Connect(function(input)
	if guiLocked then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainCard.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainCard.InputChanged:Connect(function(input)
	if guiLocked then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if guiLocked or not dragging then return end
	if input == dragInput then
		local delta = input.Position - dragStart
		mainCard.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

updateVisualState()

-- Fly Movement Loop (Unfrozen + Side Speed + Backward Pull-Up)
RunService.RenderStepped:Connect(function(dt)
	if not flying then return end
	local root, hum = getRootAndHum()
	local cam = workspace.CurrentCamera
	if not root or not hum or not cam or not bodyGyro or not bodyVel then return end

	local moveDir = hum.MoveDirection
	local targetVel = Vector3.zero

	if moveDir.Magnitude > 0 then
		local forward = cam.CFrame.LookVector
		local flatForward = Vector3.new(forward.X, 0, forward.Z)
		if flatForward.Magnitude > 0 then flatForward = flatForward.Unit end

		local right = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
		if right.Magnitude > 0 then right = right.Unit end

		local forwardInput = moveDir:Dot(flatForward)
		local rightInput = moveDir:Dot(right)

		local yVel = 0

		if forwardInput < -0.05 then
			local pullBackAmount = math.abs(forwardInput)
			local camLiftFactor = math.clamp(0.65 + math.max(forward.Y, 0), 0.65, 1.5)
			yVel = yVel + (pullBackAmount * verticalSpeed * camLiftFactor)
		elseif forwardInput > 0.05 then
			yVel = yVel + (forward.Y * forwardInput * verticalSpeed)
		end

		targetVel = (flatForward * forwardInput * flySpeed)
			+ (right * rightInput * strafeSpeed)
			+ Vector3.new(0, yVel, 0)
	end

	if hum.Jump then
		targetVel = targetVel + Vector3.new(0, verticalSpeed, 0)
	end

	local alpha = math.clamp(dt * smoothness, 0, 1)
	currentVel = currentVel:Lerp(targetVel, alpha)
	bodyVel.Velocity = currentVel

	local lookFlat = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
	if lookFlat.Magnitude > 0.01 then
		local targetCFrame = CFrame.lookAt(root.Position, root.Position + lookFlat)
		bodyGyro.CFrame = bodyGyro.CFrame:Lerp(targetCFrame, math.clamp(dt * (smoothness * 1.2), 0, 1))
	end
end)
