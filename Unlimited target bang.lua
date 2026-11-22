-- [[ UNIVERSAL UNLIMITED TARGET BANG - ANIM ONLY ON BANG ON/OFF ]] --

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait(0.1)
    LocalPlayer = Players.LocalPlayer
end

-- Auto Chat Function on Script Load
local function sendChatLine(msg)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local channels = TextChatService:FindFirstChild("TextChannels")
            local generalChannel = channels and (channels:FindFirstChild("RBXGeneral") or channels:FindFirstChild("General"))
            if generalChannel and generalChannel.SendAsync then
                generalChannel:SendAsync(msg)
                return
            end
        end
    end)

    pcall(function()
        local defaultChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        local sayMessageReq = defaultChatEvents and defaultChatEvents:FindFirstChild("SayMessageRequest")
        if sayMessageReq then
            sayMessageReq:FireServer(msg, "All")
        end
    end)
end

task.spawn(function()
    task.wait(1)
    sendChatLine("SCRIPT BY AYAN //-----------------//--------- BEST-MULTIBANG-IN-THE-WORLD👽@@@@ TARGET BE LIKE: AΒ ΚΥΑ ΚARU 😂😢@wχωου ΜADE ΒY ΑΥΑΝ HUB")
    task.wait(0.8)
    sendChatLine("MULTI BANG LOADED💀...")
end)

-- Safe GUI parent resolver for all executors (PC & Mobile)
local function getSafeGuiParent()
    if typeof(gethui) == "function" then
        local ok, ui = pcall(gethui)
        if ok and ui then return ui end
    end
    local okCore, core = pcall(function() return game:GetService("CoreGui") end)
    if okCore and core then
        local testOk = pcall(function()
            local f = Instance.new("Folder")
            f.Parent = core
            f:Destroy()
        end)
        if testOk then return core end
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local GuiParent = getSafeGuiParent()

-- Purani hubs / GUIs ko hataane ke liye cleanup
local oldGuiNames = {
    "CompactBangGui",
    "CompactMouthBangGui",
    "CompactMultiBangGui",
    "UnlimitedTargetBangGui",
    "DRX_MainGui",
    "DRX_Hub",
    "DRX_Ultimate",
    "BunnySpammerGui",
    "TalhaSpammerGui"
}

local function cleanupAllHubsAndGuis()
    for _, name in ipairs(oldGuiNames) do
        local existing = GuiParent:FindFirstChild(name)
        if existing then
            pcall(function() existing:Destroy() end)
        end
    end
    pcall(function()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg then
            for _, name in ipairs(oldGuiNames) do
                local old = pg:FindFirstChild(name)
                if old then old:Destroy() end
            end
        end
    end)
end

cleanupAllHubsAndGuis()

-- Global Variables
_G.SelectedTargets = {}       -- [Player] = true
_G.ActiveSingleTarget = nil
_G.BangMode = "MULTI"         -- "BANG", "MOUTH", "MULTI"
_G.BangSpeed = 35
_G.MultiBangSpeed = 35
_G.EmoteSpeed = 1
_G.EmoteId = "rbxassetid://105919095840646"
_G.FallbackEmoteId = "rbxassetid://148840333"
_G.BangIntensity = 2
_G.IsRunning = false

-- Smooth drag helper (works across mouse & touch on all executors)
local function makeDraggable(guiObject, dragHandle)
    local handle = dragHandle or guiObject
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function updatePos(input)
        local delta = input.Position - dragStart
        guiObject.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            updatePos(input)
        end
    end)
end

-------------------------------------------------------------------
-- GUI CREATION (MATCHING COMPACT LAYOUT)
-------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UnlimitedTargetBangGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiParent

-- Floating Toggle Button (B)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.Text = "B"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 18
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Thickness = 1.5
ToggleStroke.Color = Color3.fromRGB(80, 80, 100)

makeDraggable(ToggleBtn, ToggleBtn)

