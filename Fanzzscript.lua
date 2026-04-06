-- FANZZ DEAD RAILS SUITE - ULTIMATE (FINAL ULTIMATE)
-- by FanzzSenpai
-- Fitur: Auto Bonds, Fake Hitbox, Real Hitbox (max 4), Kill Aura (auto melee)

if game.CoreGui:FindFirstChild("FanzzDeadRails") then
    game.CoreGui.FanzzDeadRails:Destroy()
end

local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Cari remote SwingMelee dengan aman
local swingRemote = replicatedStorage:FindFirstChild("Shared") and 
                    replicatedStorage.Shared:FindFirstChild("Universe") and
                    replicatedStorage.Shared.Universe:FindFirstChild("Network") and
                    replicatedStorage.Shared.Universe.Network:FindFirstChild("RemoteEvent") and
                    replicatedStorage.Shared.Universe.Network.RemoteEvent:FindFirstChild("SwingMelee")

if not swingRemote then
    warn("[FANZZ] SwingMelee remote not found! Kill Aura tidak akan berfungsi.")
end

-- ========== GUI PARENT ==========
local guiParent = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FanzzDeadRails"
screenGui.ResetOnSpawn = false
screenGui.Parent = guiParent

-- ========== MAIN FRAME ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 420)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- ========== HEADER ==========
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local nameTitle = Instance.new("TextLabel")
nameTitle.Size = UDim2.new(0, 140, 0, 35)
nameTitle.Position = UDim2.new(0, 10, 0, 0)
nameTitle.Text = "FanzzSenpai"
nameTitle.TextColor3 = Color3.fromRGB(255, 200, 100)
nameTitle.BackgroundTransparency = 1
nameTitle.Font = Enum.Font.GothamBold
nameTitle.TextSize = 14
nameTitle.TextXAlignment = Enum.TextXAlignment.Left
nameTitle.Parent = header

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -62, 0, 4)
minBtn.Text = "─"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.BorderSizePixel = 0
minBtn.Parent = header

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -30, 0, 4)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- ========== DRAG SYSTEM ==========
local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragInput, mousePos, framePos

local function update(input)
    local delta = input.Position - mousePos
    mainFrame.Position = UDim2.new(
        framePos.X.Scale,
        framePos.X.Offset + delta.X,
        framePos.Y.Scale,
        framePos.Y.Offset + delta.Y
    )
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- ========== BODY FRAME ==========
local bodyFrame = Instance.new("Frame")
bodyFrame.Size = UDim2.new(1, -12, 0, 340)
bodyFrame.Position = UDim2.new(0, 6, 0, 43)
bodyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
bodyFrame.BackgroundTransparency = 0.5
bodyFrame.BorderSizePixel = 0
bodyFrame.Parent = mainFrame

local bodyCorner = Instance.new("UICorner")
bodyCorner.CornerRadius = UDim.new(0, 10)
bodyCorner.Parent = bodyFrame

-- ========== STATUS LABELS ==========
local statusBonds = Instance.new("TextLabel")
statusBonds.Size = UDim2.new(1, -20, 0, 16)
statusBonds.Position = UDim2.new(0, 10, 0, 240)
statusBonds.Text = "Bonds: OFF"
statusBonds.TextColor3 = Color3.fromRGB(255, 100, 100)
statusBonds.BackgroundTransparency = 1
statusBonds.Font = Enum.Font.Gotham
statusBonds.TextSize = 10
statusBonds.TextXAlignment = Enum.TextXAlignment.Left
statusBonds.Parent = bodyFrame

local statusFake = Instance.new("TextLabel")
statusFake.Size = UDim2.new(1, -20, 0, 16)
statusFake.Position = UDim2.new(0, 10, 0, 260)
statusFake.Text = "Fake: OFF"
statusFake.TextColor3 = Color3.fromRGB(255, 100, 100)
statusFake.BackgroundTransparency = 1
statusFake.Font = Enum.Font.Gotham
statusFake.TextSize = 10
statusFake.TextXAlignment = Enum.TextXAlignment.Left
statusFake.Parent = bodyFrame

local statusReal = Instance.new("TextLabel")
statusReal.Size = UDim2.new(1, -20, 0, 16)
statusReal.Position = UDim2.new(0, 10, 0, 280)
statusReal.Text = "Real: OFF"
statusReal.TextColor3 = Color3.fromRGB(255, 100, 100)
statusReal.BackgroundTransparency = 1
statusReal.Font = Enum.Font.Gotham
statusReal.TextSize = 10
statusReal.TextXAlignment = Enum.TextXAlignment.Left
statusReal.Parent = bodyFrame

