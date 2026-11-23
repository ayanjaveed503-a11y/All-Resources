-- // AYAN 🔥 EMOTES (Glass Edition)
-- // Main GUI Background (83861593210689) + Square Freeze Button Image (120137227812230) + Toggle Sound (4483362458)

local v8 = setmetatable({}, {
	["__index"] = function(v351, v352)
		local v353 = workspace.CurrentCamera
		local v354 = (v353 and v353.ViewportSize) or Vector2.new(4156 - 2236, 2163 - (286 + 797))
		if v352 == "Width" then
			return v354.X
		elseif v352 == "Height" then
			return v354.Y
		elseif v352 == "Size" then
			return v354
		end
	end,
})
local v9 = game:GetService("UserInputService")
local v10 = workspace.CurrentCamera.ViewportSize
local function v11(v355, v356)
	local v357 = 0 - 0
	local v358
	local v359
	local v360
	local v361
	local v362
	while true do
		if v357 == (0 - 0) then
			v358 = 439 - (397 + 42)
			v359 = nil
			v357 = 1 + 0
		end
		if v357 == (802 - (24 + 776)) then
			v362 = nil
			while true do
				if v358 == 1 then
					v362 = (v359 and (2 - 0)) or (786.5 - (222 + 563))
					if v355 == "X" then
						return v356 * (v10.X / v360) * v362
					elseif v355 == "Y" then
						return v356 * (v10.Y / v361) * v362
					end
					break
				end
				if v358 == 0 then
					v359 = v9.TouchEnabled and not v9.KeyboardEnabled
					v360, v361 = 1920, 2379 - 1299
					v358 = 1 + 0
				end
			end
			break
		end
		if v357 == 1 then
			v360 = nil
			v361 = nil
			v357 = 192 - (23 + 167)
		end
	end
end
local function v12(v363, v364, v365)
	local v366 = 1798 - (690 + 1108)
	local v367
	while true do
		if v366 == (0 + 0) then
			v367 = 0 + 0
			while true do
				if v367 == (848 - (40 + 808)) then
					if type(v364) == v363 then
						return v364
					end
					return v365
				end
			end
			break
		end
	end
end
local v13 = v12("function", cloneref, function(...)
	return ...
end)
local v14 = setmetatable({}, {
	["__index"] = function(v368, v369)
		return v13(game:GetService(v369))
	end,
})
local v15 = v14.Players
local v16 = v14.RunService
local v17 = v14.UserInputService
local v18 = v14.TweenService
local v19 = v14.AvatarEditorService
local v20 = v14.HttpService
local v21 = v15.LocalPlayer
local v22 = v21.Character or v21.CharacterAdded:Wait()
local v23 = v22:WaitForChild("Humanoid")
local v24 = v23.RigType == Enum.HumanoidRigType.R6
local v25 = (v22.PrimaryPart and v22.PrimaryPart.Position) or Vector3.new()
local v26, v27, v28, v29, v30

v21.CharacterAdded:Connect(function(v370)
	local v371 = 0 + 0
	while true do
		if 1 == v371 then
			v24 = v23.RigType == Enum.HumanoidRigType.R6
			if v26 then
				v26.Text = (v24 and "⚡ AYANUU 🔥 EMOTES (R6) | PREMIUM EDITION ⚡") or "⚡ AYANUU 🔥 EMOTES |  PREMIUM EDITION ⚡"
			end
			v371 = 7 - 5
		end
		if v371 == (2 + 0) then
			if v27 then
				v27.Text = (v24 and "Anim") or "Catalog"
			end
			if v28 then
				v28.Visible = not v24
			end
			v371 = 3
		end
		if v371 == (2 + 1) then
			if v24 and v29 and v30 then
				local v726 = 0 + 0
				while true do
					if v726 == (572 - (47 + 524)) then
						v27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						v28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						break
					end
					if v726 == (0 - 0) then
						v29.Visible = true
						v30.Visible = false
						v726 = 1
					end
				end
			end
			v25 = (v22.PrimaryPart and v22.PrimaryPart.Position) or Vector3.new()
			break
		end
		if v371 == (1726 - (1165 + 561)) then
			v22 = v370
			v23 = v370:WaitForChild("Humanoid")
			v371 = 1
		end
	end
end)

local v31 = {}
v31["Stop Emote When Moving"] = true
v31["Fade In"] = 0.1
v31["Fade Out"] = 0.1 + 0
v31["Weight"] = 3 - 2
v31["Speed"] = 1 + 0
v31["Time Position"] = 0
v31["Freeze On Finish"] = false
v31["Looped"] = true
v31["Stop Other Animations On Play"] = true
v31["High Priority"] = true
v31["Do you want emote freeze button"] = false

local v48 = v14.CoreGui
local soundParent = (gethui and gethui()) or v48
local optionToggleSound = Instance.new("Sound")
optionToggleSound.Name = "AyanEmoteToggleSound"
optionToggleSound.SoundId = "rbxassetid://4483362458"
optionToggleSound.Volume = 0.8
optionToggleSound.Parent = soundParent

local function playOptionSound()
	pcall(function()
		optionToggleSound.TimePosition = 0
		optionToggleSound:Play()
	end)
end

local emoteFrozen = false
local savedSpeedBeforeFreeze = nil
local freezeBtnRef = nil
local freezeSquareBtnRef = nil
local freezeSquareLabelRef = nil
local freezeSquareGuiRef = nil
local v46 = nil

local function updateFreezeSquareVisibility()
	if freezeSquareGuiRef then
		freezeSquareGuiRef.Enabled = v31["Do you want emote freeze button"] == true
	end
end

local function setEmoteFreezeState(shouldFreeze)
	emoteFrozen = shouldFreeze
	if emoteFrozen then
		if savedSpeedBeforeFreeze == nil then
			savedSpeedBeforeFreeze = v31["Speed"]
		end
		if v46 and v46.IsPlaying then
			pcall(function()
				v46:AdjustSpeed(0)
			end)
		end
		if freezeBtnRef then
			freezeBtnRef.Text = "▶"
			freezeBtnRef.BackgroundColor3 = Color3.fromRGB(250, 204, 21)
		end
		if freezeSquareLabelRef then
			freezeSquareLabelRef.Text = "ON"
			freezeSquareLabelRef.TextColor3 = Color3.fromRGB(74, 222, 128)
		end
		if freezeSquareBtnRef then
			freezeSquareBtnRef.BackgroundColor3 = Color3.fromRGB(22, 101, 52)
		end
	else
		local targetSpeed = savedSpeedBeforeFreeze or v31["Speed"] or 1
		savedSpeedBeforeFreeze = nil
		if v46 and v46.IsPlaying then
			pcall(function()
				v46:AdjustSpeed(targetSpeed)
			end)
		end
		if freezeBtnRef then
			freezeBtnRef.Text = "⏸"
			freezeBtnRef.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
		end
		if freezeSquareLabelRef then
			freezeSquareLabelRef.Text = "OFF"
			freezeSquareLabelRef.TextColor3 = Color3.fromRGB(248, 113, 113)
		end
		if freezeSquareBtnRef then
			freezeSquareBtnRef.BackgroundColor3 = Color3.fromRGB(127, 29, 29)
		end
	end
end

local v42 = {}
local v43 = "ORIONEXE_Saved.json"
local function v44()
	local v372, v373 = pcall(function()
		local v569 = 0
		while true do
			if v569 == (479 - (341 + 138)) then
				local v708 = 0 + 0
				while true do
					if v708 == (0 - 0) then
						if readfile and isfile and isfile(v43) then
							return v20:JSONDecode(readfile(v43))
						end
						return {}
					end
				end
			end
		end
	end)
	if v372 and (type(v373) == "table") then
		v42 = v373
	else
		v42 = {}
	end
	for v570, v571 in ipairs(v42) do
		local v572 = 326 - (89 + 237)
		while true do
			if (0 - 0) == v572 then
				if not v571.AnimationId then
					if v571.AssetId then
						v571.AnimationId = "rbxassetid://" .. tostring(v571.AssetId)
					else
						v571.AnimationId = "rbxassetid://" .. tostring(v571.Id)
					end
				end
				if v571.Favorite == nil then
					v571.Favorite = false
				end
				break
			end
		end
	end
end
local function v45()
	pcall(function()
		if writefile then
			writefile(v43, v20:JSONEncode(v42))
		end
	end)
end
v44()