-- Main Compact Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 295)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -147)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(60, 60, 75)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 32)
Header.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
Header.BorderSizePixel = 0
Header.Parent = MainFrame
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 10)
HeaderFix.Position = UDim2.new(0, 0, 1, -10)
HeaderFix.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -46, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "UNIVERSAL MULTI BANG"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = Header

-- ❌ Remove Hub Button in Header
local RemoveHubBtn = Instance.new("TextButton")
RemoveHubBtn.Size = UDim2.new(0, 24, 0, 22)
RemoveHubBtn.Position = UDim2.new(1, -30, 0.5, -11)
RemoveHubBtn.Text = "❌"
RemoveHubBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
RemoveHubBtn.TextSize = 12
RemoveHubBtn.Font = Enum.Font.GothamBold
RemoveHubBtn.BackgroundColor3 = Color3.fromRGB(38, 22, 26)
RemoveHubBtn.Parent = Header
Instance.new("UICorner", RemoveHubBtn).CornerRadius = UDim.new(0, 6)

local RemoveHubStroke = Instance.new("UIStroke", RemoveHubBtn)
RemoveHubStroke.Thickness = 1
RemoveHubStroke.Color = Color3.fromRGB(110, 45, 50)

makeDraggable(MainFrame, Header)

-------------------------------------------------------------------
-- LEFT SIDE: SEARCH & TICKABLE TARGET LIST
-------------------------------------------------------------------
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 205, 1, -42)
LeftPanel.Position = UDim2.new(0, 8, 0, 37)
LeftPanel.BackgroundTransparency = 1
LeftPanel.Parent = MainFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, 0, 0, 28)
SearchBox.PlaceholderText = "Search Target..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 145)
SearchBox.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 11
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = LeftPanel
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 6)

local SearchStroke = Instance.new("UIStroke", SearchBox)
SearchStroke.Thickness = 1
SearchStroke.Color = Color3.fromRGB(50, 50, 65)

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, 0, 1, -34)
PlayerList.Position = UDim2.new(0, 0, 0, 34)
PlayerList.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
PlayerList.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = LeftPanel
Instance.new("UICorner", PlayerList).CornerRadius = UDim.new(0, 6)

local ListStroke = Instance.new("UIStroke", PlayerList)
ListStroke.Thickness = 1
ListStroke.Color = Color3.fromRGB(45, 45, 58)

local ListLayout = Instance.new("UIListLayout", PlayerList)
ListLayout.Padding = UDim.new(0, 4)

local ListPadding = Instance.new("UIPadding", PlayerList)
ListPadding.PaddingTop = UDim.new(0, 4)
ListPadding.PaddingBottom = UDim.new(0, 4)
ListPadding.PaddingLeft = UDim.new(0, 4)
ListPadding.PaddingRight = UDim.new(0, 4)

-------------------------------------------------------------------
-- RIGHT SIDE: SELECTED TARGETS, SPEEDS, EMOTE SPEED, MODE & START
-------------------------------------------------------------------
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0, 132, 1, -42)
RightPanel.Position = UDim2.new(0, 220, 0, 37)
RightPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
RightPanel.Parent = MainFrame
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 6)

local RightStroke = Instance.new("UIStroke", RightPanel)
RightStroke.Thickness = 1
RightStroke.Color = Color3.fromRGB(45, 45, 58)

local SelectedTitle = Instance.new("TextLabel")
SelectedTitle.Size = UDim2.new(1, -10, 0, 12)
SelectedTitle.Position = UDim2.new(0, 5, 0, 3)
SelectedTitle.Text = "SELECTED:"
SelectedTitle.TextColor3 = Color3.fromRGB(140, 140, 155)
SelectedTitle.Font = Enum.Font.GothamBold
SelectedTitle.TextSize = 8
SelectedTitle.BackgroundTransparency = 1
SelectedTitle.Parent = RightPanel