local statusKillAura = Instance.new("TextLabel")
statusKillAura.Size = UDim2.new(1, -20, 0, 16)
statusKillAura.Position = UDim2.new(0, 10, 0, 300)
statusKillAura.Text = "Kill Aura: OFF"
statusKillAura.TextColor3 = Color3.fromRGB(255, 100, 100)
statusKillAura.BackgroundTransparency = 1
statusKillAura.Font = Enum.Font.Gotham
statusKillAura.TextSize = 10
statusKillAura.TextXAlignment = Enum.TextXAlignment.Left
statusKillAura.Parent = bodyFrame

local bondLabel = Instance.new("TextLabel")
bondLabel.Size = UDim2.new(1, -20, 0, 24)
bondLabel.Position = UDim2.new(0, 10, 0, 320)
bondLabel.Text = "Bonds: 0"
bondLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
bondLabel.BackgroundTransparency = 1
bondLabel.Font = Enum.Font.GothamBold
bondLabel.TextSize = 14
bondLabel.TextXAlignment = Enum.TextXAlignment.Left
bondLabel.Parent = bodyFrame

-- ========== AUTO BONDS ==========
local function getActionableRemote()
    local remote = game:GetService("ReplicatedStorage")
    if not remote then return nil end
    local shared = remote:FindFirstChild("Shared")
    if not shared then return nil end
    local universe = shared:FindFirstChild("Universe")
    if not universe then return nil end
    local network = universe:FindFirstChild("Network")
    if not network then return nil end
    local remoteEvent = network:FindFirstChild("RemoteEvent")
    if not remoteEvent then return nil end
    return remoteEvent:FindFirstChild("Actionable") or remoteEvent
end

local bondActive = false
local totalBondsStart = 0
local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(1, -20, 0, 16)
timerLabel.Position = UDim2.new(0, 10, 0, 230)
timerLabel.Text = "Time: 0s"
timerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
timerLabel.BackgroundTransparency = 1
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextSize = 10
timerLabel.Parent = bodyFrame
timerLabel.Visible = false

local progressLabel = Instance.new("TextLabel")
progressLabel.Size = UDim2.new(1, -20, 0, 16)
progressLabel.Position = UDim2.new(0, 10, 0, 210)
progressLabel.Text = "Progress: 0%"
progressLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
progressLabel.BackgroundTransparency = 1
progressLabel.Font = Enum.Font.Gotham
progressLabel.TextSize = 9
progressLabel.Parent = bodyFrame
progressLabel.Visible = false

local function startBonds()
    if bondActive then return end
    bondActive = true
    statusBonds.Text = "Bonds: ACTIVE"
    statusBonds.TextColor3 = Color3.fromRGB(0, 255, 0)
    timerLabel.Visible = true
    progressLabel.Visible = true

    local startTime = tick()
    local totalSent = 0

    local ls = player:FindFirstChild("leaderstats")
    if ls then
        for _, v in ipairs(ls:GetChildren()) do
            if v.Name:lower():find("bond") then
                totalBondsStart = v.Value
                break
            end
        end
    end

    task.spawn(function()
        local actionable = getActionableRemote()
        if not actionable then
            print("[ERROR] Remote event tidak ditemukan!")
            bondActive = false
            statusBonds.Text = "Bonds: ERROR"
            timerLabel.Visible = false
            progressLabel.Visible = false
            return
        end

        local startRange = 500
        local endRange = 3000
        local delay = 0.05

        while bondActive do
            for i = startRange, endRange do
                if not bondActive then break end
                actionable:FireServer(i)
                totalSent = totalSent + 1
                task.wait(delay)

                if totalSent % 100 == 0 then
                    local progress = ((i - startRange) / (endRange - startRange)) * 100
                    progressLabel.Text = string.format("Progress: %.1f%%", progress)
                end
            end

            local elapsed = tick() - startTime
            timerLabel.Text = "Time: "..math.floor(elapsed).."s"

            local ls = player:FindFirstChild("leaderstats")
            if ls then
                for _, v in ipairs(ls:GetChildren()) do
                    if v.Name:lower():find("bond") then
                        local current = v.Value
                        local gained = current - totalBondsStart
                        bondLabel.Text = string.format("Bonds: %d (+%d)", current, gained)
                        totalBondsStart = current
                        break
                    end
                end
            end

            task.wait(0.5)
            progressLabel.Text = "Progress: 0%"
        end

        statusBonds.Text = "Bonds: OFF"
        statusBonds.TextColor3 = Color3.fromRGB(255, 100, 100)
        timerLabel.Visible = false
        progressLabel.Visible = false
        progressLabel.Text = "Progress: 0%"
    end)
