--// rcynAIM ULTRA-LITE FINAL V2 - Aimbot Brutal Update 🔥🔒
-- Aimbot 50% = semi lock saat nembak. Aimbot 100% = full lock brutal sampai musuh mati 😈

local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame")
frame.Name = "rcynAIM_LITE_FINAL"
frame.Size = UDim2.new(0, 260, 0, 220)
frame.Position = UDim2.new(0.5, -130, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Visible = true
frame.Parent = gui

-- Icon restore
local restoreIcon = Instance.new("TextButton")
restoreIcon.Size = UDim2.new(0, 30, 0, 30)
restoreIcon.Position = UDim2.new(0, 10, 1, -40)
restoreIcon.Text = "🅡"
restoreIcon.TextColor3 = Color3.new(1,1,1)
restoreIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
restoreIcon.BorderSizePixel = 0
restoreIcon.Visible = false
restoreIcon.Parent = gui

-- Header + minimize
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(0.85, 0, 0, 30)
title.Position = UDim2.new(0, 5, 0, 0)
title.Text = "🔥 rcyn ULTRA"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1

local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -35, 0, 0)
minBtn.Text = "🔻"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
minBtn.BorderSizePixel = 0

minBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    restoreIcon.Visible = true
end)
restoreIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    restoreIcon.Visible = false
end)

local function createBtn(txt, y)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    return b
end

local aimbotLevel = 0.2
local espOn = false
local magicOn = false
local smoothness = 0.02
local lockedTarget = nil

local btnAimbot = createBtn("Aimbot: 20%", 40)
local btnESP = createBtn("ESP", 80)
local btnMagic = createBtn("Magic Bullet", 120)

btnAimbot.MouseButton1Click:Connect(function()
    if aimbotLevel == 0.2 then aimbotLevel = 0.3 smoothness = 0.015 btnAimbot.Text = "Aimbot: 30%"
    elseif aimbotLevel == 0.3 then aimbotLevel = 0.5 smoothness = 0.01 btnAimbot.Text = "Aimbot: 50%"
    elseif aimbotLevel == 0.5 then aimbotLevel = 1 smoothness = 0.002 btnAimbot.Text = "Aimbot: 100%"
    else aimbotLevel = 0.2 smoothness = 0.02 lockedTarget = nil btnAimbot.Text = "Aimbot: 20%" end
end)

btnESP.MouseButton1Click:Connect(function()
    espOn = not espOn
    btnESP.Text = espOn and "ESP: ON" or "ESP"
end)

btnMagic.MouseButton1Click:Connect(function()
    magicOn = not magicOn
    btnMagic.Text = magicOn and "Magic Bullet: ON" or "Magic Bullet"
end)

-- Logic
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Cam = workspace.CurrentCamera

function getTarget()
    local closest, dist = nil, math.huge
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local h = p.Character.Head
            local pos, vis = Cam:WorldToViewportPoint(h.Position)
            local m = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
            if vis and m < dist then
                dist = m
                closest = h
            end
        end
    end
    return closest
end

function applyESP()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            if espOn and not head:FindFirstChild("ESP") then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ESP"
                box.Adornee = head
                box.Size = Vector3.new(10,10,10)
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Transparency = 0.3
                box.Color3 = Color3.new(1,0,0)
                box.Parent = head
            elseif not espOn and head:FindFirstChild("ESP") then
                head.ESP:Destroy()
            end
        end
    end
end

function smoothAim(current, targetPos)
    local direction = (targetPos - current.Position).Unit
    local newLook = current.Position + direction * aimbotLevel
    return current:Lerp(CFrame.new(current.Position, newLook), smoothness)
end

task.spawn(function()
    while task.wait(0.02) do
        local current = getTarget()

        if aimbotLevel == 1 then -- 100% brutal lock sampe mati
            if lockedTarget == nil or not lockedTarget:IsDescendantOf(workspace) then
                lockedTarget = current
            end
            if lockedTarget then
                Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, lockedTarget.Position), 0.2)
            end
        elseif aimbotLevel == 0.5 then -- 50% lock saat nembak
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                if current then
                    lockedTarget = current
                    Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, lockedTarget.Position), 0.1)
                end
            else
                lockedTarget = nil
            end
        else -- normal smooth
            if current then
                Cam.CFrame = smoothAim(Cam.CFrame, current.Position)
            end
        end

        if magicOn then
            local e = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
            if e and e:FindFirstChild("Shoot") then
                for _,v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                        e.Shoot:FireServer(v.Character.Head)
                    end
                end
            end
        end

        if espOn then applyESP() end
    end
end)

print("✅ rcynAIM FINAL V2 - SMOOTH & BRUTAL LOCK AIM ✅")