local SelectedName = Instance.new("TextLabel")
SelectedName.Size = UDim2.new(1, -10, 0, 14)
SelectedName.Position = UDim2.new(0, 5, 0, 14)
SelectedName.Text = "None (0)"
SelectedName.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedName.Font = Enum.Font.GothamBold
SelectedName.TextSize = 10
SelectedName.TextTruncate = Enum.TextTruncate.AtEnd
SelectedName.BackgroundTransparency = 1
SelectedName.Parent = RightPanel

-- Custom Speed Box
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -10, 0, 12)
SpeedLabel.Position = UDim2.new(0, 5, 0, 30)
SpeedLabel.Text = "CUSTOM SPEED:"
SpeedLabel.TextColor3 = Color3.fromRGB(140, 140, 155)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 8
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Parent = RightPanel

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(1, -16, 0, 22)
SpeedBox.Position = UDim2.new(0, 8, 0, 42)
SpeedBox.PlaceholderText = "Speed (e.g. 35)"
SpeedBox.Text = "35"
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 135)
SpeedBox.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.TextSize = 11
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = RightPanel
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 6)

local SpeedStroke = Instance.new("UIStroke", SpeedBox)
SpeedStroke.Thickness = 1
SpeedStroke.Color = Color3.fromRGB(65, 65, 80)

SpeedBox.FocusLost:Connect(function()
    local num = tonumber(SpeedBox.Text)
    if num and num > 0 then
        _G.BangSpeed = num
    else
        SpeedBox.Text = tostring(_G.BangSpeed)
    end
end)

-- 2 Sec Custom Multi Bang Speed TextBox
local MultiSpeedLabel = Instance.new("TextLabel")
MultiSpeedLabel.Size = UDim2.new(1, -10, 0, 12)
MultiSpeedLabel.Position = UDim2.new(0, 5, 0, 66)
MultiSpeedLabel.Text = "2 SEC MULTI BANG SPEED:"
MultiSpeedLabel.TextColor3 = Color3.fromRGB(140, 140, 155)
MultiSpeedLabel.Font = Enum.Font.GothamBold
MultiSpeedLabel.TextSize = 8
MultiSpeedLabel.TextTruncate = Enum.TextTruncate.AtEnd
MultiSpeedLabel.BackgroundTransparency = 1
MultiSpeedLabel.Parent = RightPanel

local MultiSpeedBox = Instance.new("TextBox")
MultiSpeedBox.Size = UDim2.new(1, -16, 0, 22)
MultiSpeedBox.Position = UDim2.new(0, 8, 0, 78)
MultiSpeedBox.PlaceholderText = "2s Speed (e.g. 35)"
MultiSpeedBox.Text = "35"
MultiSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MultiSpeedBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 135)
MultiSpeedBox.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
MultiSpeedBox.Font = Enum.Font.GothamBold
MultiSpeedBox.TextSize = 11
MultiSpeedBox.ClearTextOnFocus = false
MultiSpeedBox.Parent = RightPanel
Instance.new("UICorner", MultiSpeedBox).CornerRadius = UDim.new(0, 6)

local MultiSpeedStroke = Instance.new("UIStroke", MultiSpeedBox)
MultiSpeedStroke.Thickness = 1
MultiSpeedStroke.Color = Color3.fromRGB(65, 65, 80)

MultiSpeedBox.FocusLost:Connect(function()
    local num = tonumber(MultiSpeedBox.Text)
    if num and num > 0 then
        _G.MultiBangSpeed = num
    else
        MultiSpeedBox.Text = tostring(_G.MultiBangSpeed)
    end
end)

-- Custom Emote Speed TextBox
local EmoteSpeedLabel = Instance.new("TextLabel")
EmoteSpeedLabel.Size = UDim2.new(1, -10, 0, 12)
EmoteSpeedLabel.Position = UDim2.new(0, 5, 0, 102)
EmoteSpeedLabel.Text = "CUSTOM EMOTE SPEED:"
EmoteSpeedLabel.TextColor3 = Color3.fromRGB(140, 140, 155)
EmoteSpeedLabel.Font = Enum.Font.GothamBold
EmoteSpeedLabel.TextSize = 8
EmoteSpeedLabel.TextTruncate = Enum.TextTruncate.AtEnd
EmoteSpeedLabel.BackgroundTransparency = 1
EmoteSpeedLabel.Parent = RightPanel