end

local function stopBonds()
    bondActive = false
    statusBonds.Text = "Bonds: OFF"
    statusBonds.TextColor3 = Color3.fromRGB(255, 100, 100)
    timerLabel.Visible = false
    progressLabel.Visible = false
end

-- ========== FAKE HITBOX ==========
local fakeActive = false
local fakeHeads = {}
local fakeConnection = nil
local fakeLock = false

-- FIX: isEnemy dengan team nil handling
local function isEnemy(model)
    if model == player.Character then return false end
    if not model:IsA("Model") then return false end
    local hum = model:FindFirstChild("Humanoid")
    if not hum then return false end
    local plr = game.Players:GetPlayerFromCharacter(model)
    if plr then
        if player.Team and plr.Team then
            return plr.Team ~= player.Team
        else
            -- Jika salah satu team nil, anggap musuh (karena biasanya NPC atau beda tim)
            return true
        end
    end
    return true
end

local function findHeadPart(enemy)
    for _, part in ipairs(enemy:GetDescendants()) do
        if part:IsA("BasePart") and part.Name:lower() == "head" then
            return part
        end
    end
    return nil
end

local function createFakeHitbox(head, scale)
    if fakeHeads[head] then return end
    local hitbox = Instance.new("Part")
    hitbox.Name = "FakeHitbox"
    hitbox.Size = Vector3.new(scale, scale, scale)
    hitbox.CFrame = head.CFrame
    hitbox.Transparency = 0.5
    hitbox.Material = Enum.Material.Neon
    hitbox.Color = Color3.fromRGB(255, 0, 0)
    hitbox.Anchored = false
    hitbox.CanCollide = false
    hitbox.CanTouch = false
    hitbox.CanQuery = false
    hitbox.CastShadow = false
    hitbox.Massless = true
    hitbox.Parent = head.Parent
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = head
    weld.Part1 = hitbox
    weld.Parent = hitbox
    fakeHeads[head] = hitbox
end

local function resetFakeHitboxes()
    for head, hitbox in pairs(fakeHeads) do
        if hitbox and hitbox.Parent then hitbox:Destroy() end
    end
    fakeHeads = {}
end

local function processAllFake(scale)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if isEnemy(obj) then
            local head = findHeadPart(obj)
            if head and not fakeHeads[head] then
                createFakeHitbox(head, scale)
            end
        end
    end
end

local function startFakeHitbox(scale)
    if fakeLock then return end
    fakeLock = true
    if fakeActive then
        if fakeConnection then fakeConnection:Disconnect() end
        resetFakeHitboxes()
    end
    fakeActive = true
    statusFake.Text = string.format("Fake: ACTIVE (%dx)", scale)
    statusFake.TextColor3 = Color3.fromRGB(0, 255, 0)
    processAllFake(scale)

fakeConnection = workspace.DescendantAdded:Connect(function(descendant)
        if not fakeActive then return end
        local model = descendant:FindFirstAncestorOfClass("Model")
        if model and isEnemy(model) then
            local head = findHeadPart(model)
            if head and not fakeHeads[head] then
                createFakeHitbox(head, scale)
            end
        end
    end)
    fakeLock = false
end

local function stopFakeHitbox()
    if fakeLock then return end
    fakeLock = true
    if not fakeActive then
        fakeLock = false
        return
    end
    fakeActive = false
    statusFake.Text = "Fake: OFF"
    statusFake.TextColor3 = Color3.fromRGB(255, 100, 100)
    if fakeConnection then fakeConnection:Disconnect() fakeConnection = nil end
    resetFakeHitboxes()
    fakeLock = false
end

-- ========== REAL HITBOX (batas MAX 4) ==========
local realActive = false
local realHeads = {}
local realConnection = nil
local realLock = false

