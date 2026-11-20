-- [[ UNIVERSAL COMPACT BANG GUI - AUTO CHAT ON LOAD ]] --

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
local function sendLoadChatMessage(msg)
    task.spawn(function()
        task.wait(1)
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
    end)
end

sendLoadChatMessage("SCRIPT BY AYAN //-----------------//--------- BEST-BANG-IN-THE-WORLD👽@@@@ TARGET BE LIKE: AΒ ΚΥΑ ΚARU 😂😢@wχωου ΜADE ΒY ΑΥΑΝ HUB BANG LOADED💀...")


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
_G.TargetPlayerObj = nil
_G.BangSpeed = 35
_G.BangIntensity = 2
_G.IsBanging = false

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
-- GUI CREATION (COMPACT UNIVERSAL DESIGN)
-------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CompactBangGui"
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
MainFrame.Size = UDim2.new(0, 340, 0, 220)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -110)
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
Title.Text = "UNIVERSAL BANG MADE BY AYANUU"
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
-- LEFT SIDE: SEARCH & TARGET LIST
-------------------------------------------------------------------
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 185, 1, -42)
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
-- RIGHT SIDE: SELECTED TARGET, BANG BUTTON & CUSTOM SPEED BOX
-------------------------------------------------------------------
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0, 132, 1, -42)
RightPanel.Position = UDim2.new(0, 200, 0, 37)
RightPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
RightPanel.Parent = MainFrame
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 6)

local RightStroke = Instance.new("UIStroke", RightPanel)
RightStroke.Thickness = 1
RightStroke.Color = Color3.fromRGB(45, 45, 58)

local SelectedTitle = Instance.new("TextLabel")
SelectedTitle.Size = UDim2.new(1, -10, 0, 16)
SelectedTitle.Position = UDim2.new(0, 5, 0, 6)
SelectedTitle.Text = "SELECTED:"
SelectedTitle.TextColor3 = Color3.fromRGB(140, 140, 155)
SelectedTitle.Font = Enum.Font.GothamBold
SelectedTitle.TextSize = 9
SelectedTitle.BackgroundTransparency = 1
SelectedTitle.Parent = RightPanel

local SelectedName = Instance.new("TextLabel")
SelectedName.Size = UDim2.new(1, -10, 0, 20)
SelectedName.Position = UDim2.new(0, 5, 0, 20)
SelectedName.Text = "None"
SelectedName.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedName.Font = Enum.Font.GothamBold
SelectedName.TextSize = 11
SelectedName.TextTruncate = Enum.TextTruncate.AtEnd
SelectedName.BackgroundTransparency = 1
SelectedName.Parent = RightPanel

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -10, 0, 16)
SpeedLabel.Position = UDim2.new(0, 5, 0, 48)
SpeedLabel.Text = "CUSTOM SPEED:"
SpeedLabel.TextColor3 = Color3.fromRGB(140, 140, 155)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 9
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Parent = RightPanel

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(1, -16, 0, 30)
SpeedBox.Position = UDim2.new(0, 8, 0, 65)
SpeedBox.PlaceholderText = "Speed (e.g. 35)"
SpeedBox.Text = "35"
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 135)
SpeedBox.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.TextSize = 12
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

local BangBtn = Instance.new("TextButton")
BangBtn.Size = UDim2.new(1, -16, 0, 42)
BangBtn.Position = UDim2.new(0, 8, 1, -50)
BangBtn.Text = "BANG: OFF"
BangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BangBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
BangBtn.Font = Enum.Font.GothamBold
BangBtn.TextSize = 12
BangBtn.Parent = RightPanel
Instance.new("UICorner", BangBtn).CornerRadius = UDim.new(0, 6)

local BangStroke = Instance.new("UIStroke", BangBtn)
BangStroke.Thickness = 1
BangStroke.Color = Color3.fromRGB(70, 70, 85)

-------------------------------------------------------------------
-- UNLIMITED RANGE BANG ENGINE (ALL GAMES & EXECUTORS SAFE)
-------------------------------------------------------------------
local bangAnimTrack = nil
local bangConn = nil
local cachedAnimChar = nil

local function stopBang()
    _G.IsBanging = false
    if BangBtn and BangBtn.Parent then
        BangBtn.Text = "BANG: OFF"
        BangBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        BangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        BangStroke.Color = Color3.fromRGB(70, 70, 85)
    end

    if bangConn then
        bangConn:Disconnect()
        bangConn = nil
    end
    if bangAnimTrack then
        pcall(function() bangAnimTrack:Stop() end)
    end