local EmoteSpeedBox = Instance.new("TextBox")
EmoteSpeedBox.Size = UDim2.new(1, -16, 0, 22)
EmoteSpeedBox.Position = UDim2.new(0, 8, 0, 114)
EmoteSpeedBox.PlaceholderText = "Emote Speed (e.g. 1)"
EmoteSpeedBox.Text = "1"
EmoteSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EmoteSpeedBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 135)
EmoteSpeedBox.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
EmoteSpeedBox.Font = Enum.Font.GothamBold
EmoteSpeedBox.TextSize = 11
EmoteSpeedBox.ClearTextOnFocus = false
EmoteSpeedBox.Parent = RightPanel
Instance.new("UICorner", EmoteSpeedBox).CornerRadius = UDim.new(0, 6)

local EmoteSpeedStroke = Instance.new("UIStroke", EmoteSpeedBox)
EmoteSpeedStroke.Thickness = 1
EmoteSpeedStroke.Color = Color3.fromRGB(65, 65, 80)

local bangAnimTrack = nil
local cachedAnimChar = nil
local cachedAnimId = nil
local emotePhase = 0
local savedJointTransforms = {}

local function applyEmoteSpeedToTrack()
    if _G.IsRunning and bangAnimTrack then
        pcall(function()
            bangAnimTrack:AdjustSpeed(tonumber(_G.EmoteSpeed) or 1)
        end)
    end
end

EmoteSpeedBox.FocusLost:Connect(function()
    local num = tonumber(EmoteSpeedBox.Text)
    if num and num > 0 then
        _G.EmoteSpeed = num
        applyEmoteSpeedToTrack()
    else
        EmoteSpeedBox.Text = tostring(_G.EmoteSpeed)
    end
end)

-- Mode Cycle Button (BANG / MOUTH / MULTI)
local ModeBtn = Instance.new("TextButton")
ModeBtn.Size = UDim2.new(1, -16, 0, 23)
ModeBtn.Position = UDim2.new(0, 8, 0, 142)
ModeBtn.Text = "MODE: MULTI"
ModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ModeBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 48)
ModeBtn.Font = Enum.Font.GothamBold
ModeBtn.TextSize = 10
ModeBtn.Parent = RightPanel
Instance.new("UICorner", ModeBtn).CornerRadius = UDim.new(0, 6)

local ModeStroke = Instance.new("UIStroke", ModeBtn)
ModeStroke.Thickness = 1
ModeStroke.Color = Color3.fromRGB(75, 75, 95)