local function enlargeRealHead(head, scale)
    if realHeads[head] then return end
    realHeads[head] = head.Size
    -- FIX: batas maksimal 4 (lebih stabil dari 6)
    local maxSize = 4
    local newX = math.min(head.Size.X * scale, maxSize)
    local newZ = math.min(head.Size.Z * scale, maxSize)
    head.Size = Vector3.new(newX, head.Size.Y, newZ)
    head.Transparency = 0.5
    head.Material = Enum.Material.Neon
    head.CanCollide = false
    head.Massless = true
end

local function resetRealHeads()
    for head, originalSize in pairs(realHeads) do
        if head and head.Parent then
            head.Size = originalSize
            head.Transparency = 0
            head.Material = Enum.Material.Plastic
            head.CanCollide = true
            head.Massless = false
        end
    end
    realHeads = {}
end

local function processAllReal(scale)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if isEnemy(obj) then
            local head = findHeadPart(obj)
            if head and not realHeads[head] then
                enlargeRealHead(head, scale)
            end
        end
    end
end

local function startRealHitbox(scale)
    if realLock then return end
    realLock = true
    if realActive then
        if realConnection then realConnection:Disconnect() end
        resetRealHeads()
    end
    realActive = true
    statusReal.Text = string.format("Real: ACTIVE (%dx)", scale)
    statusReal.TextColor3 = Color3.fromRGB(0, 255, 0)
    processAllReal(scale)
    realConnection = workspace.DescendantAdded:Connect(function(descendant)
        if not realActive then return end
        local model = descendant:FindFirstAncestorOfClass("Model")
        if model and isEnemy(model) then
            local head = findHeadPart(model)
            if head and not realHeads[head] then
                enlargeRealHead(head, scale)
            end
        end
    end)
    realLock = false
end

local function stopRealHitbox()
    if realLock then return end
    realLock = true
    if not realActive then
        realLock = false
        return
    end
    realActive = false
    statusReal.Text = "Real: OFF"
    statusReal.TextColor3 = Color3.fromRGB(255, 100, 100)
    if realConnection then realConnection:Disconnect() realConnection = nil end
    resetRealHeads()
    realLock = false
end

-- ========== KILL AURA ==========
local killAuraActive = false
local killAuraTask = nil

local function startKillAura()
    if killAuraActive then return end
    if not swingRemote then
        warn("[KillAura] Swing remote tidak ditemukan, Kill Aura tidak bisa aktif.")
        return
    end
    killAuraActive = true
    statusKillAura.Text = "Kill Aura: ACTIVE"
    statusKillAura.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    killAuraTask = task.spawn(function()
        local fakeTime = tick()  -- FIX: pakai tick() biar dinamis
        while killAuraActive do
            local character = player.Character
            local tool = character and character:FindFirstChildOfClass("Tool")
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if tool and root and swingRemote then
                fakeTime = tick()  -- update terus biar real time
                swingRemote:FireServer(tool, fakeTime, root.CFrame.LookVector)
            end
            task.wait(0.1)
        end
    end)
end

local function stopKillAura()
    if not killAuraActive then return end
    killAuraActive = false
    if killAuraTask then
        task.cancel(killAuraTask)
        killAuraTask = nil
    end
    statusKillAura.Text = "Kill Aura: OFF"
    statusKillAura.TextColor3 = Color3.fromRGB(255, 100, 100)
end

-- ========== HELPER BUTTON ==========
local function createModeButton(parent, xOffset, label, bgColor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 65, 0, 32)
    btn.Text = label
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = bgColor
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = parent
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ========== AUTO BONDS TOGGLE ==========
local bondsContainer = Instance.new("Frame")
bondsContainer.Size = UDim2.new(1, -20, 0, 40)
bondsContainer.Position = UDim2.new(0, 10, 0, 8)
bondsContainer.BackgroundTransparency = 1
bondsContainer.Parent = bodyFrame

local bondsLabel = Instance.new("TextLabel")
bondsLabel.Size = UDim2.new(0, 160, 0, 22)
bondsLabel.Position = UDim2.new(0, 0, 0, 9)
bondsLabel.Text = "🔗 AUTO BONDS (500-3000)"
bondsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
bondsLabel.BackgroundTransparency = 1
bondsLabel.Font = Enum.Font.Gotham
bondsLabel.TextSize = 11
bondsLabel.TextXAlignment = Enum.TextXAlignment.Left
bondsLabel.Parent = bondsContainer

