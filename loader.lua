--// rcynAIM LOADER 😈⚡ v1.0
-- Loader UI: Estetik + Animasi, lalu load script utama dari raw URL

local core = "loadstring(game:HttpGet("https://raw.githubusercontent.com/petangZi/rcynAIM/main/rcynSC.lua"))()"

local gui = Instance.new("ScreenGui", game.CoreGui)
local blur = Instance.new("BlurEffect", game.Lighting)
blur.Size = 25

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.2

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.4, 0)
title.Text = "⚡ Memuat rcynAIM System ⚡"
title.TextColor3 = Color3.fromRGB(255, 150, 100)
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.BackgroundTransparency = 1

title.Position = UDim2.new(0, 0, 0.1, 0)

local loading = Instance.new("TextLabel", frame)
loading.Size = UDim2.new(1, 0, 0.6, 0)
loading.Position = UDim2.new(0, 0, 0.4, 0)
loading.Text = "Memuat sistem ."
loading.TextColor3 = Color3.fromRGB(200, 200, 200)
loading.Font = Enum.Font.Gotham
loading.TextSize = 18
loading.BackgroundTransparency = 1

local dots = 1
spawn(function()
    while wait(0.5) do
        dots = (dots % 3) + 1
        loading.Text = "Memuat sistem" .. string.rep(".", dots)
    end
end)

wait(2.5)

-- Hapus loader UI dan jalankan script utama
blur:Destroy()
frame:Destroy()
loadstring(game:HttpGet(core))()

print("✅ rcynAIM LOADER selesai, script utama dimuat")
