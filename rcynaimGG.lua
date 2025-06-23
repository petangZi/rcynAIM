
--// rcynAIM V8 - UI REDESIGN + DASHBOARD KARAKTER + MENU ICON SYSTEM 😈💼

-- [[ LOADING SCREEN + LOGIN (SIMPULAN) ]]
local loadingGui = Instance.new("ScreenGui", game.CoreGui)
local blur = Instance.new("BlurEffect", game.Lighting)
blur.Size = 24

local loadingFrame = Instance.new("Frame", loadingGui)
loadingFrame.Size = UDim2.new(0, 400, 0, 120)
loadingFrame.Position = UDim2.new(0.5, -200, 0.5, -60)
loadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
loadingFrame.BorderSizePixel = 0
loadingFrame.BackgroundTransparency = 0.1

local loadingTitle = Instance.new("TextLabel", loadingFrame)
loadingTitle.Size = UDim2.new(1, 0, 0.4, 0)
loadingTitle.Text = "⚡ rcyn AZUYA ⚡"
loadingTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
loadingTitle.Font = Enum.Font.GothamBlack
loadingTitle.TextSize = 28
loadingTitle.BackgroundTransparency = 1

local loadingSub = Instance.new("TextLabel", loadingFrame)
loadingSub.Size = UDim2.new(1, 0, 0.6, 0)
loadingSub.Position = UDim2.new(0, 0, 0.4, 0)
loadingSub.Text = "Login Berhasil... Memuat Karakter"
loadingSub.TextColor3 = Color3.fromRGB(200, 200, 200)
loadingSub.Font = Enum.Font.Gotham
loadingSub.TextSize = 16
loadingSub.BackgroundTransparency = 1

wait(2.5)
blur:Destroy()
loadingGui:Destroy()

-- [[ MAIN DASHBOARD UI ]]
local gui = Instance.new("ScreenGui", game.CoreGui)
local mainFrame = Instance.new("Frame", gui)
mainFrame.Name = "rcynAIM_Dashboard"
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Visible = true

-- [[ HEADER ]] --
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Text = "🔥 rcyn AIM"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1

local miniBtn = Instance.new("TextButton", header)
miniBtn.Size = UDim2.new(0, 40, 0, 40)
miniBtn.Position = UDim2.new(1, -40, 0, 0)
miniBtn.Text = "🅡"
miniBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 16

miniBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- [[ SIDEBAR ICON MENU ]] --
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 60, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(35,35,35)

local function makeIconButton(iconText, order, name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, (order-1)*55)
    btn.Text = iconText
    btn.Name = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    return btn
end

local iconCheat = makeIconButton("🅐", 1, "CheatMenu")
local iconSetting = makeIconButton("⚙️", 2, "Settings")

-- [[ CONTENT PANEL ]] --
local contentPanel = Instance.new("Frame", mainFrame)
contentPanel.Position = UDim2.new(0, 60, 0, 40)
contentPanel.Size = UDim2.new(1, -60, 1, -40)
contentPanel.BackgroundColor3 = Color3.fromRGB(28,28,28)

-- [[ CHEAT MENU ]] --
local cheatMenu = Instance.new("Frame", contentPanel)
cheatMenu.Size = UDim2.new(1,0,1,0)
cheatMenu.BackgroundTransparency = 1
cheatMenu.Visible = true

local cheatLabel = Instance.new("TextLabel", cheatMenu)
cheatLabel.Text = "📦 Cheat Menu"
cheatLabel.Size = UDim2.new(1,0,0,30)
cheatLabel.Position = UDim2.new(0,0,0,0)
cheatLabel.TextColor3 = Color3.fromRGB(255,255,255)
cheatLabel.BackgroundTransparency = 1
cheatLabel.Font = Enum.Font.GothamBold
cheatLabel.TextSize = 20

-- [[ Karakter Info ]] --
local charPanel = Instance.new("Frame", cheatMenu)
charPanel.Size = UDim2.new(1, -20, 0, 100)
charPanel.Position = UDim2.new(0,10,0,40)
charPanel.BackgroundColor3 = Color3.fromRGB(40,40,40)
charPanel.BorderSizePixel = 0

local playerName = Instance.new("TextLabel", charPanel)
playerName.Text = "👤 "..game.Players.LocalPlayer.Name..""
playerName.Size = UDim2.new(1,0,1,0)
playerName.TextColor3 = Color3.fromRGB(255,255,255)
playerName.Font = Enum.Font.Gotham
playerName.TextSize = 18
playerName.BackgroundTransparency = 1

-- TODO: Tambah konten menu cheat & setting
-- TODO: Buat tombol & fitur dalam cheatMenu dan settingMenu
-- TODO: Switch tampilan saat klik iconCheat / iconSetting
-- TODO: Aktifkan RCA toggle visible

-- 🌟 SIAPIN FILE LANJUT BUAT NARO FITUR AIMPANEL DLL DI DALAM cheatMenu

print("🔥 rcynAIM V8 UI READY - DASHBOARD MODE AKTIF ✅")