local bondsToggle = Instance.new("TextButton")
bondsToggle.Size = UDim2.new(0, 65, 0, 30)
bondsToggle.Position = UDim2.new(1, -75, 0, 5)
bondsToggle.Text = "OFF"
bondsToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
bondsToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
bondsToggle.Font = Enum.Font.GothamBold
bondsToggle.TextSize = 12
bondsToggle.BorderSizePixel = 0
bondsToggle.Parent = bondsContainer
local bondsCorner = Instance.new("UICorner")
bondsCorner.CornerRadius = UDim.new(0, 14)
bondsCorner.Parent = bondsToggle

local bondsState = false
bondsToggle.MouseButton1Click:Connect(function()
    bondsState = not bondsState
    if bondsState then
        bondsToggle.Text = "ON"
        bondsToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        bondsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        startBonds()
    else
        bondsToggle.Text = "OFF"
        bondsToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        bondsToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        stopBonds()
    end
end)

-- ========== FAKE HITBOX BUTTONS ==========
local fakeLabel = Instance.new("TextLabel")
fakeLabel.Size = UDim2.new(1, -20, 0, 18)
fakeLabel.Position = UDim2.new(0, 10, 0, 55)
fakeLabel.Text = "🎭 FAKE HITBOX (visual only)"
fakeLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
fakeLabel.BackgroundTransparency = 1
fakeLabel.Font = Enum.Font.Gotham
fakeLabel.TextSize = 10
fakeLabel.TextXAlignment = Enum.TextXAlignment.Left
fakeLabel.Parent = bodyFrame

local fakeRow1 = Instance.new("Frame")
fakeRow1.Size = UDim2.new(1, -20, 0, 38)
fakeRow1.Position = UDim2.new(0, 10, 0, 78)
fakeRow1.BackgroundTransparency = 1
fakeRow1.Parent = bodyFrame

createModeButton(fakeRow1, 3, "3x", Color3.fromRGB(60,60,70), function()
    stopRealHitbox()
    startFakeHitbox(3)
end).Position = UDim2.new(0, 0, 0, 3)

createModeButton(fakeRow1, 73, "5x", Color3.fromRGB(60,60,70), function()
    stopRealHitbox()
    startFakeHitbox(5)
end).Position = UDim2.new(0, 73, 0, 3)

createModeButton(fakeRow1, 146, "10x", Color3.fromRGB(60,60,70), function()
    stopRealHitbox()
    startFakeHitbox(10)
end).Position = UDim2.new(0, 146, 0, 3)

local fakeRow2 = Instance.new("Frame")
fakeRow2.Size = UDim2.new(1, -20, 0, 38)
fakeRow2.Position = UDim2.new(0, 10, 0, 120)
fakeRow2.BackgroundTransparency = 1
fakeRow2.Parent = bodyFrame

createModeButton(fakeRow2, 73, "20x", Color3.fromRGB(60,60,70), function()
    stopRealHitbox()
    startFakeHitbox(20)
end).Position = UDim2.new(0, 73, 0, 3)

createModeButton(fakeRow2, 146, "OFF", Color3.fromRGB(120,40,40), function()
    stopFakeHitbox()
end).Position = UDim2.new(0, 146, 0, 3)

-- ========== REAL HITBOX BUTTONS ==========
local realLabel = Instance.new("TextLabel")
realLabel.Size = UDim2.new(1, -20, 0, 18)
realLabel.Position = UDim2.new(0, 10, 0, 165)
realLabel.Text = "🎯 REAL HITBOX (damage)"
realLabel.TextColor3 = Color3.fromRGB(220,220,220)
realLabel.BackgroundTransparency = 1
realLabel.Font = Enum.Font.Gotham
realLabel.TextSize = 10
realLabel.TextXAlignment = Enum.TextXAlignment.Left
realLabel.Parent = bodyFrame

local realRow1 = Instance.new("Frame")
realRow1.Size = UDim2.new(1, -20, 0, 38)
realRow1.Position = UDim2.new(0, 10, 0, 188)
realRow1.BackgroundTransparency = 1
realRow1.Parent = bodyFrame

createModeButton(realRow1, 3, "3x", Color3.fromRGB(40,90,40), function()
    stopFakeHitbox()
    startRealHitbox(3)
end).Position = UDim2.new(0, 0, 0, 3)

