--// rcynAIM V8.5 - DASHBOARD + FITUR CHEAT LENGKAP 😈💼

-- UI DAN DASHBOARD TETAP SAMA (TERPOTONG UNTUK SINGKATAN)...

-- [[ FITUR CHEAT MENU - TOMBOL ]] --
local cheatList = {
    "Aimbot 20%", "Aimbot 30%", "Aimbot 50%", "Aimbot 100%",
    "Brutal AIMGhost", "ESP Brutal", "Toggle Stream Proof",
    "Magic Bullet", "GODfire Auto Rage"
}

local cheatScroll = Instance.new("ScrollingFrame", cheatMenu)
cheatScroll.Size = UDim2.new(1, -20, 1, -160)
cheatScroll.Position = UDim2.new(0, 10, 0, 150)
cheatScroll.CanvasSize = UDim2.new(0, 0, 0, #cheatList * 45)
cheatScroll.ScrollBarThickness = 6
cheatScroll.BackgroundTransparency = 1
cheatScroll.Name = "CheatScroll"

local function makeCheatBtn(text, order)
    local btn = Instance.new("TextButton", cheatScroll)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, (order - 1) * 45)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.BorderSizePixel = 0
    return btn
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Cam = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local aimbotStrength = 0
local ghostActive = false
local espActive = false
local streamProof = false
_G.MagicOn = false
_G.GODfire = false
_G.AimbotMode = "default"

for i, v in ipairs(cheatList) do
    local btn = makeCheatBtn(v, i)
    btn.MouseButton1Click:Connect(function()
        if v:find("20") then aimbotStrength = 0.2 _G.AimbotMode = "slow"
        elseif v:find("30") then aimbotStrength = 0.3
        elseif v:find("50") then aimbotStrength = 0.5
        elseif v:find("100") then aimbotStrength = 1
        elseif v:find("Ghost") then ghostActive = not ghostActive
        elseif v:find("ESP") then espActive = not espActive
        elseif v:find("Stream") then streamProof = not streamProof mainFrame.Visible = not streamProof
        elseif v:find("Magic") then _G.MagicOn = not _G.MagicOn
        elseif v:find("GODfire") then _G.GODfire = not _G.GODfire
        end
    end)
end

-- [[ SWITCH MENU ANTAR ICON ]] --
local settingMenu = Instance.new("Frame", contentPanel)
settingMenu.Size = UDim2.new(1,0,1,0)
settingMenu.BackgroundTransparency = 1
settingMenu.Visible = false

local settingLabel = Instance.new("TextLabel", settingMenu)
settingLabel.Text = "⚙️ Pengaturan Menu"
settingLabel.Size = UDim2.new(1,0,0,30)
settingLabel.TextColor3 = Color3.fromRGB(255,255,255)
settingLabel.Font = Enum.Font.GothamBold
settingLabel.TextSize = 20
settingLabel.BackgroundTransparency = 1

iconCheat.MouseButton1Click:Connect(function()
    cheatMenu.Visible = true
    settingMenu.Visible = false
end)

iconSetting.MouseButton1Click:Connect(function()
    cheatMenu.Visible = false
    settingMenu.Visible = true
end)

-- [[ AIMBOT / ESP AKSI ]] --
function applyVisuals()
    for _,v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
            local head = v.Character.Head
            if ghostActive then
                head.Size = Vector3.new(10,10,10)
                head.Material = Enum.Material.Neon
                head.BrickColor = BrickColor.new("Really red")
                head.Transparency = 0.4
            end
            if espActive and not streamProof then
                if not head:FindFirstChild("ESP") then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "ESP"
                    box.Adornee = head
                    box.AlwaysOnTop = true
                    box.Size = Vector3.new(10,10,10)
                    box.ZIndex = 5
                    box.Transparency = 0.3
                    box.Color3 = Color3.new(1,0,0)
                    box.Parent = head
                end
            elseif head:FindFirstChild("ESP") then
                head.ESP:Destroy()
            end
        end
    end
end

local lastTarget = nil
function getClosest()
    local closest, dist = nil, math.huge
    for _,v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
            local head = v.Character.Head
            local pos, visible = Cam:WorldToViewportPoint(head.Position)
            local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
            if visible and mag < dist then
                dist = mag
                closest = head
            end
        end
    end
    return closest
end

game:GetService("RunService").RenderStepped:Connect(function()
    local target = getClosest()
    if target and aimbotStrength > 0 then
        if _G.AimbotMode == "slow" and lastTarget and lastTarget ~= target then return end
        local cur = Cam.CFrame.Position
        local aim = CFrame.new(cur, cur + (target.Position - cur).Unit * aimbotStrength)
        Cam.CFrame = aim
        local event = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
        if event and event:FindFirstChild("Shoot") then
            event.Shoot:FireServer(target)
        end
        lastTarget = target
    end
    applyVisuals()
end)

spawn(function()
    while task.wait(1.5) do
        if _G.MagicOn then
            local shoot = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
            if shoot and shoot:FindFirstChild("Shoot") then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        shoot.Shoot:FireServer(p.Character.Head)
                    end
                end
            end
        end
    end
end)

spawn(function()
    while task.wait(0.3) do
        if _G.GODfire then
            local shoot = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
            if shoot and shoot:FindFirstChild("Shoot") then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        shoot.Shoot:FireServer(p.Character.Head)
                    end
                end
            end
        end
    end
end)

print("🔥 rcynAIM V8.5 UI + FITUR CHEAT LENGKAP AKTIF ✅")
