--// rcynAIM ULTRA-LITE FINAL V3 😈💻
-- Update: Aim Prediction + No Recoil + Brutal ESP Mode + Aimbot Legit Refinement

local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame")
frame.Name = "rcynAIM_UI"
frame.Size = UDim2.new(0, 260, 0, 260)
frame.Position = UDim2.new(0.5, -130, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Visible = true
frame.Parent = gui

local restoreIcon = Instance.new("TextButton")
restoreIcon.Size = UDim2.new(0, 30, 0, 30)
restoreIcon.Position = UDim2.new(0, 10, 1, -40)
restoreIcon.Text = "🅡"
restoreIcon.TextColor3 = Color3.new(1,1,1)
restoreIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
restoreIcon.BorderSizePixel = 0
restoreIcon.Visible = false
restoreIcon.Parent = gui

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

local aimbotLevel, smoothness, espOn, magicOn, noRecoil, prediction = 0.2, 0.02, false, false, false, true
local btnAimbot = createBtn("Aimbot: 20%", 40)
local btnESP = createBtn("ESP", 80)
local btnMagic = createBtn("Magic Bullet", 120)
local btnRecoil = createBtn("No Recoil: OFF", 160)

btnAimbot.MouseButton1Click:Connect(function()
    if aimbotLevel == 0.2 then aimbotLevel = 0.3 smoothness = 0.015 btnAimbot.Text = "Aimbot: 30%"
    elseif aimbotLevel == 0.3 then aimbotLevel = 0.5 smoothness = 0.01 btnAimbot.Text = "Aimbot: 50%"
    elseif aimbotLevel == 0.5 then aimbotLevel = 1 smoothness = 0.003 btnAimbot.Text = "Aimbot: 100%"
    else aimbotLevel = 0.2 smoothness = 0.02 btnAimbot.Text = "Aimbot: 20%" end
end)

btnESP.MouseButton1Click:Connect(function()
    espOn = not espOn
    btnESP.Text = espOn and "ESP: ON" or "ESP"
end)

btnMagic.MouseButton1Click:Connect(function()
    magicOn = not magicOn
    btnMagic.Text = magicOn and "Magic Bullet: ON" or "Magic Bullet"
end)

btnRecoil.MouseButton1Click:Connect(function()
    noRecoil = not noRecoil
    btnRecoil.Text = noRecoil and "No Recoil: ON" or "No Recoil: OFF"
end)

-- Base logic
local Players, LocalPlayer, Cam = game:GetService("Players"), game:GetService("Players").LocalPlayer, workspace.CurrentCamera
local lockedTarget = nil
function getTarget()
    local closest, dist = nil, math.huge
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local h = p.Character.Head
            local pos, vis = Cam:WorldToViewportPoint(h.Position)
            local m = (Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y) - Vector2.new(pos.X, pos.Y)).Magnitude
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
            if espOn and not head:FindFirstChild("rcynESP") then
                local line = Instance.new("Beam")
                local a0 = Instance.new("Attachment", Cam)
                local a1 = Instance.new("Attachment", head)
                line.Name = "rcynESP"
                line.Attachment0 = a0
                line.Attachment1 = a1
                line.Width0 = 0.05
                line.Width1 = 0.05
                line.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
                line.FaceCamera = true
                line.Parent = head
            elseif not espOn and head:FindFirstChild("rcynESP") then
                head.rcynESP:Destroy()
            end
        end
    end
end

function predictPosition(target)
    if target and target.Parent:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Parent.HumanoidRootPart
        local velocity = hrp.Velocity
        return target.Position + velocity * 0.1
    end
    return target.Position
end

task.spawn(function()
    while task.wait(0.02) do
        local t = getTarget()
        if t and aimbotLevel > 0 then
            local aimPos = prediction and predictPosition(t) or t.Position
            local camPos = Cam.CFrame.Position
            local direction = (aimPos - camPos).Unit
            local newLook = camPos + direction * aimbotLevel
            Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(camPos, newLook), smoothness)
        end
        if espOn then applyESP() end
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
        if noRecoil and LocalPlayer.Character then
            for _,tool in ipairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                    if tool:FindFirstChild("Recoil") then tool.Recoil:Destroy() end
                    if tool:FindFirstChild("Spread") then tool.Spread:Destroy() end
                end
            end
        end
    end
end)

print("✅ rcynAIM FINAL V3 ACTIVE: Aim Predict, ESP Line, No Recoil, Legit Aimbot ✅")