createModeButton(realRow1, 73, "5x", Color3.fromRGB(40,90,40), function()
    stopFakeHitbox()
    startRealHitbox(5)
end).Position = UDim2.new(0, 73, 0, 3)

createModeButton(realRow1, 146, "10x", Color3.fromRGB(40,90,40), function()
    stopFakeHitbox()
    startRealHitbox(10)
end).Position = UDim2.new(0, 146, 0, 3)

local realRow2 = Instance.new("Frame")
realRow2.Size = UDim2.new(1, -20, 0, 38)
realRow2.Position = UDim2.new(0, 10, 0, 230)
realRow2.BackgroundTransparency = 1
realRow2.Parent = bodyFrame

createModeButton(realRow2, 73, "20x", Color3.fromRGB(40,90,40), function()
    stopFakeHitbox()
    startRealHitbox(20)
end).Position = UDim2.new(0, 73, 0, 3)

createModeButton(realRow2, 146, "OFF", Color3.fromRGB(120,40,40), function()
    stopRealHitbox()
end).Position = UDim2.new(0, 146, 0, 3)

-- ========== KILL AURA TOGGLE ==========
local killContainer = Instance.new("Frame")
killContainer.Size = UDim2.new(1, -20, 0, 40)
killContainer.Position = UDim2.new(0, 10, 0, 275)
killContainer.BackgroundTransparency = 1
killContainer.Parent = bodyFrame

local killLabel = Instance.new("TextLabel")
killLabel.Size = UDim2.new(0, 160, 0, 22)
killLabel.Position = UDim2.new(0, 0, 0, 9)
killLabel.Text = "⚔️ KILL AURA (melee)"
killLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
killLabel.BackgroundTransparency = 1
killLabel.Font = Enum.Font.Gotham
killLabel.TextSize = 11
killLabel.TextXAlignment = Enum.TextXAlignment.Left
killLabel.Parent = killContainer

local killToggle = Instance.new("TextButton")
killToggle.Size = UDim2.new(0, 65, 0, 30)
killToggle.Position = UDim2.new(1, -75, 0, 5)
killToggle.Text = "OFF"
killToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
killToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
killToggle.Font = Enum.Font.GothamBold
killToggle.TextSize = 12
killToggle.BorderSizePixel = 0
killToggle.Parent = killContainer
local killCorner = Instance.new("UICorner")
killCorner.CornerRadius = UDim.new(0, 14)
killCorner.Parent = killToggle

local killState = false
killToggle.MouseButton1Click:Connect(function()
    killState = not killState
    if killState then
        killToggle.Text = "ON"
        killToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        killToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        startKillAura()
    else
        killToggle.Text = "OFF"
        killToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        killToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        stopKillAura()
    end
end)

-- ========== MINIMIZE TO LOGO ==========
local logoFrame = Instance.new("Frame")
logoFrame.Size = UDim2.new(0, 45, 0, 45)
logoFrame.Position = UDim2.new(0.02, 0, 0.85, 0)
logoFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
logoFrame.BackgroundTransparency = 0.1
logoFrame.BorderSizePixel = 0
logoFrame.Visible = false
logoFrame.Parent = screenGui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 22)
logoCorner.Parent = logoFrame

local logoBtn = Instance.new("TextButton")
logoBtn.Size = UDim2.new(1, 0, 1, 0)
logoBtn.Text = "FS"
logoBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
logoBtn.BackgroundTransparency = 1
logoBtn.Font = Enum.Font.GothamBold
logoBtn.TextSize = 16
logoBtn.Parent = logoFrame

minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    logoFrame.Visible = true
end)

logoBtn.MouseButton1Click:Connect(function()
    logoFrame.Visible = false
    mainFrame.Visible = true
end)

-- ========== CLOSE ==========
closeBtn.MouseButton1Click:Connect(function()
    stopFakeHitbox()
    stopRealHitbox()
    stopBonds()
    stopKillAura()
    screenGui:Destroy()
end)

-- ========== BOND COUNTER UPDATE ==========
task.spawn(function()
    while screenGui and screenGui.Parent do
        task.wait(2)
        local ls = player:FindFirstChild("leaderstats")
        if ls then
            for _, v in ipairs(ls:GetChildren()) do
                if v.Name:lower():find("bond") then
                    bondLabel.Text = string.format("Bonds: %d", v.Value)
                    break
                end
            end
        end
    end
end)