local modeOrder = {"BANG", "MOUTH", "MULTI"}
ModeBtn.MouseButton1Click:Connect(function()
    local idx = 1
    for i, m in ipairs(modeOrder) do
        if m == _G.BangMode then
            idx = (i % #modeOrder) + 1
            break
        end
    end
    _G.BangMode = modeOrder[idx]
    ModeBtn.Text = "MODE: " .. _G.BangMode
end)

-- Start / Stop Button
local BangBtn = Instance.new("TextButton")
BangBtn.Size = UDim2.new(1, -16, 0, 34)
BangBtn.Position = UDim2.new(0, 8, 1, -40)
BangBtn.Text = "MULTI BANG: OFF"
BangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BangBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
BangBtn.Font = Enum.Font.GothamBold
BangBtn.TextSize = 10
BangBtn.Parent = RightPanel
Instance.new("UICorner", BangBtn).CornerRadius = UDim.new(0, 6)

local BangStroke = Instance.new("UIStroke", BangBtn)
BangStroke.Thickness = 1
BangStroke.Color = Color3.fromRGB(70, 70, 85)

-------------------------------------------------------------------
-- UNLIMITED TARGETS ENGINE (ANIM ONLY WHEN BANG IS RUNNING)
-------------------------------------------------------------------
local bangConn = nil

local function getOrderedTargets()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and _G.SelectedTargets[plr] then
            table.insert(list, plr)
        end
    end
    if #list == 0 and _G.ActiveSingleTarget and _G.ActiveSingleTarget.Parent then
        table.insert(list, _G.ActiveSingleTarget)
    end
    return list
end

local function restoreJoints(char)
    for joint, originalC0 in pairs(savedJointTransforms) do
        if joint and joint.Parent then
            pcall(function()
                joint.C0 = originalC0
            end)
        end
    end
    table.clear(savedJointTransforms)
    emotePhase = 0
end

local function stopActiveAnimation()
    if bangAnimTrack then
        pcall(function()
            bangAnimTrack:Stop(0.05)
        end)
    end
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                if track == bangAnimTrack or (track.Animation and tostring(track.Animation.AnimationId):find("105919095840646")) then
                    pcall(function() track:Stop(0.05) end)
                end
            end
        end
        restoreJoints(char)
    end
end

local function stepFallbackJointMotion(char, dt)
    if not _G.IsRunning or not char or not char.Parent then return end
    local spd = tonumber(_G.EmoteSpeed) or 1
    emotePhase = emotePhase + (dt * spd * 4)
    local swing = math.sin(emotePhase)

    for _, desc in ipairs(char:GetDescendants()) do
        if desc:IsA("Motor6D") then
            if savedJointTransforms[desc] == nil then
                savedJointTransforms[desc] = desc.C0
            end
            local baseC0 = savedJointTransforms[desc]
            local jName = desc.Name:lower()
            pcall(function()
                if jName:find("hip") or jName:find("root") or jName:find("waist") then
                    desc.C0 = baseC0 * CFrame.Angles(math.rad(swing * 18), 0, 0)
                elseif jName:find("shoulder") or jName:find("arm") then
                    desc.C0 = baseC0 * CFrame.Angles(math.rad(-swing * 12), 0, 0)
                end
            end)
        end
    end
end

local function loadTrackOnAnimator(animator, animId)
    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    local track = animator:LoadAnimation(anim)
    track.Looped = true
    pcall(function()
        track.Priority = Enum.AnimationPriority.Action
    end)
    return track
end

local function ensureBangAnimation(char, hum)
    if not _G.IsRunning then
        stopActiveAnimation()
        return
    end
    if not char or not hum or hum.Health <= 0 then return end

    local desiredId = tostring(_G.EmoteId or "rbxassetid://105919095840646")
    if cachedAnimChar ~= char or not bangAnimTrack or cachedAnimId ~= desiredId then
        if bangAnimTrack then
            pcall(function() bangAnimTrack:Stop(0) end)
            bangAnimTrack = nil
        end
        cachedAnimChar = char
        cachedAnimId = desiredId

        pcall(function()
            local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
            local okLoad, track = pcall(loadTrackOnAnimator, animator, desiredId)
            if okLoad and track then
                bangAnimTrack = track
            else
                local fallbackId = tostring(_G.FallbackEmoteId or "rbxassetid://148840333")
                local okFb, fbTrack = pcall(loadTrackOnAnimator, animator, fallbackId)
                if okFb and fbTrack then
                    bangAnimTrack = fbTrack
                    cachedAnimId = fallbackId
                end
            end
        end)
    end

    if bangAnimTrack then
        pcall(function()
            if not bangAnimTrack.IsPlaying then
                bangAnimTrack:Play(0.05, 1, tonumber(_G.EmoteSpeed) or 1)
            else
                bangAnimTrack:AdjustSpeed(tonumber(_G.EmoteSpeed) or 1)
            end
        end)
    end
end

local function stopBangEngine()
    _G.IsRunning = false
    if BangBtn and BangBtn.Parent then
        BangBtn.Text = "MULTI BANG: OFF"
        BangBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        BangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        BangStroke.Color = Color3.fromRGB(70, 70, 85)
    end

    if bangConn then
        bangConn:Disconnect()
        bangConn = nil
    end

    stopActiveAnimation()
end

local function getTargetAnchors(plr)
    if not plr then return nil, nil end
    local char = plr.Character
    if not char or not char.Parent then return nil, nil end

    local root = char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChildWhichIsA("BasePart")

    if not root or not root:IsA("BasePart") then
        return nil, nil
    end

    local head = char:FindFirstChild("Head")
    local mouthCF = (head and head:IsA("BasePart"))
        and (head.CFrame * CFrame.new(0, 0.35, 0))
        or (root.CFrame * CFrame.new(0, 2.35, 0))

    return root.CFrame, mouthCF
end

local function getMyRoot(char)
    if not char or not char.Parent then return nil end
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("UpperTorso")
end

local function updateSelectedSummary()
    local list = getOrderedTargets()
    if #list == 0 then
        SelectedName.Text = "None (0)"
    elseif #list == 1 then
        SelectedName.Text = list[1].DisplayName .. " (@" .. list[1].Name .. ")"
    else
        SelectedName.Text = tostring(#list) .. " Targets (1s each)"
    end
end

local function startBangEngine()
    stopBangEngine()
    local targets = getOrderedTargets()
    if #targets == 0 then return end

    local char = LocalPlayer.Character
    local myRoot = getMyRoot(char)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not myRoot then return end

    _G.IsRunning = true
    BangBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BangBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    BangStroke.Color = Color3.fromRGB(200, 200, 200)

    ensureBangAnimation(char, hum)

    local timer = 0
    local targetTimer = 0
    local targetIndex = 1
    local multiPhaseTimer = 0
    local multiPhase = "Back"

    bangConn = RunService.Heartbeat:Connect(function(dt)
        if not _G.IsRunning then
            stopBangEngine()
            return
        end

        targets = getOrderedTargets()
        if #targets == 0 then
            stopBangEngine()
            return
        end

        -- 1.0 second per target switching
        targetTimer = targetTimer + dt
        if targetTimer >= 1.0 then
            targetTimer = targetTimer - 1.0
            targetIndex = (targetIndex % #targets) + 1
        end
        if targetIndex > #targets then
            targetIndex = 1
        end

        local currentTarget = targets[targetIndex]
        local myChar = LocalPlayer.Character
        local currentRoot = getMyRoot(myChar)
        local currentHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        local backCF, mouthCF = getTargetAnchors(currentTarget)

        if not backCF or not mouthCF or not currentRoot then
            return
        end

        ensureBangAnimation(myChar, currentHum)
        if not bangAnimTrack or not bangAnimTrack.IsPlaying then
            stepFallbackJointMotion(myChar, dt)
        end

        if currentHum then
            pcall(function()
                local state = currentHum:GetState()
                if state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Ragdoll then
                    currentHum:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
                currentHum.Sit = false
                currentHum.PlatformStand = false
            end)
        end

        local baseSpeed = tonumber(_G.BangSpeed) or 35
        local twoSecMultiSpeed = tonumber(_G.MultiBangSpeed) or baseSpeed
        local subMode = _G.BangMode

        if subMode == "MULTI" then
            multiPhaseTimer = (multiPhaseTimer + dt) % 4
            multiPhase = (multiPhaseTimer < 2) and "Back" or "Mouth"
            subMode = (multiPhase == "Back") and "BANG" or "MOUTH"
        end

        local activeSpeed = (multiPhase == "Mouth" or subMode == "MOUTH") and twoSecMultiSpeed or baseSpeed
        timer = timer + (dt * activeSpeed)
        local moveOffset = math.sin(timer) * (tonumber(_G.BangIntensity) or 2)

        if subMode == "MOUTH" then
            currentRoot.CFrame = mouthCF * CFrame.new(0, 0.35, -1.0 - moveOffset) * CFrame.Angles(0, math.rad(180), 0)
        else
            currentRoot.CFrame = backCF * CFrame.new(0, 0, 1.1 + moveOffset)
        end

        if BangBtn and BangBtn.Parent then
            BangBtn.Text = string.format("%s: %s", subMode, currentTarget.Name)
        end

        pcall(function()
            currentRoot.AssemblyLinearVelocity = Vector3.zero
            currentRoot.AssemblyAngularVelocity = Vector3.zero
        end)
    end)
end

BangBtn.MouseButton1Click:Connect(function()
    if _G.IsRunning then
        stopBangEngine()
    else
        if #getOrderedTargets() > 0 then
            startBangEngine()
        end
    end
end)

-- ❌ Hub Remove Handler
RemoveHubBtn.MouseButton1Click:Connect(function()
    stopBangEngine()
    table.clear(_G.SelectedTargets)
    _G.ActiveSingleTarget = nil
    cleanupAllHubsAndGuis()
    pcall(function()
        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end)
end)

-------------------------------------------------------------------
-- TARGET LIST WITH RIGHT-SIDE TICK BOX & SEARCH
-------------------------------------------------------------------
local function refreshPlayerList()
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local query = SearchBox.Text:lower():gsub("%s+", "")

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local matchName = plr.Name:lower():find(query, 1, true)
            local matchDisplay = plr.DisplayName:lower():find(query, 1, true)

            if query == "" or matchName or matchDisplay then
                local isTicked = _G.SelectedTargets[plr] == true
                local isSingleSelected = (_G.ActiveSingleTarget == plr)

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 28)
                row.BackgroundColor3 = (isTicked or isSingleSelected) and Color3.fromRGB(48, 48, 66) or Color3.fromRGB(30, 30, 38)
                row.Parent = PlayerList
                Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

                local selectBtn = Instance.new("TextButton")
                selectBtn.Size = UDim2.new(1, -32, 1, 0)
                selectBtn.Position = UDim2.new(0, 0, 0, 0)
                selectBtn.BackgroundTransparency = 1
                selectBtn.Text = "  " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
                selectBtn.TextColor3 = Color3.fromRGB(235, 235, 245)
                selectBtn.Font = Enum.Font.GothamMedium
                selectBtn.TextSize = 10
                selectBtn.TextXAlignment = Enum.TextXAlignment.Left
                selectBtn.TextTruncate = Enum.TextTruncate.AtEnd
                selectBtn.Parent = row

                -- Side Tick Box on Right
                local tickBox = Instance.new("TextButton")
                tickBox.Size = UDim2.new(0, 22, 0, 22)
                tickBox.Position = UDim2.new(1, -25, 0.5, -11)
                tickBox.Text = isTicked and "✓" or ""
                tickBox.TextColor3 = isTicked and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(200, 200, 215)
                tickBox.BackgroundColor3 = isTicked and Color3.fromRGB(110, 255, 150) or Color3.fromRGB(42, 42, 54)
                tickBox.Font = Enum.Font.GothamBold
                tickBox.TextSize = 13
                tickBox.Parent = row
                Instance.new("UICorner", tickBox).CornerRadius = UDim.new(0, 4)

                local function toggleTick()
                    if _G.SelectedTargets[plr] then
                        _G.SelectedTargets[plr] = nil
                    else
                        _G.SelectedTargets[plr] = true
                    end
                    updateSelectedSummary()
                    refreshPlayerList()
                end

                selectBtn.MouseButton1Click:Connect(function()
                    _G.ActiveSingleTarget = plr
                    if not _G.SelectedTargets[plr] then
                        _G.SelectedTargets[plr] = true
                    end
                    updateSelectedSummary()
                    refreshPlayerList()
                end)

                tickBox.MouseButton1Click:Connect(toggleTick)
            end
        end
    end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(refreshPlayerList)

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(function(plr)
    _G.SelectedTargets[plr] = nil
    if _G.ActiveSingleTarget == plr then
        _G.ActiveSingleTarget = nil
    end
    updateSelectedSummary()
    if _G.IsRunning and #getOrderedTargets() == 0 then
        stopBangEngine()
    end
    task.wait(0.1)
    refreshPlayerList()
end)

updateSelectedSummary()
refreshPlayerList()