local function v47(v374)
	local v375 = 0 - 0
	local v376
	local v377
	local v378
	local v379
	local v380
	local v381
	local v382
	while true do
		if v375 == (883 - (581 + 300)) then
			v380.Priority = v381
			v382 = v31["Weight"]
			if v382 == (1220 - (855 + 365)) then
				v382 = 0.001 - 0
			end
			if v31["Stop Other Animations On Play"] then
				for v769, v770 in pairs(v23.Animator:GetPlayingAnimationTracks()) do
					if v770.Priority ~= v381 then
						v770:Stop()
					end
				end
			end
			v375 = 1 + 2
		end
		if (1238 - (1030 + 205)) == v375 then
			local playSpeed = emoteFrozen and 0 or v31["Speed"]
			v380:Play(v31["Fade In"], v382, playSpeed)
			v46 = v380
			v46.TimePosition = math.clamp(v31["Time Position"], 0 + 0, 1) * (v46.Length or (1 + 0))
			v46.Priority = v381
			v375 = 290 - (156 + 130)
		end
		if v375 == (8 - 4) then
			v46.Looped = v31["Looped"]
			return v380
		end
		if v375 == (1 - 0) then
			v379 = Instance.new("Animation")
			v379.AnimationId = v376
			v380 = v23:LoadAnimation(v379)
			v381 = (v31["High Priority"] and Enum.AnimationPriority.Action4) or Enum.AnimationPriority.Action
			v375 = 3 - 1
		end
		if (0 + 0) == v375 then
			if v46 then
				v46:Stop(v31["Fade Out"])
			end
			v376 = nil
			v377, v378 = pcall(function()
				return game:GetObjects("rbxassetid://" .. tostring(v374))
			end)
			if v377 and v378 and (#v378 > (0 + 0)) then
				local v727 = 0
				local v728
				while true do
					if v727 == (69 - (10 + 59)) then
						v728 = v378[1 + 0]
						if v728:IsA("Animation") then
							v376 = v728.AnimationId
						else
							v376 = "rbxassetid://" .. tostring(v374)
						end
						break
					end
				end
			else
				v376 = "rbxassetid://" .. tostring(v374)
			end
			v375 = 4 - 3
		end
	end
end

v16.RenderStepped:Connect(function()
	local v383 = 0
	while true do
		if 0 == v383 then
			if v31["Looped"] and v46 and v46.IsPlaying then
				v46.Looped = v31["Looped"]
			end
			if emoteFrozen and v46 and v46.IsPlaying then
				pcall(function()
					v46:AdjustSpeed(0)
				end)
			end
			if v22:FindFirstChild("HumanoidRootPart") then
				local v731 = 0
				local v732
				while true do
					if v731 == (1163 - (671 + 492)) then
						v732 = v22.HumanoidRootPart
						if v31["Stop Emote When Moving"] and v46 and v46.IsPlaying then
							local v901 = 0 + 0
							local v902
							local v903
							local v904
							while true do
								if (1216 - (369 + 846)) == v901 then
									v904 = nil
									while true do
										if v902 == (1 + 0) then
											if v903 or v904 then
												local v955 = 0 + 0
												while true do
													if v955 == 0 then
														v46:Stop(v31["Fade Out"])
														v46 = nil
														setEmoteFreezeState(false)
														break
													end
												end
											end
											break
										end
										if v902 == (1945 - (1036 + 909)) then
											v903 = (v732.Position - v25).Magnitude > 0.1
											v904 = v23 and (v23:GetState() == Enum.HumanoidStateType.Jumping)
											v902 = 1 + 0
										end
									end
									break
								end
								if 0 == v901 then
									v902 = 0
									v903 = nil
									v901 = 1 - 0
								end
							end
						end
						v731 = 204 - (11 + 192)
					end
					if v731 == 1 then
						v25 = v732.Position
						break
					end
				end
			end
			break
		end
	end
end)

local v49 = Instance.new("ScreenGui")
v49.Name = "OrionExeGUI_iOSGlass"
v49.Parent = soundParent
v49.Enabled = false
v49.ResetOnSpawn = false
v49.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
v49.DisplayOrder = 505 + 494

local function v54(v384, v385)
	local v386 = 175 - (135 + 40)
	local v387
	while true do
		local v573 = 0 - 0
		while true do
			if v573 == (0 + 0) then
				if v386 == (2 - 1) then
					v387.Parent = v384
					return v387
				end
				if v386 == (0 - 0) then
					v387 = Instance.new("UICorner")
					v387.CornerRadius = UDim.new(176 - (50 + 126), v385 or (16 - 10))
					v386 = 1 + 0
				end
				break
			end
		end
	end
end

local function v55(v388, v389, v390)
	local v391 = 1413 - (1233 + 180)
	local v392
	while true do
		local v574 = 969 - (522 + 447)
		while true do
			if v574 == (1422 - (107 + 1314)) then
				if v391 == 0 then
					v392 = Instance.new("UIStroke")
					v392.Color = v389 or Color3.fromRGB(255, 255, 255)
					v391 = 1
				end
				break
			end
			if v574 == 0 then
				if (5 - 3) == v391 then
					local v774 = 0 + 0
					while true do
						if v774 == 0 then
							v392.Parent = v388
							return v392
						end
					end
				end
				if v391 == 1 then
					v392.Thickness = v390 or (1 - 0)
					v392.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					v391 = 2
				end
				v574 = 3 - 2
			end
		end
	end
end

local function v56(v393)
	local v394 = 1910 - (716 + 1194)
	local v395
	while true do
		if v394 == (0 + 0) then
			local v615 = 0
			while true do
				if v615 == (1 + 0) then
					v394 = 504 - (74 + 429)
					break
				end
				if v615 == 0 then
					v395 = Instance.new("UIScale")
					v395.Scale = 0.5 - 0
					v615 = 1 + 0
				end
			end
		end
		if v394 == (2 - 1) then
			v395.Parent = v393
			v18:Create(
				v395,
				TweenInfo.new(0.4 + 0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ ["Scale"] = 2 - 1 }
			):Play()
			break
		end
	end
end

-- iOS Glass Main Container
local v57 = Instance.new("Frame")
v57.Size = UDim2.new(0 - 0, v11("X", 540), 0, v11("Y", 440))
v57.Position = UDim2.new(0.5, -v11("X", 270), 0.5, -v11("Y", 220))
v57.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
v57.BackgroundTransparency = 0.25
v57.BorderSizePixel = 0
v57.ClipsDescendants = true
v57.Active = true
v57.Draggable = true
v57.Parent = v49
v54(v57, 22)
local mainGlassStroke = v55(v57, Color3.fromRGB(180, 200, 255), 1.8)
mainGlassStroke.Transparency = 0.35

-- Main GUI Background Image (83861593210689)
local mainBgImage = Instance.new("ImageLabel")
mainBgImage.Name = "MainGuiBackgroundImage"
mainBgImage.Size = UDim2.new(1, 0, 1, 0)
mainBgImage.Position = UDim2.new(0, 0, 0, 0)
mainBgImage.BackgroundTransparency = 1
mainBgImage.Image = "rbxassetid://83861593210689"
mainBgImage.ImageTransparency = 0.35
mainBgImage.ScaleType = Enum.ScaleType.Crop
mainBgImage.ZIndex = 0
mainBgImage.Parent = v57
v54(mainBgImage, 22)

-- iOS Glass Top Title Bar
local v77 = Instance.new("TextLabel")
v26 = v77
v77.Size = UDim2.new(1, -96, 0, v11("Y", 36))
v77.Position = UDim2.new(0, 10, 0, v11("Y", 8))
v77.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
v77.BackgroundTransparency = 0.25
v77.Text = (v24 and "⚡ AYAN 🔥 EMOTES (R6) | PREMIER EDITION ⚡") or "⚡ AYAN 🔥 EMOTES | PREMIUM EDITION ⚡"
v77.TextColor3 = Color3.new(1, 1, 1)
v77.Font = Enum.Font.GothamBold
v77.TextScaled = true
v77.ZIndex = 2
v77.Parent = v57
v54(v77, 14)
local titleGlassStroke = v55(v77, Color3.fromRGB(255, 255, 255), 1.4)
titleGlassStroke.Transparency = 0.45

-- Top Bar Freeze Emote Button
local freezeTopBtn = Instance.new("TextButton")
freezeBtnRef = freezeTopBtn
freezeTopBtn.Size = UDim2.new(0, v11("X", 36), 0, v11("Y", 36))
freezeTopBtn.Position = UDim2.new(1, -v11("X", 82), 0, v11("Y", 8))
freezeTopBtn.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
freezeTopBtn.BackgroundTransparency = 0.25
freezeTopBtn.BorderSizePixel = 0
freezeTopBtn.Text = "⏸"
freezeTopBtn.TextColor3 = Color3.new(1, 1, 1)
freezeTopBtn.Font = Enum.Font.GothamBold
freezeTopBtn.TextScaled = true
freezeTopBtn.ZIndex = 5
freezeTopBtn.Parent = v57
v54(freezeTopBtn, 12)
v55(freezeTopBtn, Color3.fromRGB(255, 255, 255), 1.2).Transparency = 0.45

freezeTopBtn.MouseButton1Click:Connect(function()
	setEmoteFreezeState(not emoteFrozen)
	playOptionSound()
end)

-- Top Bar ❌ Remove / Destroy GUI Button
local closeTopBtn = Instance.new("TextButton")
closeTopBtn.Size = UDim2.new(0, v11("X", 36), 0, v11("Y", 36))
closeTopBtn.Position = UDim2.new(1, -v11("X", 42), 0, v11("Y", 8))
closeTopBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
closeTopBtn.BackgroundTransparency = 0.25
closeTopBtn.BorderSizePixel = 0
closeTopBtn.Text = "❌"
closeTopBtn.TextColor3 = Color3.new(1, 1, 1)
closeTopBtn.Font = Enum.Font.GothamBold
closeTopBtn.TextScaled = true
closeTopBtn.ZIndex = 5
closeTopBtn.Parent = v57
v54(closeTopBtn, 12)
v55(closeTopBtn, Color3.fromRGB(255, 255, 255), 1.2).Transparency = 0.45

-- Destroy Confirmation Popup (Yes / No)
local destroyPopup = Instance.new("Frame")
destroyPopup.Size = UDim2.new(0, v11("X", 300), 0, v11("Y", 140))
destroyPopup.Position = UDim2.new(0.5, -v11("X", 150), 0.5, -v11("Y", 70))
destroyPopup.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
destroyPopup.BackgroundTransparency = 0.1
destroyPopup.BorderSizePixel = 0
destroyPopup.Visible = false
destroyPopup.ZIndex = 30
destroyPopup.Parent = v49
v54(destroyPopup, 18)
local popupStroke = v55(destroyPopup, Color3.fromRGB(255, 255, 255), 1.6)
popupStroke.Transparency = 0.35

local popupTitle = Instance.new("TextLabel")
popupTitle.Size = UDim2.new(1, -20, 0, v11("Y", 54))
popupTitle.Position = UDim2.new(0, 10, 0, v11("Y", 12))
popupTitle.BackgroundTransparency = 1
popupTitle.Text = "Do you want destroy GUI?"
popupTitle.TextColor3 = Color3.new(1, 1, 1)
popupTitle.Font = Enum.Font.GothamBold
popupTitle.TextScaled = true
popupTitle.ZIndex = 31
popupTitle.Parent = destroyPopup

local yesDestroyBtn = Instance.new("TextButton")
yesDestroyBtn.Size = UDim2.new(0.42, 0, 0, v11("Y", 38))
yesDestroyBtn.Position = UDim2.new(0.06, 0, 1, -v11("Y", 50))
yesDestroyBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
yesDestroyBtn.BackgroundTransparency = 0.2
yesDestroyBtn.BorderSizePixel = 0
yesDestroyBtn.Text = "Yes"
yesDestroyBtn.TextColor3 = Color3.new(1, 1, 1)
yesDestroyBtn.Font = Enum.Font.GothamBold
yesDestroyBtn.TextScaled = true
yesDestroyBtn.ZIndex = 31
yesDestroyBtn.Parent = destroyPopup
v54(yesDestroyBtn, 12)

local noDestroyBtn = Instance.new("TextButton")
noDestroyBtn.Size = UDim2.new(0.42, 0, 0, v11("Y", 38))
noDestroyBtn.Position = UDim2.new(0.52, 0, 1, -v11("Y", 50))
noDestroyBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
noDestroyBtn.BackgroundTransparency = 0.2
noDestroyBtn.BorderSizePixel = 0
noDestroyBtn.Text = "No"
noDestroyBtn.TextColor3 = Color3.new(1, 1, 1)
noDestroyBtn.Font = Enum.Font.GothamBold
noDestroyBtn.TextScaled = true
noDestroyBtn.ZIndex = 31
noDestroyBtn.Parent = destroyPopup
v54(noDestroyBtn, 12)

local v327
closeTopBtn.MouseButton1Click:Connect(function()
	destroyPopup.Visible = not destroyPopup.Visible
end)

noDestroyBtn.MouseButton1Click:Connect(function()
	destroyPopup.Visible = false
end)

yesDestroyBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if v46 then
			v46:Stop()
		end
	end)
	for _, guiObj in ipairs({ v49, v327, freezeSquareGuiRef }) do
		pcall(function()
			if guiObj then
				guiObj:Destroy()
			end
		end)
	end
	pcall(function()
		if optionToggleSound then
			optionToggleSound:Destroy()
		end
	end)
