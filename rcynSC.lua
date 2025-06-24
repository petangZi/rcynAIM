--// rcynSC.lua FINAL V5 😈⚙️
-- Tambahan: MINIMIZE tombol + ESP BRUTAL (kotak, warna-warni, full visual)

-- [[ LOADING UI ]] --
local gui = Instance.new("ScreenGui", game.CoreGui)
local blur = Instance.new("BlurEffect", game.Lighting)
blur.Size = 24

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 120)
frame.Position = UDim2.new(0.5, -200, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.1

local text = Instance.new("TextLabel", frame)
text.Size = UDim2.new(1, 0, 1, 0)
text.Text = "⚡ Memuat rcynAIM System..."
text.Font = Enum.Font.GothamBlack
text.TextColor3 = Color3.fromRGB(255,100,100)
text.TextSize = 24
text.BackgroundTransparency = 1

wait(3.5)

-- [[ UI UTAMA ]] --
local mainGui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", mainGui)
frame.Name = "rcynAIM_UI"
frame.Size = UDim2.new(0, 260, 0, 260)
frame.Position = UDim2.new(0.5, -130, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.Text = "🔻"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 14
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)

local restoreBtn = Instance.new("TextButton", mainGui)
restoreBtn.Size = UDim2.new(0, 30, 0, 30)
restoreBtn.Position = UDim2.new(0, 10, 1, -40)
restoreBtn.Text = "🅡"
restoreBtn.TextColor3 = Color3.new(1,1,1)
restoreBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
restoreBtn.BorderSizePixel = 0
restoreBtn.Visible = false

minimizeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    restoreBtn.Visible = true
end)
restoreBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    restoreBtn.Visible = false
end)

-- [[ MENU ]] --
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

-- [[ CHEAT CORE ]] --
local Players, LocalPlayer, Cam = game:GetService("Players"), game:GetService("Players").LocalPlayer, workspace.CurrentCamera
function getTarget()
    local closest, dist = nil, math.huge
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
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

function predictPosition(target)
    if target and target.Parent:FindFirstChild("HumanoidRootPart") then
        return target.Position + target.Parent.HumanoidRootPart.Velocity * 0.1
    end
    return target.Position
end

function applyESP()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("HumanoidRootPart") then
            local head = p.Character.Head
            local hrp = p.Character.HumanoidRootPart

            -- Hapus ESP lama
            if head:FindFirstChild("rcynESP") then head.rcynESP:Destroy() end
            if hrp:FindFirstChild("rcynBOX") then hrp.rcynBOX:Destroy() end

            if espOn then
                -- Line ke musuh
                local beam = Instance.new("Beam")
                local a0 = Instance.new("Attachment", Cam)
                local a1 = Instance.new("Attachment", head)
                beam.Name = "rcynESP"
                beam.Attachment0 = a0
                beam.Attachment1 = a1
                beam.Width0 = 0.05
                beam.Width1 = 0.05
                beam.Color = ColorSequence.new(Color3.fromRGB(math.random(100,255), math.random(50,150), math.random(100,255)))
                beam.FaceCamera = true
                beam.Parent = head

                -- Kotak ESP
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "rcynBOX"
                box.Adornee = hrp
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Size = Vector3.new(4, 6, 2)
                box.Transparency = 0.3
                box.Color3 = Color3.fromRGB(math.random(120,255), math.random(0,100), math.random(150,255))
                box.Parent = hrp
            end
        end
    end
end

spawn(function()
    while task.wait(0.02) do
        local t = getTarget()
        if t and aimbotLevel > 0 then
            local pos = prediction and predictPosition(t) or t.Position
            local camPos = Cam.CFrame.Position
            local dir = (pos - camPos).Unit
            Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(camPos, camPos + dir * aimbotLevel), smoothness)
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

-- [[ TUTUP LOADING ]] --
task.delay(0.2, function()
    blur:Destroy()
    gui:Destroy()
end)

print("✅ rcynSC.lua FINAL V5 - UI MINIMIZE + ESP BRUTAL DONE ✅")