end

local function ensureBangAnimation(char, hum)
    if not char or not hum then return end
    if cachedAnimChar ~= char or not bangAnimTrack then
        cachedAnimChar = char
        pcall(function()
            local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://148840333"
            bangAnimTrack = animator:LoadAnimation(anim)
            bangAnimTrack.Looped = true
        end)
    end
    if bangAnimTrack and not bangAnimTrack.IsPlaying then
        pcall(function() bangAnimTrack:Play() end)
    end
end

local function getTargetRoot(plr)
    if not plr then return nil end
    local char = plr.Character
    if not char or not char.Parent then return nil end
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChildWhichIsA("BasePart")
end

local function getMyRoot(char)
    if not char or not char.Parent then return nil end
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("UpperTorso")
end

local function startBang()
    stopBang()
    if not _G.TargetPlayerObj then return end

    local char = LocalPlayer.Character
    local myRoot = getMyRoot(char)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not myRoot then return end

    _G.IsBanging = true
    BangBtn.Text = "BANG: ON"
    BangBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BangBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    BangStroke.Color = Color3.fromRGB(200, 200, 200)

    ensureBangAnimation(char, hum)

    local timer = 0
    bangConn = RunService.Heartbeat:Connect(function(dt)
        if not _G.IsBanging then
            stopBang()
            return
        end

        local myChar = LocalPlayer.Character
        local currentRoot = getMyRoot(myChar)
        local currentHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        local tPart = getTargetRoot(_G.TargetPlayerObj)

        if not tPart or not currentRoot then
            return
        end

        ensureBangAnimation(myChar, currentHum)

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

        timer = timer + (dt * (tonumber(_G.BangSpeed) or 35))
        local moveOffset = math.sin(timer) * (tonumber(_G.BangIntensity) or 2)

        local targetCF = (tPart:IsA("BasePart")) and tPart.CFrame or CFrame.new(tPart.Position)
        currentRoot.CFrame = targetCF * CFrame.new(0, 0, 1.1 + moveOffset)

        pcall(function()
            currentRoot.AssemblyLinearVelocity = Vector3.zero
            currentRoot.AssemblyAngularVelocity = Vector3.zero
        end)
    end)
end

BangBtn.MouseButton1Click:Connect(function()
    if _G.IsBanging then
        stopBang()
    else
        if _G.TargetPlayerObj then
            startBang()
        end
    end
end)

-- ❌ Hub Remove Handler
RemoveHubBtn.MouseButton1Click:Connect(function()
    stopBang()
    _G.TargetPlayerObj = nil
    cleanupAllHubsAndGuis()
    pcall(function()
        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end)
end)

-------------------------------------------------------------------
-- TARGET LIST & SEARCH UPDATER
-------------------------------------------------------------------
local function selectPlayer(plr)
    _G.TargetPlayerObj = plr
    SelectedName.Text = plr.DisplayName .. " (@" .. plr.Name .. ")"
    if _G.IsBanging then
        startBang()
    end
end

local function refreshPlayerList()
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local query = SearchBox.Text:lower():gsub("%s+", "")

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local matchName = plr.Name:lower():find(query, 1, true)
            local matchDisplay = plr.DisplayName:lower():find(query, 1, true)

            if query == "" or matchName or matchDisplay then
                local item = Instance.new("TextButton")
                item.Size = UDim2.new(1, 0, 0, 26)
                item.BackgroundColor3 = (_G.TargetPlayerObj == plr) and Color3.fromRGB(60, 60, 80) or Color3.fromRGB(30, 30, 38)
                item.Text = "  " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
                item.TextColor3 = Color3.fromRGB(235, 235, 245)
                item.Font = Enum.Font.GothamMedium
                item.TextSize = 10
                item.TextXAlignment = Enum.TextXAlignment.Left
                item.TextTruncate = Enum.TextTruncate.AtEnd
                item.Parent = PlayerList
                Instance.new("UICorner", item).CornerRadius = UDim.new(0, 5)

                item.MouseButton1Click:Connect(function()
                    selectPlayer(plr)
                    refreshPlayerList()
                end)
            end
        end
    end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(refreshPlayerList)

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(function(plr)
    if _G.TargetPlayerObj == plr then
        _G.TargetPlayerObj = nil
        SelectedName.Text = "None"
        stopBang()
    end
    task.wait(0.1)
    refreshPlayerList()
end)

refreshPlayerList()