end)

-- Glass Panel Backdrop for Content
local glassPanel = Instance.new("Frame")
glassPanel.Size = UDim2.new(1, -20, 1, -v11("Y", 54))
glassPanel.Position = UDim2.new(0, 10, 0, v11("Y", 48))
glassPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glassPanel.BackgroundTransparency = 0.91
glassPanel.BorderSizePixel = 0
glassPanel.ZIndex = 2
glassPanel.Parent = v57
v54(glassPanel, 16)
local panelGlassStroke = v55(glassPanel, Color3.fromRGB(255, 255, 255), 1.1)
panelGlassStroke.Transparency = 0.65

local v65 = Instance.new("TextButton")
v65.Size = UDim2.new(0 + 0, 24, 975 - (815 + 160), 24)
v65.Position = UDim2.new(4 - 3, -(56 - 32), 1, -(6 + 18))
v65.BackgroundTransparency = 1
v65.Text = "◢"
v65.TextColor3 = Color3.fromRGB(220, 230, 255)
v65.TextSize = 1911 - (1222 + 671)
v65.ZIndex = 25 - 15
v65.Parent = v57

local v74 = false
local v75
local v76
v65.InputBegan:Connect(function(v396)
	if (v396.UserInputType == Enum.UserInputType.MouseButton1) or (v396.UserInputType == Enum.UserInputType.Touch) then
		v74 = true
		v75 = v396.Position
		v76 = v57.AbsoluteSize
	end
end)
v17.InputChanged:Connect(function(v397)
	if
		v74
		and (
			(v397.UserInputType == Enum.UserInputType.MouseMovement) or (v397.UserInputType == Enum.UserInputType.Touch)
		)
	then
		local v604 = 0
		local v605
		local v606
		local v607
		while true do
			if v604 == (1 - 0) then
				v607 = math.max(1282 - (229 + 953), v76.Y + v605.Y)
				v57.Size = UDim2.new(0, v606, 1774 - (1111 + 663), v607)
				break
			end
			if v604 == (1579 - (874 + 705)) then
				v605 = v397.Position - v75
				v606 = math.max(220, v76.X + v605.X)
				v604 = 1 + 0
			end
		end
	end
end)
v17.InputEnded:Connect(function(v398)
	if (v398.UserInputType == Enum.UserInputType.MouseButton1) or (v398.UserInputType == Enum.UserInputType.Touch) then
		v74 = false
	end
end)

-- Glass Tab Buttons
local v87 = Instance.new("TextButton")
v27 = v87
v87.Size = UDim2.new(0.45, 0, 0, v11("Y", 24))
v87.Position = UDim2.new(0.02, 0, 0, v11("Y", 6))
v87.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v87.BackgroundTransparency = 0.82
v87.Text = (v24 and "Animation") or "Catalog"
v87.TextColor3 = Color3.new(1, 1, 1)
v87.Font = Enum.Font.GothamBold
v87.TextScaled = true
v87.ZIndex = 3
v87.Parent = glassPanel
v54(v87, 10)
local tab1Stroke = v55(v87, Color3.fromRGB(255, 255, 255), 1)
tab1Stroke.Transparency = 0.65

local v97 = Instance.new("TextButton")
v28 = v97
v97.Size = UDim2.new(0.45, 0, 0, v11("Y", 24))
v97.Position = UDim2.new(0.50, 0, 0, v11("Y", 6))
v97.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v97.BackgroundTransparency = 0.88
v97.Text = "Saved"
v97.TextColor3 = Color3.new(1, 1, 1)
v97.Font = Enum.Font.GothamBold
v97.TextScaled = true
v97.Visible = not v24
v97.ZIndex = 3
v97.Parent = glassPanel
v54(v97, 10)
local tab2Stroke = v55(v97, Color3.fromRGB(255, 255, 255), 1)
tab2Stroke.Transparency = 0.65

local v108 = Instance.new("Frame")
v108.Size = UDim2.new(0, v11("X", 2), 1, -v11("Y", 44))
v108.Position = UDim2.new(0.60, 0, 0, v11("Y", 38))
v108.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v108.BackgroundTransparency = 0.72
v108.BorderSizePixel = 0
v108.ZIndex = 3
v108.Parent = glassPanel

-- Catalog Frame
local v114 = Instance.new("Frame")
v29 = v114
v114.Size = UDim2.new(0.59, -v11("X", 6), 1, -v11("Y", 40))
v114.Position = UDim2.new(0, v11("X", 6), 0, v11("Y", 36))
v114.BackgroundTransparency = 1
v114.Visible = true
v114.ZIndex = 3
v114.Parent = glassPanel

local v120 = Instance.new("TextBox")
v120.Size = UDim2.new(0.54, -v11("X", 4), 0, v11("Y", 28))
v120.Position = UDim2.new(0, 0, 0, 0)
v120.PlaceholderText = "Search..."
v120.PlaceholderColor3 = Color3.fromRGB(190, 205, 235)
v120.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v120.BackgroundTransparency = 0.85
v120.TextColor3 = Color3.new(1, 1, 1)
v120.Font = Enum.Font.GothamBold
v120.TextScaled = true
v120.ClearTextOnFocus = false
v120.Text = ""
v120.ZIndex = 4
v120.Parent = v114
v54(v120, 10)
v55(v120, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

local v133 = Instance.new("TextButton")
v133.Size = UDim2.new(0.20, -v11("X", 4), 0, v11("Y", 28))
v133.Position = UDim2.new(0.54, v11("X", 4), 0, 0)
v133.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v133.BackgroundTransparency = 0.85
v133.Text = "Refresh"
v133.Font = Enum.Font.GothamBold
v133.TextScaled = true
v133.TextColor3 = Color3.new(1, 1, 1)
v133.ZIndex = 4
v133.Parent = v114
v54(v133, 10)
v55(v133, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

local v143 = Instance.new("TextButton")
v143.Size = UDim2.new(0.26, -v11("X", 4), 0, v11("Y", 28))
v143.Position = UDim2.new(0.74, v11("X", 4), 0, 0)
v143.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v143.BackgroundTransparency = 0.85
v143.Text = "Sort: Relevance"
v143.Font = Enum.Font.GothamBold
v143.TextScaled = true
v143.TextColor3 = Color3.new(1, 1, 1)
v143.ZIndex = 4
v143.Parent = v114
v54(v143, 10)
v55(v143, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

-- Saved Frame
local v153 = Instance.new("Frame")
v30 = v153
v153.Size = UDim2.new(0.59, -v11("X", 6), 1, -v11("Y", 40))
v153.Position = UDim2.new(0, v11("X", 6), 0, v11("Y", 36))
v153.BackgroundTransparency = 1
v153.Visible = false
v153.ZIndex = 3
v153.Parent = glassPanel

local v159 = Instance.new("TextBox")
v159.Size = UDim2.new(0.62, -v11("X", 4), 0, v11("Y", 28))
v159.Position = UDim2.new(0, 0, 0, 0)
v159.PlaceholderText = "Search Saved..."
v159.PlaceholderColor3 = Color3.fromRGB(190, 205, 235)
v159.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v159.BackgroundTransparency = 0.85
v159.TextColor3 = Color3.new(1, 1, 1)
v159.Font = Enum.Font.GothamBold
v159.TextScaled = true
v159.ClearTextOnFocus = false
v159.Text = ""
v159.ZIndex = 4
v159.Parent = v153
v54(v159, 10)
v55(v159, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

local v171 = Instance.new("TextBox")
v171.Size = UDim2.new(0.24, -v11("X", 4), 0, v11("Y", 28))
v171.Position = UDim2.new(0.62, v11("X", 4), 0, 0)
v171.PlaceholderText = "Emote ID"
v171.PlaceholderColor3 = Color3.fromRGB(190, 205, 235)
v171.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v171.BackgroundTransparency = 0.85
v171.TextColor3 = Color3.new(1, 1, 1)
v171.Font = Enum.Font.GothamBold
v171.TextScaled = true
v171.ClearTextOnFocus = false
v171.Text = ""
v171.ZIndex = 4
v171.Parent = v153
v54(v171, 10)
v55(v171, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

local v183 = Instance.new("TextButton")
v183.Size = UDim2.new(0.14, -v11("X", 4), 0, v11("Y", 28))
v183.Position = UDim2.new(0.86, v11("X", 4), 0, 0)
v183.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
v183.BackgroundTransparency = 0.25
v183.Text = "+"
v183.Font = Enum.Font.GothamBold
v183.TextScaled = true
v183.TextColor3 = Color3.new(1, 1, 1)
v183.ZIndex = 4
v183.Parent = v153
v54(v183, 10)

local v193 = Instance.new("ScrollingFrame")
v193.Size = UDim2.new(1, 0, 1, -v11("Y", 36))
v193.Position = UDim2.new(0, 0, 0, v11("Y", 34))
v193.CanvasSize = UDim2.new(0 - 0, 0, 0, 0 - 0)
v193.ScrollBarThickness = 4
v193.ScrollBarImageColor3 = Color3.fromRGB(180, 200, 255)
v193.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
v193.BackgroundTransparency = 0.45
v193.ZIndex = 4
v193.Parent = v153
v54(v193, 14)

local v200 = Instance.new("TextLabel")
v200.Size = UDim2.new(2 - 1, 1310 - (682 + 628), 0 + 0, v11("Y", 335 - (176 + 123)))
v200.Position = UDim2.new(0 + 0, 0 + 0, 0.5, -v11("Y", 287 - (239 + 30)))
v200.BackgroundTransparency = 1 + 0
v200.Text = "AYAN: Search Empty :3"
v200.TextColor3 = Color3.new(1, 1, 1)
v200.Font = Enum.Font.GothamBold
v200.TextScaled = true
v200.Visible = false
v200.ZIndex = 5
v200.Parent = v193

local v210 = Instance.new("UIGridLayout")
v210.CellSize = UDim2.new(0 - 0, v11("X", 120), 315 - (306 + 9), v11("Y", 200))
v210.CellPadding = UDim2.new(0, v11("X", 27 - 19), 0, v11("Y", 2 + 6))
v210.HorizontalAlignment = Enum.HorizontalAlignment.Center
v210.Parent = v193

-- Right Glass Settings Panel
local v216 = Instance.new("Frame")
v216.Size = UDim2.new(0.40, -v11("X", 10), 1, -v11("Y", 44))
v216.Position = UDim2.new(0.60, v11("X", 6), 0, v11("Y", 38))
v216.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
v216.BackgroundTransparency = 0.45
v216.ZIndex = 3
v216.Parent = glassPanel
v54(v216, 14)
v55(v216, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

local v221 = Instance.new("TextLabel")
v221.Size = UDim2.new(1, -12, 0, v11("Y", 26))
v221.Position = UDim2.new(0, 6, 0, 4)
v221.BackgroundTransparency = 1
v221.Text = "Settings"
v221.TextColor3 = Color3.new(1, 1, 1)
v221.Font = Enum.Font.GothamBold
v221.TextScaled = true
v221.ZIndex = 4
v221.Parent = v216

local v229 = Instance.new("ScrollingFrame")
v229.Size = UDim2.new(1, -v11("X", 12), 1, -v11("Y", 36))
v229.Position = UDim2.new(0, v11("X", 6), 0, v11("Y", 32))
v229.BackgroundTransparency = 1 - 0
v229.CanvasSize = UDim2.new(0, 0, 0, 0 + 0)
v229.ScrollBarThickness = 4
v229.ScrollBarImageColor3 = Color3.fromRGB(180, 200, 255)
v229.ZIndex = 4
v229.Parent = v216

local function v237()
	v229.CanvasPosition = Vector2.new(0 - 0, v229.CanvasPosition.Y)
end
v229:GetPropertyChangedSignal("CanvasPosition"):Connect(v237)

local v238 = Instance.new("UIListLayout", v229)
v238.Padding = UDim.new(0 - 0, 617 - (295 + 314))
v238.FillDirection = Enum.FillDirection.Vertical
v238.SortOrder = Enum.SortOrder.LayoutOrder
v238:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	v229.CanvasSize = UDim2.new(0 - 0, 0, 1962 - (1300 + 662), v238.AbsoluteContentSize.Y + (31 - 21))
end)

function GetReal(v401)
	local v402 = 0
	local v403
	local v404
	while true do
		if v402 == (1755 - (1178 + 577)) then
			v403, v404 = pcall(function()
				return game:GetObjects("rbxassetid://" .. tostring(v401))
			end)
			if v403 and v404 and (#v404 > (0 + 0)) then
				local v734 = 0 - 0
				local v735
				while true do
					if v734 == 0 then
						v735 = v404[1]
						if v735:IsA("Animation") and (v735.AnimationId ~= "") then
							return tonumber(v735.AnimationId:match("%d+"))
						elseif v735:FindFirstChildOfClass("Animation") then
							local v929 = v735:FindFirstChildOfClass("Animation")
							return tonumber(v929.AnimationId:match("%d+"))
						end
						break
					end
				end
			end
			break
		end
	end
end

local v244
v183.MouseButton1Click:Connect(function()
	local v405 = 1405 - (851 + 554)
	local v406
	while true do
		if v405 == (0 + 0) then
			v406 = tonumber(v171.Text)
			if v406 then
				local v736 = 0 - 0
				local v737
				while true do
					if v736 == (0 - 0) then
						v737 = false
						for v862, v863 in ipairs(v42) do
							if v863.Id == v406 then
								v737 = true
								break
							end
						end
						v736 = 303 - (115 + 187)
					end
					if v736 == 1 then
						if not v737 then
							local v905 = GetReal(v406)
							table.insert(
								v42,
								{
									["Id"] = v406,
									["AssetId"] = v406,
									["Name"] = "Custom ID: " .. v406,
									["AnimationId"] = "rbxassetid://" .. tostring(v905 or v406),
									["Favorite"] = false,
								}
							)
							v45()
							v244()
						end
						break
					end
				end
			end
			break
		end
	end
end)

v31._sliders = {}
v31._toggles = {}

local function v247(v407, v408, v409, v410, allowCustomBeyondMax)
	v31[v407] = v410 or v408
	local v412 = Instance.new("Frame")
	v412.Size = UDim2.new(1 + 0, 0 + 0, 0, v11("Y", 65))
	v412.BackgroundTransparency = 1
	v412.ZIndex = 5
	v412.Parent = v229

	local v416 = Instance.new("Frame")
	v416.Size = UDim2.new(1, 0 - 0, 1162 - (160 + 1001), 0 + 0)
	v416.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v416.BackgroundTransparency = 0.88
	v416.ZIndex = 5
	v416.Parent = v412
	v54(v416, 12)
	v55(v416, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

	local v421 = Instance.new("TextLabel")
	v421.Size = UDim2.new(0.54, -v11("X", 8), 0, v11("Y", 20))
	v421.Position = UDim2.new(0, 8, 0, 5)
	v421.BackgroundTransparency = 1
	v421.Text = string.format("%s: %.2f", v407, v31[v407])
	v421.TextColor3 = Color3.new(1, 1, 1)
	v421.Font = Enum.Font.GothamBold
	v421.TextScaled = true
	v421.TextXAlignment = Enum.TextXAlignment.Left
	v421.ZIndex = 6
	v421.Parent = v416

	local v433 = Instance.new("TextBox")
	v433.Size = UDim2.new(0.44, -v11("X", 10), 0, v11("Y", 20))
	v433.Position = UDim2.new(0.55, 0, 0, v11("Y", 5))
	v433.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v433.BackgroundTransparency = 0.85
	v433.PlaceholderText = allowCustomBeyondMax and "Custom" or ""
	v433.Text = tostring(v31[v407])
	v433.TextColor3 = Color3.fromRGB(250, 204, 21)
	v433.Font = Enum.Font.GothamBold
	v433.TextScaled = true
	v433.ClearTextOnFocus = false
	v433.ZIndex = 6
	v433.Parent = v416
	v54(v433, 8)

	local v443 = Instance.new("Frame")
	v443.Size = UDim2.new(1, -v11("X", 13 + 27), 0 - 0, v11("Y", 12))
	v443.Position = UDim2.new(0 - 0, v11("X", 41 - 21), 0 + 0, v11("Y", 68 - 33))
	v443.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v443.BackgroundTransparency = 0.8
	v443.ZIndex = 6
	v443.Parent = v416
	v54(v443, 23 - 17)

	local v448 = Instance.new("Frame")
	v448.Size = UDim2.new(0, 0, 1 - 0, 0 - 0)
	v448.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
	v448.ZIndex = 7
	v448.Parent = v443
	v54(v448, 6 + 0)

	local v452 = Instance.new("Frame")
	v452.Size = UDim2.new(0 + 0, v11("X", 53 - 33), 0 - 0, v11("Y", 374 - (5 + 349)))
	v452.AnchorPoint = Vector2.new(0.5, 0.5 - 0)
	v452.Position = UDim2.new(0, 0, 0.5, 1271 - (266 + 1005))
	v452.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v452.ZIndex = 8
	v452.Parent = v443
	v54(v452, 34 - 24)
	v55(v452, Color3.fromRGB(0, 0, 0), 1)

	local function v458(v575)
		local v576 = 0 - 0
		local v577
		while true do
			if v576 == 1 then
				v18:Create(v452, TweenInfo.new(0.15), { ["Position"] = UDim2.new(v577, 0, 0.5, 0 - 0) }):Play()
				break
			end
			if v576 == 0 then
				v577 = math.clamp(v575, 0, 1)
				v18:Create(v448, TweenInfo.new(0.15), { ["Size"] = UDim2.new(v577, 0, 1067 - (507 + 559), 0 - 0) })
					:Play()
				v576 = 3 - 2
			end
		end
	end
	local function v459(v578, isCustomInput)
		if allowCustomBeyondMax and isCustomInput then
			v31[v407] = math.max(v408, v578)
		else
			v31[v407] = math.clamp(v578, v408, v409)
		end
		v421.Text = string.format("%s: %.2f", v407, v31[v407])
		v433.Text = tostring(v31[v407])
		local v582 = (v31[v407] - v408) / (v409 - v408)
		v458(v582)
		if v46 and v46.IsPlaying then
			if v407 == "Speed" then
				savedSpeedBeforeFreeze = v31["Speed"]
				if not emoteFrozen then
					v46:AdjustSpeed(v31["Speed"])
				end
			elseif v407 == "Weight" then
				local v825 = 0
				local v826
				while true do
					if v825 == 1 then
						v46:AdjustWeight(v826)
						break
					end
					if v825 == 0 then
						v826 = v31["Weight"]
						if v826 == 0 then
							v826 = 388.001 - (212 + 176)
						end
						v825 = 1
					end
				end
			elseif v407 == "Time Position" then
				if v46.Length > (905 - (250 + 655)) then
					v46.TimePosition = math.clamp(v578, 0 - 0, 1 - 0) * v46.Length
				end
			end
		end
	end
	local v460 = false
	local function v461(v583)
		local v584 = 0
		local v585
		local v586
		local v587
		while true do
			if v584 == (1 - 0) then
				v587 = nil
				while true do
					if v585 == 1 then
						v459(v587, false)
						break
					end
					if v585 == (1956 - (1869 + 87)) then
						v586 = math.clamp((v583.Position.X - v443.AbsolutePosition.X) / v443.AbsoluteSize.X, 0, 1)
						v587 = math.floor((v408 + ((v409 - v408) * v586)) * (346 - 246)) / (2001 - (484 + 1417))
						v585 = 2 - 1
					end
				end
				break
			end
			if v584 == (0 - 0) then
				v585 = 773 - (48 + 725)
				v586 = nil
				v584 = 1 - 0
			end
		end
	end
	v443.InputBegan:Connect(function(v588)
		if
			(v588.UserInputType == Enum.UserInputType.MouseButton1) or (v588.UserInputType == Enum.UserInputType.Touch)
		then
			v460 = true
			v461(v588)
		end
	end)
	v452.InputBegan:Connect(function(v589)
		if
			(v589.UserInputType == Enum.UserInputType.MouseButton1) or (v589.UserInputType == Enum.UserInputType.Touch)
		then
			v460 = true
			v461(v589)
		end
	end)
	v17.InputChanged:Connect(function(v590)
		if
			v460
			and (
				(v590.UserInputType == Enum.UserInputType.MouseMovement)
				or (v590.UserInputType == Enum.UserInputType.Touch)
			)
		then
			v461(v590)
		end
	end)
	v17.InputEnded:Connect(function(v591)
		if
			v460
			and (
				(v591.UserInputType == Enum.UserInputType.MouseButton1) or (
					v591.UserInputType == Enum.UserInputType.Touch
				)
			)
		then
			v460 = false
		end
	end)
	v433.FocusLost:Connect(function()
		local v620 = tonumber(v433.Text)
		if v620 then
			v459(v620, true)
		else
			v433.Text = tostring(v31[v407])
		end
	end)
	v31._sliders[v407] = v459
	v459(v31[v407], false)
end
local isInitialized = false
	local v465 = Instance.new("Frame")
	v465.Size = UDim2.new(1, 0, 0, v11("Y", 44))
	v465.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v465.BackgroundTransparency = 0.88
	v465.ZIndex = 5
	v465.Parent = v229
	v54(v465, 12)
	v55(v465, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

	local v466 = Instance.new("TextLabel")
	v466.Size = UDim2.new(1, -v11("X", 74), 1, -v11("Y", 4))
	v466.Position = UDim2.new(0, v11("X", 10), 0, v11("Y", 2))
	v466.BackgroundTransparency = 1
	v466.Text = v463
	v466.TextColor3 = Color3.new(1, 1, 1)
	v466.Font = Enum.Font.GothamBold
	v466.TextScaled = true
	v466.TextWrapped = true
	v466.TextXAlignment = Enum.TextXAlignment.Left
	v466.ZIndex = 6
	v466.Parent = v465

	local v467 = Instance.new("TextButton")
	v467.Size = UDim2.new(0, v11("X", 56), 0, v11("Y", 26))
	v467.Position = UDim2.new(1, -v11("X", 64), 0.5, -v11("Y", 13))
	v467.TextColor3 = Color3.new(1, 1, 1)
	v467.Font = Enum.Font.GothamBold
	v467.TextScaled = true
	v467.ZIndex = 6
	v467.Parent = v465
	v54(v467, 10)

	local function v468(v709, playSoundOnChange)
		v467.Text = (v709 and "ON") or "OFF"
		v467.BackgroundColor3 = (v709 and Color3.fromRGB(34, 197, 94)) or Color3.fromRGB(239, 68, 68)
		v467.BackgroundTransparency = 0.25
		if playSoundOnChange then
			playOptionSound()
		end
		if typeof(onChangedCallback) == "function" then
			onChangedCallback(v709)
		end
	end

	v467.MouseButton1Click:Connect(function()
		v31[v463] = not v31[v463]
		v468(v31[v463], true)
	end)
	v468(v31[v463], false)
	isInitialized = true
	v31._toggles[v463] = function(val)
		v468(val, isInitialized)
	end
end

v31.EditSlider = function(v469, v470, v471)
	local v473 = v469._sliders[v470]
	if v473 then
		v473(v471)
	end
end
v31.EditToggle = function(v474, v475, v476)
	local v478 = v474._toggles[v475]
	if v478 then
		v474[v475] = v476
		v478(v476)
	end
end

local function v251(v479, v480)
	local v481 = Instance.new("Frame")
	v481.Size = UDim2.new(1, 0, 0, v11("Y", 42))
	v481.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v481.BackgroundTransparency = 0.88
	v481.ZIndex = 5
	v481.Parent = v229
	v54(v481, 12)

	local v486 = Instance.new("TextButton")
	v486.Size = UDim2.new(1, -v11("X", 16), 1, -v11("Y", 8))
	v486.Position = UDim2.new(0, v11("X", 8), 0, v11("Y", 4))
	v486.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
	v486.BackgroundTransparency = 0.25
	v486.Text = v479
	v486.TextColor3 = Color3.new(1, 1, 1)
	v486.Font = Enum.Font.GothamBold
	v486.TextScaled = true
	v486.ZIndex = 6
	v486.Parent = v481
	v54(v486, 10)
	v486.MouseButton1Click:Connect(function()
		if typeof(v480) == "function" then
			v480()
		end
	end)
	return v486
end

local v252 = v251("Reset Settings", function() end)
v248("Do you want emote freeze button", function()
	updateFreezeSquareVisibility()
end)
v248("Stop Emote When Moving")
v248("Looped")
v247("Speed", 0, 10, v31["Speed"], true)
v247("Time Position", 0, 1, v31["Time Position"])
v247("Weight", 0, 1, v31["Weight"])
v247("Fade In", 0, 2, v31["Fade In"])
v247("Fade Out", 0, 2, v31["Fade Out"])
v248("Stop Other Animations On Play")
v248("High Priority")

v252.MouseButton1Click:Connect(function()
	playOptionSound()
	setEmoteFreezeState(false)
	v31:EditToggle("Do you want emote freeze button", false)
	v31:EditToggle("Stop Emote When Moving", true)
	v31:EditToggle("Stop Other Animations On Play", true)
	v31:EditToggle("High Priority", true)
	v31:EditSlider("Fade In", 0.1)
	v31:EditSlider("Fade Out", 0.1)
	v31:EditSlider("Weight", 1)
	v31:EditSlider("Speed", 1)
	v31:EditSlider("Time Position", 0)
	v31:EditToggle("Freeze On Finish", false)
	v31:EditToggle("Looped", true)
end)

local v253 = {
	{ Enum.CatalogSortType.Relevance, "Relevance" },
	{ Enum.CatalogSortType.PriceHighToLow, "Price High→Low" },
	{ Enum.CatalogSortType.PriceLowToHigh, "Price Low→High" },
	{ Enum.CatalogSortType.MostFavorited, "Most Favorited" },
	{ Enum.CatalogSortType.RecentlyCreated, "Recently Created" },
	{ Enum.CatalogSortType.Bestselling, "Bestselling" },
}
local v254 = 1
local v255 = ""
local v256 = nil
local v257 = 1
local v258 = 1

local function v259(v497)
	if v24 then
		return {
			["IsFinished"] = true,
			["GetCurrentPage"] = function()
				return {
					{
						["Id"] = 115314801778772,
						["Name"] = "Dance If Youre The Best",
						["AssetId"] = 115314801778772,
					},
				}
			end,
			["AdvanceToNextPageAsync"] = function() end,
		}
	end
	local v499 = CatalogSearchParams.new()
	v499.SearchKeyword = v497 or ""
	v499.CategoryFilter = Enum.CatalogCategoryFilter.None
	v499.SalesTypeFilter = Enum.SalesTypeFilter.All
	v499.AssetTypes = { Enum.AvatarAssetType.EmoteAnimation }
	v499.IncludeOffSale = true
	v499.SortType = v253[v254][1]
	v499.Limit = 10
	local v500, v501 = pcall(function()
		return v19:SearchCatalog(v499)
	end)
	if not v500 then
		return nil
	end
	return v501
end

local function v260(v502)
	local v504 = Instance.new("Frame")
	v504.Size = UDim2.new(0, v11("X", 120), 0, v11("Y", 180))
	v504.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v504.BackgroundTransparency = 0.88
	v54(v504, 12)
	v55(v504, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

	local v505 = v502.AssetId or v502.Id
	local v506 = Instance.new("ImageLabel")
	v506.Size = UDim2.new(1, -v11("X", 10), 0, v11("Y", 90))
	v506.Position = UDim2.new(0, v11("X", 5), 0, v11("Y", 5))
	v506.BackgroundTransparency = 1
	v506.ScaleType = Enum.ScaleType.Fit
	pcall(function()
		v506.Image = "rbxthumb://type=Asset&id=" .. tonumber(v505) .. "&w=150&h=150"
	end)
	v506.Parent = v504
	v54(v506, 8)

	local v507 = Instance.new("TextLabel")
	v507.Size = UDim2.new(1, -v11("X", 10), 0, v11("Y", 28))
	v507.Position = UDim2.new(0, v11("X", 5), 0, v11("Y", 100))
	v507.BackgroundTransparency = 1
	v507.Text = v502.Name or "Unknown"
	v507.TextScaled = true
	v507.TextWrapped = true
	v507.Font = Enum.Font.GothamBold
	v507.TextColor3 = Color3.new(1, 1, 1)
	v507.Parent = v504

	local v508 = "https://www.roblox.com/catalog/" .. tonumber(v502.Id)
	local v509 = Instance.new("TextButton")
	v509.Parent = v504
	v509.Size = UDim2.new(0, v11("X", 34), 0, v11("Y", 26))
	v509.Position = UDim2.new(1, -v11("X", 39), 0, v11("Y", 8))
	v509.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	v509.BackgroundTransparency = 0.35
	v509.Text = "🛒🔗"
	v509.Font = Enum.Font.GothamBold
	v509.TextScaled = true
	v509.TextColor3 = Color3.new(1, 1, 1)
	v509.AutoButtonColor = false
	v54(v509, 8)
	v509.MouseButton1Click:Connect(function()
		setclipboard(v508)
		v509.Text = "✅"
		task.wait(0.7)
		v509.Text = "🛒🔗"
	end)

	local v510 = Instance.new("TextButton")
	v510.Size = UDim2.new(0.45, -v11("X", 5), 0, v11("Y", 24))
	v510.Position = UDim2.new(0, v11("X", 5), 1, -v11("Y", 29))
	v510.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
	v510.BackgroundTransparency = 0.25
	v510.Text = "Play"
	v510.Font = Enum.Font.GothamBold
	v510.TextScaled = true
	v510.TextColor3 = Color3.new(1, 1, 1)
	v510.Parent = v504
	v54(v510, 8)
	v510.MouseButton1Click:Connect(function()
		v47(v505)
	end)

	local v511 = Instance.new("TextButton")
	v511.Size = UDim2.new(0.45, -v11("X", 5), 0, v11("Y", 24))
	v511.Position = UDim2.new(0.55, 0, 1, -v11("Y", 29))
	v511.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
	v511.BackgroundTransparency = 0.25
	v511.Text = "Save"
	v511.Font = Enum.Font.GothamBold
	v511.TextScaled = true
	v511.TextColor3 = Color3.new(1, 1, 1)
	v511.Parent = v504
	v54(v511, 8)
	v511.MouseButton1Click:Connect(function()
		local v828 = false
		for _, v943 in ipairs(v42) do
			if v943.Id == v502.Id then
				v828 = true
				break
			end
		end
		if not v828 then
			local v931 = GetReal(v505)
			table.insert(v42, {
				["Id"] = v502.Id,
				["AssetId"] = v505,
				["Name"] = v502.Name or "Unknown",
				["AnimationId"] = "rbxassetid://" .. tostring(v931 or v505),
				["Favorite"] = false,
			})
			v45()
			v511.Text = "Saved!"
			task.wait(1)
			v511.Text = "Save"
		else
			v511.Text = "Already"
			task.wait(0.7)
			v511.Text = "Save"
		end
	end)

	v56(v504)
	return v504
end

local v261 = Instance.new("ScrollingFrame")
v261.Size = UDim2.new(1, 0, 1, -v11("Y", 70))
v261.Position = UDim2.new(0, 0, 0, v11("Y", 34))
v261.CanvasSize = UDim2.new(0, 0, 0, 0)
v261.ScrollBarThickness = 4
v261.ScrollBarImageColor3 = Color3.fromRGB(180, 200, 255)
v261.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
v261.BackgroundTransparency = 0.45
v261.ZIndex = 4
v261.Parent = v114
v54(v261, 14)

local v269 = Instance.new("UIGridLayout", v261)
v269.CellSize = UDim2.new(0, v11("X", 120), 0, v11("Y", 180))
v269.CellPadding = UDim2.new(0, v11("X", 8), 0, v11("Y", 8))

local v272 = Instance.new("TextLabel", v261)
v272.Size = UDim2.new(1, 0, 0, v11("Y", 36))
v272.Position = UDim2.new(0, 0, 0.5, -v11("Y", 18))
v272.BackgroundTransparency = 1
v272.Text = "AYAN: Search Empty :3"
v272.TextColor3 = Color3.new(1, 1, 1)
v272.Font = Enum.Font.GothamBold
v272.TextScaled = true
v272.Visible = false
v272.ZIndex = 5

local v281 = Instance.new("TextButton", v114)
v281.Size = UDim2.new(0.32, -v11("X", 4), 0, v11("Y", 30))
v281.Position = UDim2.new(0, 0, 1, -v11("Y", 32))
v281.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v281.BackgroundTransparency = 0.85
v281.Text = "< Prev"
v281.Font = Enum.Font.GothamBold
v281.TextScaled = true
v281.TextColor3 = Color3.new(1, 1, 1)
v281.ZIndex = 4
v54(v281, 10)

local v290 = Instance.new("TextButton", v114)
v290.Size = UDim2.new(0.32, -v11("X", 4), 0, v11("Y", 30))
v290.Position = UDim2.new(0.68, v11("X", 4), 1, -v11("Y", 32))
v290.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v290.BackgroundTransparency = 0.85
v290.Text = "Next >"
v290.Font = Enum.Font.GothamBold
v290.TextScaled = true
v290.TextColor3 = Color3.new(1, 1, 1)
v290.ZIndex = 4
v54(v290, 10)

local v299 = Instance.new("TextBox", v114)
v299.Size = UDim2.new(0.34, 0, 0, v11("Y", 30))
v299.Position = UDim2.new(0.33, 0, 1, -v11("Y", 32))
v299.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v299.BackgroundTransparency = 0.88
v299.Font = Enum.Font.GothamBold
v299.TextScaled = true
v299.TextColor3 = Color3.new(1, 1, 1)
v299.Text = "1 / Enter page"
v299.ZIndex = 4
v54(v299, 10)

local v307 = Instance.new("TextLabel", v114)
v307.Size = UDim2.new(0.6, 0, 0, v11("Y", 24))
v307.Position = UDim2.new(0.2, 0, 1, -v11("Y", 58))
v307.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
v307.BackgroundTransparency = 0.35
v307.TextColor3 = Color3.fromRGB(250, 204, 21)
v307.Font = Enum.Font.GothamBold
v307.TextScaled = true
v307.Text = ""
v307.Visible = false
v307.ZIndex = 6
v54(v307, 8)

local function v316()
	v281.Visible = v257 > 1
	if v256 and (typeof(v256.IsFinished) == "boolean") then
		v290.Visible = not v256.IsFinished
	else
		v290.Visible = true
	end
end

local v317 = 0
local function v318(v513)
	v317 += 1
	local v515 = v317
	v299.Text = "Loading..."
	for _, v717 in ipairs(v261:GetChildren()) do
		if v717:IsA("Frame") then
			v717:Destroy()
		end
	end
	local v517, v518 = pcall(function()
		return v513:GetCurrentPage()
	end)
	if not v517 then
		v299.Text = "ERROR"
		return
	end
	if v515 ~= v317 then
		return
	end
	if v518 and (#v518 > 0) then
		v272.Visible = false
		local v744 = v258
		local v745 = 0
		for _, v934 in ipairs(v518) do
			if (v258 ~= v744) or (v515 ~= v317) then
				break
			end
			v260(v934).Parent = v261
			v745 += 1
			if (v745 % 2) == 0 then
				v16.RenderStepped:Wait()
			end
		end
	else
		v272.Visible = true
	end
	if v515 == v317 then
		v261.CanvasSize = UDim2.new(0, 0, 0, v269.AbsoluteContentSize.Y + 8)
		v299.Text = tostring(v257) .. " / Enter page"
		v316()
	end
end

local function v319(v519)
	local v521 = v259(v255)
	if not v521 then
		return nil
	end
	for _ = 2, v519 do
		if v521.IsFinished then
			break
		end
		local v834 = pcall(function()
			v521:AdvanceToNextPageAsync()
		end)
		if not v834 then
			break
		end
	end
	return v521
end

local function v320(v522)
	v255 = v522 or ""
	v257 = 1
	v299.Text = "Loading..."
	v256 = v259(v255)
	if v256 then
		v318(v256)
	end
end

v133.MouseButton1Click:Connect(function()
	v320(v120.Text)
end)
v120.FocusLost:Connect(function(v524)
	if v524 then
		v320(v120.Text)
	end
end)
v143.MouseButton1Click:Connect(function()
	v254 = (v254 % #v253) + 1
	v143.Text = "Sort: " .. v253[v254][2]
	v320(v255)
end)

local function v321()
	if not v256 or v256.IsFinished then
		return
	end
	local v527 = pcall(function()
		v256:AdvanceToNextPageAsync()
	end)
	if v527 then
		v257 += 1
		v318(v256)
	else
		local v753 = v257 + 1
		local v754 = v319(v753)
		if v754 then
			v256 = v754
			v257 = math.min(v753, v257 + 1)
			v318(v256)
		end
	end
end

local function v322()
	if not v256 or (v257 <= 1) then
		return
	end
	local v531 = pcall(function()
		v256:AdvanceToPreviousPageAsync()
	end)
	if v531 then
		v257 = math.max(1, v257 - 1)
		v318(v256)
	else
		local v855 = math.max(1, v257 - 1)
		local v856 = v319(v855)
		if v856 then
			v256 = v856
			v257 = v855
			v318(v256)
		end
	end
end

v290.MouseButton1Click:Connect(v321)
v281.MouseButton1Click:Connect(v322)

v17.InputBegan:Connect(function(v533, v534)
	if v534 then
		return
	end
	if (v533.UserInputType == Enum.UserInputType.Keyboard) and (v533.KeyCode == Enum.KeyCode.Right) then
		v321()
	elseif v533.KeyCode == Enum.KeyCode.Left then
		v322()
	end
end)

v299.FocusLost:Connect(function(v536)
	if not v536 then
		return
	end
	local v539 = tonumber((v299.Text:gsub("%s+", "")):match("%d+"))
	if not v539 or (v539 < 1) then
		v307.Text = "Invalid page number"
		v307.Visible = true
		task.delay(2, function()
			if v307 then
				v307.Visible = false
			end
		end)
		v299.Text = "Page " .. tostring(v257)
		return
	end
	local v540 = math.floor(v539)
	if v540 == v257 then
		v299.Text = "Page " .. tostring(v257)
		return
	end
	v299.Text = "Loading..."
	local v541, v542 = pcall(function()
		return v319(v540)
	end)
	if not v541 or not v542 then
		v307.Text = "Unable to fetch page"
		v307.Visible = true
		task.delay(2, function()
			if v307 then
				v307.Visible = false
			end
		end)
		v299.Text = "Page " .. tostring(v257)
		return
	end
	v256 = v542
	v257 = math.max(1, v540)
	v318(v256)
end)

local function v323(v543)
	local v545 = Instance.new("Frame")
	v545.Size = UDim2.new(0, v11("X", 120), 0, v11("Y", 180))
	v545.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v545.BackgroundTransparency = 0.88
	v54(v545, 12)
	v55(v545, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.7

	local v546 = Instance.new("ImageLabel")
	v546.Size = UDim2.new(1, -v11("X", 10), 0, v11("Y", 90))
	v546.Position = UDim2.new(0, v11("X", 5), 0, v11("Y", 5))
	v546.Image = "rbxthumb://type=Asset&id=11768914234&w=150&h=150"
	v546.BackgroundTransparency = 1
	v546.ScaleType = Enum.ScaleType.Fit
	v546.Parent = v545
	v54(v546, 8)

	local v547 = Instance.new("TextLabel")
	v547.Size = UDim2.new(1, -v11("X", 10), 0, v11("Y", 28))
	v547.Position = UDim2.new(0, v11("X", 5), 0, v11("Y", 100))
	v547.BackgroundTransparency = 1
	v547.Text = v543.Name or "Unknown"
	v547.TextScaled = true
	v547.TextWrapped = true
	v547.Font = Enum.Font.GothamBold
	v547.TextColor3 = Color3.new(1, 1, 1)
	v547.Parent = v545

	local v548 = Instance.new("TextButton")
	v548.Size = UDim2.new(0.45, -v11("X", 5), 0, v11("Y", 24))
	v548.Position = UDim2.new(0, v11("X", 5), 1, -v11("Y", 29))
	v548.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
	v548.BackgroundTransparency = 0.25
	v548.Text = "Play"
	v548.Font = Enum.Font.GothamBold
	v548.TextScaled = true
	v548.TextColor3 = Color3.new(1, 1, 1)
	v548.Parent = v545
	v54(v548, 8)
	v548.MouseButton1Click:Connect(function()
		v47(v543.Id)
	end)

	local v549 = Instance.new("TextButton")
	v549.Size = UDim2.new(0.45, -v11("X", 5), 0, v11("Y", 24))
	v549.Position = UDim2.new(0.55, 0, 1, -v11("Y", 29))
	v549.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
	v549.BackgroundTransparency = 0.25
	v549.Text = "Remove"
	v549.Font = Enum.Font.GothamBold
	v549.TextScaled = true
	v549.TextColor3 = Color3.new(1, 1, 1)
	v549.Parent = v545
	v54(v549, 8)
	v549.MouseButton1Click:Connect(function()
		for v925, v926 in ipairs(v42) do
			if v926.Id == v543.Id then
				table.remove(v42, v925)
				v45()
				v244()
				break
			end
		end
	end)

	local v550 = Instance.new("TextButton")
	v550.Size = UDim2.new(0, v11("X", 44), 0, v11("Y", 24))
	v550.Position = UDim2.new(0.5, -v11("X", 22), 0, v11("Y", 5))
	v550.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	v550.BackgroundTransparency = 0.35
	v550.Text = "Copy AnimId"
	v550.Font = Enum.Font.GothamBold
	v550.TextScaled = true
	v550.TextColor3 = Color3.new(1, 1, 1)
	v550.Parent = v545
	v54(v550, 8)
	v550.MouseButton1Click:Connect(function()
		if setclipboard then
			setclipboard(v543.AnimationId:gsub("rbxassetid://", ""))
		end
		v550.Text = "Copied!"
		task.wait(0.7)
		v550.Text = "Copy AnimId"
	end)

	local v551 = Instance.new("TextButton")
	v551.Size = UDim2.new(0, v11("X", 24), 0, v11("Y", 24))
	v551.Position = UDim2.new(1, -v11("X", 30), 0, v11("Y", 5))
	v551.Text = (v543.Favorite and "★") or "☆"
	v551.TextColor3 = Color3.fromRGB(250, 204, 21)
	v551.BackgroundTransparency = 1
	v551.Font = Enum.Font.GothamBold
	v551.TextScaled = true
	v551.Parent = v545
	v551.MouseButton1Click:Connect(function()
		v543.Favorite = not v543.Favorite
		v551.Text = (v543.Favorite and "★") or "☆"
		v45()
		v244()
	end)

	v56(v545)
	return v545
end

local v324 = 0
function v244()
	v324 += 1
	local v553 = v324
	for _, v719 in ipairs(v193:GetChildren()) do
		if v719:IsA("Frame") then
			v719:Destroy()
		end
	end
	local v554 = (v159.Text or ""):lower()
	local v555 = {}
	for _, v839 in ipairs(v42) do
		if (v554 == "") or (v839.Name and v839.Name:lower():find(v554)) then
			table.insert(v555, v839)
		end
	end
	table.sort(v555, function(v720, v721)
		if v720.Favorite ~= v721.Favorite then
			return v720.Favorite
		else
			return false
		end
	end)
	if #v555 > 0 then
		v200.Visible = false
		local v761 = v258
		local v762 = 0
		for _, v937 in ipairs(v555) do
			if (v258 ~= v761) or (v553 ~= v324) then
				break
			end
			v323(v937).Parent = v193
			v762 += 1
			if (v762 % 25) == 0 then
				v16.RenderStepped:Wait()
			end
		end
	else
		v200.Visible = true
	end
	if v553 == v324 then
		v193.CanvasSize = UDim2.new(0, 0, 0, v210.AbsoluteContentSize.Y + 8)
	end
end

v87.MouseButton1Click:Connect(function()
	v258 += 1
	v114.Visible = true
	v153.Visible = false
	v87.BackgroundTransparency = 0.80
	v97.BackgroundTransparency = 0.90
end)
v159:GetPropertyChangedSignal("Text"):Connect(v244)
v97.MouseButton1Click:Connect(function()
	v258 += 1
	v114.Visible = false
	v153.Visible = true
	v87.BackgroundTransparency = 0.90
	v97.BackgroundTransparency = 0.80
	v244()
end)

v320("")

local v325 = v49
local function v326()
	v325.Enabled = not v325.Enabled
end

-- Floating iOS Glass Bubble Toggle Button
v327 = Instance.new("ScreenGui")
v327.Name = "OrionExeToggleButtonGui_iOSGlass"
v327.ResetOnSpawn = false
v327.Parent = soundParent
v327.Enabled = true
v327.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local v332 = Instance.new("TextButton")
v332.Parent = v327
v332.Text = ""
v332.Size = UDim2.new(0, 62, 0, 62)
v332.Position = UDim2.new(0, 20, 0.5, -31)
v332.AnchorPoint = Vector2.new(0, 0.5)
v332.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
v332.BackgroundTransparency = 0.3
v332.BorderSizePixel = 0
v332.Active = true
pcall(function()
	v332.Draggable = true
end)
v54(v332, 999)
local toggleGlassStroke = v55(v332, Color3.fromRGB(255, 255, 255), 1.5)
toggleGlassStroke.Transparency = 0.45

local toggleIcon = Instance.new("ImageLabel", v332)
toggleIcon.Size = UDim2.new(1, -8, 1, -8)
toggleIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
toggleIcon.AnchorPoint = Vector2.new(0.5, 0.5)
toggleIcon.BackgroundTransparency = 1
toggleIcon.Image = "rbxassetid://83861593210689"
toggleIcon.ZIndex = 3
v54(toggleIcon, 999)

local v345 = Instance.new("UIAspectRatioConstraint")
v345.Parent = v332
v345.AspectRatio = 1
v332.MouseButton1Click:Connect(v326)

-- Conditional Square Freeze ON/OFF Button on Screen (Image ID: 120137227812230)
freezeSquareGuiRef = Instance.new("ScreenGui")
freezeSquareGuiRef.Name = "OrionExeFreezeSquareGui_iOSGlass"
freezeSquareGuiRef.ResetOnSpawn = false
freezeSquareGuiRef.Parent = soundParent
freezeSquareGuiRef.Enabled = false
freezeSquareGuiRef.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local freezeSquareBtn = Instance.new("TextButton")
freezeSquareBtnRef = freezeSquareBtn
freezeSquareBtn.Parent = freezeSquareGuiRef
freezeSquareBtn.Size = UDim2.new(0, 62, 0, 62)
freezeSquareBtn.Position = UDim2.new(0, 20, 0.5, 42)
freezeSquareBtn.AnchorPoint = Vector2.new(0, 0.5)
freezeSquareBtn.BackgroundColor3 = Color3.fromRGB(127, 29, 29)
freezeSquareBtn.BackgroundTransparency = 0.25
freezeSquareBtn.BorderSizePixel = 0
freezeSquareBtn.Text = ""
freezeSquareBtn.Active = true
pcall(function()
	freezeSquareBtn.Draggable = true
end)
v54(freezeSquareBtn, 12)
v55(freezeSquareBtn, Color3.fromRGB(255, 255, 255), 1.5).Transparency = 0.45

local freezeSquareImg = Instance.new("ImageLabel", freezeSquareBtn)
freezeSquareImg.Size = UDim2.new(1, -10, 1, -10)
freezeSquareImg.Position = UDim2.new(0.5, 0, 0.5, -4)
freezeSquareImg.AnchorPoint = Vector2.new(0.5, 0.5)
freezeSquareImg.BackgroundTransparency = 1
freezeSquareImg.ScaleType = Enum.ScaleType.Fit
freezeSquareImg.Image = "rbxassetid://120137227812230"
freezeSquareImg.ZIndex = 3
v54(freezeSquareImg, 8)

local freezeSquareStateLabel = Instance.new("TextLabel", freezeSquareBtn)
freezeSquareLabelRef = freezeSquareStateLabel
freezeSquareStateLabel.Size = UDim2.new(1, -4, 0, 16)
freezeSquareStateLabel.Position = UDim2.new(0, 2, 1, -17)
freezeSquareStateLabel.BackgroundTransparency = 1
freezeSquareStateLabel.Text = "OFF"
freezeSquareStateLabel.TextColor3 = Color3.fromRGB(248, 113, 113)
freezeSquareStateLabel.Font = Enum.Font.GothamBold
freezeSquareStateLabel.TextScaled = true
freezeSquareStateLabel.ZIndex = 4

freezeSquareBtn.MouseButton1Click:Connect(function()
	setEmoteFreezeState(not emoteFrozen)
	playOptionSound()
end)

updateFreezeSquareVisibility()

-- Subtle iOS Glass Accent Animation
task.spawn(function()
	local waveTimer = 0
	while v49 and v49.Parent do
		waveTimer = (tick() * 2) % (math.pi * 2)
		local waveR = math.sin(waveTimer) * 0.15 + 0.15
		local waveG = math.sin(waveTimer + 1.5) * 0.3 + 0.5
		local waveB = math.sin(waveTimer + 3.0) * 0.2 + 0.8
		pcall(function()
			titleGlassStroke.Color = Color3.new(waveR, waveG, waveB)
			mainGlassStroke.Color = Color3.fromHSV((tick() % 6) / 6, 0.75, 1)
		end)
		task.wait(0.05)
	end
end)

v17.InputBegan:Connect(function(v561, v562)
	if v562 then
		return
	end
	if (v561.UserInputType == Enum.UserInputType.Keyboard) and (v561.KeyCode == Enum.KeyCode.X) then
		v326()
	end
end)

v49.Enabled = true
v244()

task.spawn(function()
	local v564 = game:GetService("RunService")
	local v565 = game.Players
	local v566 = v565.LocalPlayer
	local function v567(v595)
		local v597 = v595:WaitForChild("HumanoidRootPart")
		local v598 = {}
		v597.CanCollide = true
		local function v599(v764)
			if v764:IsA("BasePart") and (v764 ~= v597) then
				table.insert(v598, v764)
			end
		end
		for _, v766 in pairs(v595:GetDescendants()) do
			v599(v766)
		end
		local v600 = v595.DescendantAdded:Connect(v599)
		local v601
		v601 = v564.Heartbeat:Connect(function()
			if not v595 or not v595.Parent then
				v601:Disconnect()
				v600:Disconnect()
				return
			end
			for v898 = 1, #v598 do
				local v899 = v598[v898]
				if v899 and v899.Parent then
					v899.CanCollide = false
				end
			end
		end)
	end
	if v566.Character then
		v567(v566.Character)
	end
	v566.CharacterAdded:Connect(v567)
end)
