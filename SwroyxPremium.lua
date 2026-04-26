-- ╔══════════════════════════════════════════════════════════════════╗
-- ║              SWROYX | PREMIUM UI FRAMEWORK                      ║
-- ║              By Minh Thật — Version 2.0 Premium                 ║
-- ║              Glassmorphism + Deep Blue Aesthetic                ║
-- ╚══════════════════════════════════════════════════════════════════╝

-- ==========================================
-- SERVICES
-- ==========================================
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local HttpService       = game:GetService("HttpService")
local CoreGui           = game:GetService("CoreGui")

local Player            = Players.LocalPlayer
local Mouse             = Player:GetMouse()
local Camera            = workspace.CurrentCamera

-- ==========================================
-- CONFIGURATION
-- ==========================================
local Config = {
    Theme = {
        BG_Deep        = Color3.fromRGB(4, 10, 30),
        BG_Dark        = Color3.fromRGB(8, 18, 48),
        BG_Mid         = Color3.fromRGB(12, 26, 66),
        BG_Light       = Color3.fromRGB(16, 36, 90),
        Accent         = Color3.fromRGB(40, 110, 230),
        AccentBright   = Color3.fromRGB(80, 160, 255),
        AccentNeon     = Color3.fromRGB(100, 190, 255),
        AccentDim      = Color3.fromRGB(25, 65, 150),
        Glass          = Color3.fromRGB(18, 42, 100),
        Border         = Color3.fromRGB(35, 82, 170),
        BorderBright   = Color3.fromRGB(60, 130, 240),
        Text           = Color3.fromRGB(235, 245, 255),
        TextSub        = Color3.fromRGB(160, 200, 240),
        TextDim        = Color3.fromRGB(80, 130, 190),
        TextFaint      = Color3.fromRGB(45, 85, 140),
        White          = Color3.fromRGB(255, 255, 255),
        Success        = Color3.fromRGB(45, 200, 100),
        Error          = Color3.fromRGB(215, 55, 60),
        Warning        = Color3.fromRGB(215, 155, 30),
        Info           = Color3.fromRGB(45, 130, 225),
        ToggleON       = Color3.fromRGB(40, 155, 255),
        ToggleOFF      = Color3.fromRGB(22, 48, 100),
        TabActive      = Color3.fromRGB(28, 82, 190),
        TabHover       = Color3.fromRGB(18, 44, 108),
        TabInactive    = Color3.fromRGB(10, 24, 60),
        Purple         = Color3.fromRGB(140, 80, 255),
        Pink           = Color3.fromRGB(220, 80, 180),
    },
    Font = {
        Bold    = Enum.Font.GothamBold,
        Semi    = Enum.Font.GothamSemibold,
        Regular = Enum.Font.Gotham,
        Black   = Enum.Font.GothamBlack,
    },
    Window = {
        W = 600,
        H = 440,
        TabW = 136,
    },
    KeyBind = Enum.KeyCode.RShift,
    Title   = "Swroyx",
    Sub     = "Premium Edition",
    Creator = "By Minh Thật",
    Ver     = "v2.0",
    AvatarID = 16060333448,
}

-- ==========================================
-- UTILITIES
-- ==========================================
local U = {}

function U.Tween(obj, props, t, style, dir)
    local tw = TweenService:Create(
        obj,
        TweenInfo.new(t or 0.3, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
        props
    )
    tw:Play()
    return tw
end

function U.New(cls, props, parent)
    local i = Instance.new(cls)
    for k, v in pairs(props or {}) do i[k] = v end
    if parent then i.Parent = parent end
    return i
end

function U.Corner(parent, radius)
    return U.New("UICorner", {CornerRadius = UDim.new(0, radius or 8)}, parent)
end

function U.Stroke(parent, color, thick, trans)
    return U.New("UIStroke", {
        Color = color or Config.Theme.Border,
        Thickness = thick or 1,
        Transparency = trans or 0.4,
    }, parent)
end

function U.Gradient(parent, rot, c0, c1, t0, t1)
    return U.New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, c0 or Config.Theme.BG_Mid),
            ColorSequenceKeypoint.new(1, c1 or Config.Theme.BG_Deep),
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, t0 or 0),
            NumberSequenceKeypoint.new(1, t1 or 0),
        }),
        Rotation = rot or 90,
    }, parent)
end

function U.Shadow(parent, alpha)
    return U.New("ImageLabel", {
        Name = "_Shadow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://6014261993",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = alpha or 0.65,
        Position = UDim2.new(0, -18, 0, -18),
        Size = UDim2.new(1, 36, 1, 36),
        ZIndex = (parent.ZIndex or 1) - 1,
    }, parent)
end

function U.Glow(parent, color, alpha)
    return U.New("ImageLabel", {
        Name = "_Glow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://4921375290",
        ImageColor3 = color or Config.Theme.Accent,
        ImageTransparency = alpha or 0.55,
        Position = UDim2.new(0, -20, 0, -20),
        Size = UDim2.new(1, 40, 1, 40),
        ZIndex = (parent.ZIndex or 1) - 1,
    }, parent)
end

function U.Clamp(v, mn, mx)  return math.max(mn, math.min(mx, v)) end
function U.Lerp(a, b, t)     return a + (b - a) * t end
function U.Round(n, d)       local m = 10^(d or 0); return math.floor(n * m + 0.5) / m end
function U.Map(v, a, b, c, d) return (v - a) * (d - c) / (b - a) + c end

function U.Spawn(fn) coroutine.wrap(fn)() end

-- ==========================================
-- CLEAN PREVIOUS GUI
-- ==========================================
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("SwroyxUI") then
        game:GetService("CoreGui"):FindFirstChild("SwroyxUI"):Destroy()
    end
    if Player.PlayerGui:FindFirstChild("SwroyxUI") then
        Player.PlayerGui:FindFirstChild("SwroyxUI"):Destroy()
    end
end)

-- ==========================================
-- ROOT GUI
-- ==========================================
local GUI = U.New("ScreenGui", {
    Name              = "SwroyxUI",
    ResetOnSpawn      = false,
    ZIndexBehavior    = Enum.ZIndexBehavior.Global,
    DisplayOrder      = 999,
    IgnoreGuiInset    = true,
})
pcall(function() GUI.Parent = CoreGui end)
if not GUI.Parent then GUI.Parent = Player.PlayerGui end

-- ==========================================
-- ██ INTRO SEQUENCE
-- ==========================================
local IntroRoot = U.New("Frame", {
    Name                 = "IntroRoot",
    BackgroundColor3     = Color3.fromRGB(2, 6, 20),
    BackgroundTransparency = 0,
    Size                 = UDim2.new(1,0,1,0),
    ZIndex               = 200,
}, GUI)

-- Vignette overlay
local Vignette = U.New("ImageLabel", {
    BackgroundTransparency = 1,
    Image                 = "rbxassetid://4921375290",
    ImageColor3           = Color3.fromRGB(0, 8, 35),
    ImageTransparency     = 0,
    Size                  = UDim2.new(1,0,1,0),
    ZIndex                = 201,
}, IntroRoot)

-- Stars / particles
local StarLayer = U.New("Frame", {
    BackgroundTransparency = 1,
    Size                   = UDim2.new(1,0,1,0),
    ZIndex                 = 202,
}, IntroRoot)

for i = 1, 60 do
    local star = U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(
            math.random(120, 255),
            math.random(160, 255),
            255
        ),
        BackgroundTransparency = math.random(30, 75) / 100,
        Size                   = UDim2.new(0, math.random(1, 4), 0, math.random(1, 4)),
        Position               = UDim2.new(math.random(0,100)/100, 0, math.random(0,100)/100, 0),
        ZIndex                 = 202,
    }, StarLayer)
    U.Corner(star, 100)

    U.Spawn(function()
        local tw = TweenInfo.new(math.random(3, 8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
        TweenService:Create(star, tw, {
            BackgroundTransparency = math.random(70, 95) / 100,
            Size = UDim2.new(0, star.Size.X.Offset + math.random(-1,2), 0, star.Size.Y.Offset + math.random(-1,2)),
        }):Play()
    end)
end

-- Horizontal scan lines decoration
for i = 1, 6 do
    U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(30, 90, 200),
        BackgroundTransparency = 0.88,
        Size                   = UDim2.new(1, 0, 0, 1),
        Position               = UDim2.new(0, 0, i / 7, 0),
        ZIndex                 = 203,
    }, IntroRoot)
end

-- Corner decorations
local function CornerDeco(parent, pos, rot, z)
    U.New("ImageLabel", {
        BackgroundTransparency = 1,
        Image                 = "rbxassetid://4921375290",
        ImageColor3           = Color3.fromRGB(40, 120, 230),
        ImageTransparency     = 0.65,
        Size                  = UDim2.new(0, 90, 0, 90),
        Position              = pos,
        Rotation              = rot,
        ZIndex                = z or 204,
    }, parent)
end
CornerDeco(IntroRoot, UDim2.new(0,-20,0,-20),   0)
CornerDeco(IntroRoot, UDim2.new(1,-70,0,-20),   90)
CornerDeco(IntroRoot, UDim2.new(0,-20,1,-70),   270)
CornerDeco(IntroRoot, UDim2.new(1,-70,1,-70),   180)

-- Animated border lines
local BorderH1 = U.New("Frame", {
    BackgroundColor3     = Color3.fromRGB(50, 140, 255),
    BackgroundTransparency = 0.45,
    Size                   = UDim2.new(0,0,0,1),
    Position               = UDim2.new(0,0,0.10,0),
    ZIndex                 = 205,
}, IntroRoot)
local BorderH2 = U.New("Frame", {
    BackgroundColor3     = Color3.fromRGB(50, 140, 255),
    BackgroundTransparency = 0.45,
    Size                   = UDim2.new(0,0,0,1),
    Position               = UDim2.new(1,0,0.90,0),
    ZIndex                 = 205,
}, IntroRoot)

-- Center glow
local CenterGlow = U.New("ImageLabel", {
    BackgroundTransparency = 1,
    Image                 = "rbxassetid://4921375290",
    ImageColor3           = Color3.fromRGB(20, 80, 200),
    ImageTransparency     = 1,
    Size                  = UDim2.new(0,700,0,350),
    Position              = UDim2.new(0.5,-350,0.5,-175),
    ZIndex                = 204,
}, IntroRoot)

-- Title container
local TitleBox = U.New("Frame", {
    BackgroundTransparency = 1,
    Size                   = UDim2.new(0,500,0,130),
    Position               = UDim2.new(0.5,-250,0.5,-90),
    ZIndex                 = 206,
}, IntroRoot)

-- Multi-layer neon glow behind title
local GlowLayers = {}
for i = 1, 5 do
    local g = U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Black,
        Text                   = "Swroyx",
        TextColor3             = Color3.fromRGB(20 + i*8, 80 + i*12, 210 + i*5),
        TextSize               = 76 + i * 5,
        TextTransparency       = 1,
        TextXAlignment         = Enum.TextXAlignment.Center,
        Size                   = UDim2.new(1,0,0,100),
        Position               = UDim2.new(0,0,0,0),
        ZIndex                 = 206,
    }, TitleBox)
    table.insert(GlowLayers, g)
end

-- Main title
local IntroTitle = U.New("TextLabel", {
    Name                   = "IntroTitle",
    BackgroundTransparency = 1,
    Font                   = Config.Font.Black,
    Text                   = "Swroyx",
    TextColor3             = Config.Theme.White,
    TextSize               = 78,
    TextTransparency       = 1,
    TextStrokeColor3       = Color3.fromRGB(60, 160, 255),
    TextStrokeTransparency = 1,
    TextXAlignment         = Enum.TextXAlignment.Center,
    Size                   = UDim2.new(1,0,0,100),
    Position               = UDim2.new(0,0,0,0),
    ZIndex                 = 208,
}, TitleBox)

-- Subtitle
local IntroSub = U.New("TextLabel", {
    BackgroundTransparency = 1,
    Font                   = Config.Font.Semi,
    Text                   = "◈  P R E M I U M  E D I T I O N  ◈",
    TextColor3             = Config.Theme.AccentBright,
    TextSize               = 15,
    TextTransparency       = 1,
    TextXAlignment         = Enum.TextXAlignment.Center,
    Size                   = UDim2.new(1,0,0,22),
    Position               = UDim2.new(0,0,0,106),
    ZIndex                 = 208,
}, TitleBox)

-- Creator tag
local IntroCreator = U.New("TextLabel", {
    BackgroundTransparency = 1,
    Font                   = Config.Font.Regular,
    Text                   = "by Minh Thật",
    TextColor3             = Config.Theme.TextDim,
    TextSize               = 13,
    TextTransparency       = 1,
    TextXAlignment         = Enum.TextXAlignment.Center,
    Size                   = UDim2.new(1,0,0,18),
    Position               = UDim2.new(0,0,0,130),
    ZIndex                 = 208,
}, TitleBox)

-- Loading bar track
local LoadTrack = U.New("Frame", {
    BackgroundColor3     = Color3.fromRGB(10, 24, 65),
    BackgroundTransparency = 0.25,
    Size                   = UDim2.new(0,320,0,4),
    Position               = UDim2.new(0.5,-160,0.5,80),
    ZIndex                 = 207,
}, IntroRoot)
U.Corner(LoadTrack, 2)
U.Stroke(LoadTrack, Color3.fromRGB(20,55,130), 1, 0.5)

local LoadFill = U.New("Frame", {
    BackgroundColor3 = Color3.fromRGB(60, 155, 255),
    Size             = UDim2.new(0,0,1,0),
    ZIndex           = 208,
}, LoadTrack)
U.Corner(LoadFill, 2)
U.Gradient(LoadFill, 0, Color3.fromRGB(100, 190, 255), Color3.fromRGB(30, 100, 220))

-- Loading label
local LoadLabel = U.New("TextLabel", {
    BackgroundTransparency = 1,
    Font                   = Config.Font.Regular,
    Text                   = "Initializing framework...",
    TextColor3             = Config.Theme.TextDim,
    TextSize               = 12,
    TextTransparency       = 1,
    TextXAlignment         = Enum.TextXAlignment.Center,
    Size                   = UDim2.new(0,320,0,18),
    Position               = UDim2.new(0.5,-160,0.5,90),
    ZIndex                 = 207,
}, IntroRoot)

-- Percentage label
local LoadPct = U.New("TextLabel", {
    BackgroundTransparency = 1,
    Font                   = Config.Font.Semi,
    Text                   = "0%",
    TextColor3             = Config.Theme.AccentBright,
    TextSize               = 12,
    TextTransparency       = 1,
    TextXAlignment         = Enum.TextXAlignment.Right,
    Size                   = UDim2.new(0,320,0,18),
    Position               = UDim2.new(0.5,-160,0.5,62),
    ZIndex                 = 207,
}, IntroRoot)

-- ==========================================
-- INTRO ANIMATION
-- ==========================================
local function PlayIntro(done)
    -- Step 1: Universe awakens
    U.Tween(CenterGlow, {ImageTransparency = 0.25}, 0.9, Enum.EasingStyle.Sine)
    task.wait(0.4)

    -- Border lines sweep
    U.Tween(BorderH1, {Size = UDim2.new(1,0,0,1)}, 0.65, Enum.EasingStyle.Quart)
    task.wait(0.1)
    U.Tween(BorderH2, {
        Size = UDim2.new(1,0,0,1),
        Position = UDim2.new(0,0,0.90,0),
    }, 0.65, Enum.EasingStyle.Quart)
    task.wait(0.55)

    -- Step 2: Glitch flash before title
    for _ = 1, 4 do
        IntroTitle.TextTransparency = 0.5
        IntroTitle.TextStrokeTransparency = 0.6
        task.wait(0.04)
        IntroTitle.TextTransparency = 0.97
        IntroTitle.TextStrokeTransparency = 1
        task.wait(0.03)
    end

    -- Title smooth reveal
    U.Tween(IntroTitle, {TextTransparency = 0, TextStrokeTransparency = 0.35}, 0.55)

    -- Glow pulse loop
    U.Spawn(function()
        while IntroTitle and IntroTitle.Parent and IntroRoot.Parent do
            for _, g in ipairs(GlowLayers) do
                U.Tween(g, {TextTransparency = 0.72}, 1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            end
            task.wait(1.2)
            for _, g in ipairs(GlowLayers) do
                U.Tween(g, {TextTransparency = 0.88}, 1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            end
            task.wait(1.2)
        end
    end)

    task.wait(0.3)
    U.Tween(IntroSub,     {TextTransparency = 0}, 0.45)
    task.wait(0.2)
    U.Tween(IntroCreator, {TextTransparency = 0}, 0.35)
    task.wait(0.25)
    U.Tween(LoadLabel,    {TextTransparency = 0}, 0.3)
    U.Tween(LoadPct,      {TextTransparency = 0}, 0.3)

    -- Step 3: Loading sequence
    local steps = {
        {t = "Loading core modules...",        p = 0.18, d = 0.38},
        {t = "Initializing UI framework...",   p = 0.42, d = 0.40},
        {t = "Building visual components...",  p = 0.61, d = 0.35},
        {t = "Applying glassmorphism...",       p = 0.76, d = 0.30},
        {t = "Configuring animations...",      p = 0.88, d = 0.28},
        {t = "Finalizing — stand by...",       p = 0.96, d = 0.25},
        {t = "Complete! ✓",                    p = 1.00, d = 0.20},
    }

    for _, s in ipairs(steps) do
        task.wait(s.d)
        LoadLabel.Text = s.t
        LoadPct.Text   = math.floor(s.p * 100) .. "%"
        U.Tween(LoadFill, {Size = UDim2.new(s.p, 0, 1, 0)}, 0.28, Enum.EasingStyle.Quart)
    end

    task.wait(0.55)

    -- Step 4: Fade everything out
    local fadeTargets = {
        {IntroTitle,   {TextTransparency = 1, TextStrokeTransparency = 1}},
        {IntroSub,     {TextTransparency = 1}},
        {IntroCreator, {TextTransparency = 1}},
        {LoadLabel,    {TextTransparency = 1}},
        {LoadPct,      {TextTransparency = 1}},
        {LoadFill,     {BackgroundTransparency = 1}},
        {LoadTrack,    {BackgroundTransparency = 1}},
        {BorderH1,     {BackgroundTransparency = 1}},
        {BorderH2,     {BackgroundTransparency = 1}},
        {CenterGlow,   {ImageTransparency = 1}},
        {Vignette,     {ImageTransparency = 1}},
    }
    for _, g in ipairs(GlowLayers) do
        table.insert(fadeTargets, {g, {TextTransparency = 1}})
    end

    for _, pair in ipairs(fadeTargets) do
        U.Tween(pair[1], pair[2], 0.5 + math.random(0,20)/100)
    end
    U.Tween(IntroRoot, {BackgroundTransparency = 1}, 0.65)

    task.wait(0.75)
    IntroRoot:Destroy()
    if done then done() end
end

-- ==========================================
-- ██ MAIN UI
-- ==========================================
local function BuildMainUI()

    -- ── Root container ──
    local Root = U.New("Frame", {
        Name                 = "Root",
        BackgroundTransparency = 1,
        Size                   = UDim2.new(1,0,1,0),
        ZIndex                 = 2,
    }, GUI)

    -- ── Window ──
    local Win = U.New("Frame", {
        Name                 = "Window",
        BackgroundColor3     = Config.Theme.BG_Dark,
        BackgroundTransparency = 0.06,
        Size                   = UDim2.new(0, Config.Window.W, 0, Config.Window.H),
        Position               = UDim2.new(0.5, -Config.Window.W/2, 0.5, -Config.Window.H/2),
        ClipsDescendants       = false,
        ZIndex                 = 4,
    }, Root)
    U.Corner(Win, 14)
    U.Shadow(Win, 0.38)
    U.Stroke(Win, Config.Theme.Border, 1, 0.30)

    -- Window glow halo
    U.New("ImageLabel", {
        BackgroundTransparency = 1,
        Image                 = "rbxassetid://4921375290",
        ImageColor3           = Config.Theme.Accent,
        ImageTransparency     = 0.72,
        Size                  = UDim2.new(1,60,1,60),
        Position              = UDim2.new(0,-30,0,-30),
        ZIndex                = 3,
    }, Win)

    -- Glass noise overlay
    local GlassNoise = U.New("ImageLabel", {
        Name                 = "GlassNoise",
        BackgroundTransparency = 1,
        Image                = "rbxassetid://4921375290",
        ImageColor3          = Color3.fromRGB(80, 130, 255),
        ImageTransparency    = 0.96,
        Size                 = UDim2.new(1,0,1,0),
        ZIndex               = 5,
    }, Win)
    U.Corner(GlassNoise, 14)

    -- Deep gradient background
    local BgGrad = U.New("Frame", {
        BackgroundColor3     = Config.Theme.BG_Dark,
        BackgroundTransparency = 0.04,
        Size                   = UDim2.new(1,0,1,0),
        ZIndex                 = 3,
    }, Win)
    U.Corner(BgGrad, 14)
    U.Gradient(BgGrad, 145,
        Color3.fromRGB(14, 32, 80),
        Color3.fromRGB(4, 10, 28),
        0.05, 0.05
    )

    -- ── HEADER ──
    local Header = U.New("Frame", {
        Name                 = "Header",
        BackgroundColor3     = Config.Theme.BG_Mid,
        BackgroundTransparency = 0.08,
        Size                   = UDim2.new(1,0,0,52),
        ZIndex                 = 8,
    }, Win)
    U.Corner(Header, 14)
    -- fix bottom corners
    U.New("Frame", {
        BackgroundColor3     = Config.Theme.BG_Mid,
        BackgroundTransparency = 0.08,
        Size                   = UDim2.new(1,0,0,14),
        Position               = UDim2.new(0,0,1,-14),
        ZIndex                 = 7,
    }, Header)
    U.Gradient(Header, 0,
        Color3.fromRGB(20, 48, 115),
        Color3.fromRGB(10, 22, 58),
        0, 0
    )

    -- Header bottom separator
    local HdrLine = U.New("Frame", {
        BackgroundColor3     = Config.Theme.Border,
        BackgroundTransparency = 0.25,
        Size                   = UDim2.new(1,0,0,1),
        Position               = UDim2.new(0,0,1,-1),
        ZIndex                 = 9,
    }, Header)
    U.Gradient(HdrLine, 0,
        Config.Theme.AccentBright,
        Color3.fromRGB(15, 45, 115),
        0, 0
    )

    -- Logo box
    local LogoBox = U.New("Frame", {
        BackgroundColor3     = Config.Theme.Accent,
        BackgroundTransparency = 0.55,
        Size                   = UDim2.new(0,38,0,38),
        Position               = UDim2.new(0,10,0.5,-19),
        ZIndex                 = 10,
    }, Header)
    U.Corner(LogoBox, 9)
    U.Stroke(LogoBox, Config.Theme.AccentBright, 1, 0.3)
    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Black,
        Text                   = "S",
        TextColor3             = Config.Theme.AccentNeon,
        TextSize               = 22,
        TextXAlignment         = Enum.TextXAlignment.Center,
        Size                   = UDim2.new(1,0,1,0),
        ZIndex                 = 11,
    }, LogoBox)

    -- Title text
    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Bold,
        Text                   = Config.Title .. "  |  Premium",
        TextColor3             = Config.Theme.White,
        TextSize               = 18,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Size                   = UDim2.new(0,230,0,24),
        Position               = UDim2.new(0,56,0,6),
        ZIndex                 = 10,
    }, Header)

    -- Creator text
    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Regular,
        Text                   = Config.Creator,
        TextColor3             = Config.Theme.TextDim,
        TextSize               = 12,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Size                   = UDim2.new(0,230,0,18),
        Position               = UDim2.new(0,56,0,30),
        ZIndex                 = 10,
    }, Header)

    -- Version badge
    local VerBadge = U.New("Frame", {
        BackgroundColor3     = Config.Theme.AccentDim,
        BackgroundTransparency = 0.35,
        Size                   = UDim2.new(0,72,0,22),
        Position               = UDim2.new(1,-180,0.5,-11),
        ZIndex                 = 10,
    }, Header)
    U.Corner(VerBadge, 5)
    U.Stroke(VerBadge, Config.Theme.Accent, 1, 0.4)
    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Semi,
        Text                   = Config.Ver,
        TextColor3             = Config.Theme.AccentBright,
        TextSize               = 12,
        TextXAlignment         = Enum.TextXAlignment.Center,
        Size                   = UDim2.new(1,0,1,0),
        ZIndex                 = 11,
    }, VerBadge)

    -- Online status dot
    local StatusDot = U.New("Frame", {
        BackgroundColor3 = Config.Theme.Success,
        Size             = UDim2.new(0,8,0,8),
        Position         = UDim2.new(1,-100,0.5,-4),
        ZIndex           = 10,
    }, Header)
    U.Corner(StatusDot, 100)
    U.Spawn(function()
        while StatusDot.Parent do
            U.Tween(StatusDot, {BackgroundTransparency = 0.6, Size = UDim2.new(0,11,0,11), Position = UDim2.new(1,-101.5,0.5,-5.5)}, 0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(0.9)
            U.Tween(StatusDot, {BackgroundTransparency = 0, Size = UDim2.new(0,8,0,8), Position = UDim2.new(1,-100,0.5,-4)}, 0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(0.9)
        end
    end)

    -- Minimize button
    local MinBtn = U.New("TextButton", {
        BackgroundColor3     = Color3.fromRGB(215, 155, 30),
        BackgroundTransparency = 0.4,
        Text                   = "−",
        Font                   = Config.Font.Bold,
        TextColor3             = Color3.fromRGB(255, 225, 140),
        TextSize               = 18,
        Size                   = UDim2.new(0,28,0,28),
        Position               = UDim2.new(1,-68,0.5,-14),
        ZIndex                 = 11,
    }, Header)
    U.Corner(MinBtn, 7)

    -- Close button
    local CloseBtn = U.New("TextButton", {
        BackgroundColor3     = Color3.fromRGB(205, 55, 55),
        BackgroundTransparency = 0.4,
        Text                   = "✕",
        Font                   = Config.Font.Semi,
        TextColor3             = Color3.fromRGB(255, 195, 195),
        TextSize               = 14,
        Size                   = UDim2.new(0,28,0,28),
        Position               = UDim2.new(1,-36,0.5,-14),
        ZIndex                 = 11,
    }, Header)
    U.Corner(CloseBtn, 7)

    CloseBtn.MouseEnter:Connect(function()  U.Tween(CloseBtn, {BackgroundTransparency = 0.05}, 0.15) end)
    CloseBtn.MouseLeave:Connect(function()  U.Tween(CloseBtn, {BackgroundTransparency = 0.40}, 0.15) end)
    CloseBtn.MouseButton1Click:Connect(function()
        U.Tween(Win, {Size = UDim2.new(0,Config.Window.W,0,0), Position = UDim2.new(0.5,-Config.Window.W/2,0.5,0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.35)
        GUI:Destroy()
    end)

    MinBtn.MouseEnter:Connect(function()  U.Tween(MinBtn, {BackgroundTransparency = 0.05}, 0.15) end)
    MinBtn.MouseLeave:Connect(function()  U.Tween(MinBtn, {BackgroundTransparency = 0.40}, 0.15) end)

    -- ── DRAG ──
    local dragging, dragStart, winStart = false, nil, nil
    Header.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = inp.Position
            winStart  = Win.Position
        end
    end)
    Header.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local d = inp.Position - dragStart
            Win.Position = UDim2.new(winStart.X.Scale, winStart.X.Offset + d.X, winStart.Y.Scale, winStart.Y.Offset + d.Y)
        end
    end)

    -- ── LEFT TAB BAR ──
    local TabBarH = Config.Window.H - 53
    local TabBar = U.New("Frame", {
        Name                 = "TabBar",
        BackgroundColor3     = Color3.fromRGB(5, 13, 36),
        BackgroundTransparency = 0.06,
        Size                   = UDim2.new(0, Config.Window.TabW, 0, TabBarH),
        Position               = UDim2.new(0,0,0,52),
        ZIndex                 = 6,
    }, Win)
    U.Corner(TabBar, 14)
    -- Fix right side
    U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(5, 13, 36),
        BackgroundTransparency = 0.06,
        Size                   = UDim2.new(0,14,1,0),
        Position               = UDim2.new(1,-14,0,0),
        ZIndex                 = 5,
    }, TabBar)
    -- Fix top corners
    U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(5, 13, 36),
        BackgroundTransparency = 0.06,
        Size                   = UDim2.new(1,0,0,14),
        ZIndex                 = 5,
    }, TabBar)

    -- Tab bar right separator
    U.New("Frame", {
        BackgroundColor3     = Config.Theme.Border,
        BackgroundTransparency = 0.5,
        Size                   = UDim2.new(0,1,1,0),
        Position               = UDim2.new(1,-1,0,0),
        ZIndex                 = 7,
    }, TabBar)

    local TabList = U.New("UIListLayout", {
        FillDirection        = Enum.FillDirection.Vertical,
        HorizontalAlignment  = Enum.HorizontalAlignment.Center,
        Padding              = UDim.new(0,4),
        SortOrder            = Enum.SortOrder.LayoutOrder,
    }, TabBar)
    U.New("UIPadding", {
        PaddingTop   = UDim.new(0,10),
        PaddingLeft  = UDim.new(0,6),
        PaddingRight = UDim.new(0,6),
    }, TabBar)

    -- ── CONTENT AREA ──
    local CW = Config.Window.W - Config.Window.TabW
    local ContentArea = U.New("Frame", {
        Name             = "ContentArea",
        BackgroundTransparency = 1,
        Size               = UDim2.new(0, CW, 0, TabBarH),
        Position           = UDim2.new(0, Config.Window.TabW, 0, 52),
        ClipsDescendants   = true,
        ZIndex             = 6,
    }, Win)

    -- ── AVATAR (bottom right) ──
    local AvatarWrap = U.New("Frame", {
        BackgroundColor3     = Config.Theme.BG_Mid,
        BackgroundTransparency = 0.15,
        Size                   = UDim2.new(0,46,0,46),
        Position               = UDim2.new(1,-56,1,-56),
        ZIndex                 = 12,
    }, Win)
    U.Corner(AvatarWrap, 100)
    U.Stroke(AvatarWrap, Config.Theme.AccentBright, 2, 0.15)
    U.Glow(AvatarWrap, Config.Theme.AccentBright, 0.48)

    U.New("ImageLabel", {
        BackgroundTransparency = 1,
        Image                  = "rbxthumb://type=AvatarHeadShot&id=" .. Config.AvatarID .. "&w=150&h=150",
        Size                   = UDim2.new(1,0,1,0),
        ZIndex                 = 13,
    }, AvatarWrap)
    U.Corner(AvatarWrap, 100)

    U.Spawn(function()
        while AvatarWrap.Parent do
            U.Tween(AvatarWrap, {BackgroundTransparency = 0.4}, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1.5)
            U.Tween(AvatarWrap, {BackgroundTransparency = 0.15}, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1.5)
        end
    end)

    -- ── Scanning line effect ──
    local ScanWrap = U.New("Frame", {
        BackgroundTransparency = 1,
        Size                   = UDim2.new(1,0,1,0),
        ClipsDescendants       = true,
        ZIndex                 = 99,
    }, Win)
    U.Corner(ScanWrap, 14)
    local ScanLine = U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(80, 170, 255),
        BackgroundTransparency = 0.91,
        Size                   = UDim2.new(1,0,0,3),
        Position               = UDim2.new(0,0,-0.05,0),
        ZIndex                 = 100,
    }, ScanWrap)
    U.Spawn(function()
        while ScanLine.Parent do
            ScanLine.Position = UDim2.new(0,0,-0.05,0)
            U.Tween(ScanLine, {Position = UDim2.new(0,0,1.05,0)}, 4.5, Enum.EasingStyle.Linear)
            task.wait(4.8)
        end
    end)

    -- ==========================================
    -- TAB SYSTEM
    -- ==========================================
    local Tabs = {}
    local ActiveTab = nil

    local function NewTab(name, icon, order)
        local td = {name = name, active = false}

        -- Button
        local Btn = U.New("TextButton", {
            BackgroundColor3     = Config.Theme.TabInactive,
            BackgroundTransparency = 0.35,
            Text                   = "",
            Size                   = UDim2.new(1,0,0,38),
            LayoutOrder            = order,
            ZIndex                 = 8,
        }, TabBar)
        U.Corner(Btn, 9)

        -- Active indicator
        local ActiveBar = U.New("Frame", {
            BackgroundColor3     = Config.Theme.AccentBright,
            BackgroundTransparency = 1,
            Size                   = UDim2.new(0,3,0,22),
            Position               = UDim2.new(0,-3,0.5,-11),
            ZIndex                 = 9,
        }, Btn)
        U.Corner(ActiveBar, 2)

        -- Icon
        local Icon = U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = icon,
            TextColor3             = Config.Theme.TextFaint,
            TextSize               = 16,
            TextXAlignment         = Enum.TextXAlignment.Center,
            Size                   = UDim2.new(0,26,1,0),
            Position               = UDim2.new(0,5,0,0),
            ZIndex                 = 9,
        }, Btn)

        -- Name
        local NameLbl = U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Regular,
            Text                   = name,
            TextColor3             = Config.Theme.TextFaint,
            TextSize               = 13,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(1,-36,1,0),
            Position               = UDim2.new(0,35,0,0),
            ZIndex                 = 9,
        }, Btn)

        -- Page (ScrollingFrame)
        local Page = U.New("ScrollingFrame", {
            BackgroundTransparency = 1,
            Size                   = UDim2.new(1,0,1,0),
            Visible                = false,
            ScrollBarThickness     = 3,
            ScrollBarImageColor3   = Color3.fromRGB(40, 110, 225),
            ScrollBarImageTransparency = 0.4,
            CanvasSize             = UDim2.new(0,0,0,0),
            AutomaticCanvasSize    = Enum.AutomaticSize.Y,
            ZIndex                 = 7,
        }, ContentArea)
        U.New("UIPadding", {
            PaddingTop    = UDim.new(0,12),
            PaddingLeft   = UDim.new(0,12),
            PaddingRight  = UDim.new(0,12),
            PaddingBottom = UDim.new(0,12),
        }, Page)
        U.New("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            Padding       = UDim.new(0,7),
            SortOrder     = Enum.SortOrder.LayoutOrder,
        }, Page)

        -- Hover
        Btn.MouseEnter:Connect(function()
            if not td.active then
                U.Tween(Btn,     {BackgroundTransparency = 0.15, BackgroundColor3 = Config.Theme.TabHover}, 0.18)
                U.Tween(NameLbl, {TextColor3 = Config.Theme.TextSub}, 0.18)
                U.Tween(Icon,    {TextColor3 = Config.Theme.TextSub}, 0.18)
            end
        end)
        Btn.MouseLeave:Connect(function()
            if not td.active then
                U.Tween(Btn,     {BackgroundTransparency = 0.35, BackgroundColor3 = Config.Theme.TabInactive}, 0.18)
                U.Tween(NameLbl, {TextColor3 = Config.Theme.TextFaint}, 0.18)
                U.Tween(Icon,    {TextColor3 = Config.Theme.TextFaint}, 0.18)
            end
        end)

        -- Click
        Btn.MouseButton1Click:Connect(function()
            if ActiveTab then
                ActiveTab.page.Visible = false
                U.Tween(ActiveTab.btn,      {BackgroundColor3 = Config.Theme.TabInactive, BackgroundTransparency = 0.35}, 0.22)
                U.Tween(ActiveTab.nameLbl,  {TextColor3 = Config.Theme.TextFaint}, 0.22)
                U.Tween(ActiveTab.icon,     {TextColor3 = Config.Theme.TextFaint}, 0.22)
                U.Tween(ActiveTab.activeBar,{BackgroundTransparency = 1}, 0.22)
                ActiveTab.active = false
            end
            td.active = true
            ActiveTab = td
            Page.Visible = true
            U.Tween(Btn,      {BackgroundColor3 = Config.Theme.TabActive, BackgroundTransparency = 0.1}, 0.22)
            U.Tween(NameLbl,  {TextColor3 = Config.Theme.White}, 0.22)
            U.Tween(Icon,     {TextColor3 = Config.Theme.AccentNeon}, 0.22)
            U.Tween(ActiveBar,{BackgroundTransparency = 0}, 0.22)
        end)

        td.btn = Btn; td.page = Page; td.icon = Icon
        td.nameLbl = NameLbl; td.activeBar = ActiveBar
        table.insert(Tabs, td)
        return td
    end

    -- ==========================================
    -- COMPONENT LIBRARY
    -- ==========================================
    local C = {}

    -- SECTION HEADER
    function C.Section(parent, text, order)
        local f = U.New("Frame", {
            BackgroundTransparency = 1,
            Size                   = UDim2.new(1,0,0,24),
            LayoutOrder            = order or 1,
            ZIndex                 = 8,
        }, parent)
        U.New("Frame", {
            BackgroundColor3     = Config.Theme.Accent,
            BackgroundTransparency = 0.55,
            Size                   = UDim2.new(0,18,0,1),
            Position               = UDim2.new(0,0,0.5,0),
            ZIndex                 = 9,
        }, f)
        U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = text,
            TextColor3             = Config.Theme.AccentBright,
            TextSize               = 11,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(1,-24,1,0),
            Position               = UDim2.new(0,22,0,0),
            ZIndex                 = 9,
        }, f)
        return f
    end

    -- TOGGLE
    function C.Toggle(parent, label, desc, default, cb, order)
        local val = default or false
        local h = desc and 52 or 42

        local card = U.New("Frame", {
            BackgroundColor3     = Config.Theme.BG_Mid,
            BackgroundTransparency = 0.18,
            Size                   = UDim2.new(1,0,0,h),
            LayoutOrder            = order or 1,
            ZIndex                 = 8,
        }, parent)
        U.Corner(card, 9)
        U.Stroke(card, Config.Theme.Border, 1, 0.45)
        U.Gradient(card, 90, Config.Theme.BG_Light, Config.Theme.BG_Dark, 0.18, 0.18)

        U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = label,
            TextColor3             = Config.Theme.Text,
            TextSize               = 14,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(1,-70,0,20),
            Position               = UDim2.new(0,12,0,desc and 8 or 11),
            ZIndex                 = 9,
        }, card)

        if desc then
            U.New("TextLabel", {
                BackgroundTransparency = 1,
                Font                   = Config.Font.Regular,
                Text                   = desc,
                TextColor3             = Config.Theme.TextDim,
                TextSize               = 11,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Size                   = UDim2.new(1,-70,0,16),
                Position               = UDim2.new(0,12,0,28),
                ZIndex                 = 9,
            }, card)
        end

        -- Switch bg
        local swBg = U.New("Frame", {
            BackgroundColor3 = val and Config.Theme.ToggleON or Config.Theme.ToggleOFF,
            Size             = UDim2.new(0,44,0,24),
            Position         = UDim2.new(1,-56,0.5,-12),
            ZIndex           = 9,
        }, card)
        U.Corner(swBg, 100)
        U.Stroke(swBg, Color3.fromRGB(0,0,0), 1, 0.7)

        -- Knob
        local knob = U.New("Frame", {
            BackgroundColor3 = Config.Theme.White,
            Size             = UDim2.new(0,18,0,18),
            Position         = UDim2.new(0, val and 23 or 3, 0.5,-9),
            ZIndex           = 10,
        }, swBg)
        U.Corner(knob, 100)
        U.Glow(knob, val and Config.Theme.AccentBright or Color3.fromRGB(130,130,130), val and 0.45 or 0.82)

        -- Clickable overlay
        local hit = U.New("TextButton", {
            BackgroundTransparency = 1,
            Text                   = "",
            Size                   = UDim2.new(1,0,1,0),
            ZIndex                 = 11,
        }, card)

        hit.MouseButton1Click:Connect(function()
            val = not val
            U.Tween(swBg,  {BackgroundColor3 = val and Config.Theme.ToggleON or Config.Theme.ToggleOFF}, 0.22)
            U.Tween(knob,  {Position = UDim2.new(0, val and 23 or 3, 0.5,-9)}, 0.22, Enum.EasingStyle.Back)
            if cb then cb(val) end
        end)
        hit.MouseEnter:Connect(function()  U.Tween(card, {BackgroundTransparency = 0.04}, 0.15) end)
        hit.MouseLeave:Connect(function()  U.Tween(card, {BackgroundTransparency = 0.18}, 0.15) end)

        return card
    end

    -- SLIDER
    function C.Slider(parent, label, mn, mx, def, suffix, cb, order)
        local val = def or mn
        local isDragging = false

        local card = U.New("Frame", {
            BackgroundColor3     = Config.Theme.BG_Mid,
            BackgroundTransparency = 0.18,
            Size                   = UDim2.new(1,0,0,58),
            LayoutOrder            = order or 1,
            ZIndex                 = 8,
        }, parent)
        U.Corner(card, 9)
        U.Stroke(card, Config.Theme.Border, 1, 0.45)
        U.Gradient(card, 90, Config.Theme.BG_Light, Config.Theme.BG_Dark, 0.18, 0.18)

        U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = label,
            TextColor3             = Config.Theme.Text,
            TextSize               = 14,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(0.65,0,0,20),
            Position               = UDim2.new(0,12,0,8),
            ZIndex                 = 9,
        }, card)

        local ValLbl = U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = tostring(val) .. (suffix or ""),
            TextColor3             = Config.Theme.AccentBright,
            TextSize               = 13,
            TextXAlignment         = Enum.TextXAlignment.Right,
            Size                   = UDim2.new(0.35,-12,0,20),
            Position               = UDim2.new(0.65,0,0,8),
            ZIndex                 = 9,
        }, card)

        -- Track
        local track = U.New("Frame", {
            BackgroundColor3     = Config.Theme.BG_Deep,
            BackgroundTransparency = 0.15,
            Size                   = UDim2.new(1,-24,0,6),
            Position               = UDim2.new(0,12,0,36),
            ZIndex                 = 9,
        }, card)
        U.Corner(track, 3)
        U.Stroke(track, Config.Theme.AccentDim, 1, 0.6)

        -- Fill
        local fill = U.New("Frame", {
            BackgroundColor3 = Config.Theme.Accent,
            Size             = UDim2.new((val - mn)/(mx - mn), 0, 1, 0),
            ZIndex           = 10,
        }, track)
        U.Corner(fill, 3)
        U.Gradient(fill, 0, Config.Theme.AccentNeon, Config.Theme.Accent)

        -- Thumb
        local thumb = U.New("Frame", {
            BackgroundColor3 = Config.Theme.White,
            Size             = UDim2.new(0,14,0,14),
            Position         = UDim2.new((val - mn)/(mx - mn), -7, 0.5,-7),
            ZIndex           = 11,
        }, track)
        U.Corner(thumb, 100)
        U.Glow(thumb, Config.Theme.AccentBright, 0.52)

        local function setSlider(px)
            local rel = U.Clamp((px - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            val = U.Round(U.Map(rel, 0, 1, mn, mx), 0)
            U.Tween(fill,  {Size = UDim2.new(rel,0,1,0)}, 0.08)
            U.Tween(thumb, {Position = UDim2.new(rel,-7,0.5,-7)}, 0.08)
            ValLbl.Text = tostring(val) .. (suffix or "")
            if cb then cb(val) end
        end

        track.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
                setSlider(inp.Position.X)
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if isDragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
                setSlider(inp.Position.X)
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = false end
        end)

        return card
    end

    -- BUTTON
    function C.Button(parent, label, desc, color, cb, order)
        color = color or Config.Theme.Accent
        local h = desc and 54 or 42

        local card = U.New("Frame", {
            BackgroundColor3     = Config.Theme.BG_Mid,
            BackgroundTransparency = 0.18,
            Size                   = UDim2.new(1,0,0,h),
            LayoutOrder            = order or 1,
            ZIndex                 = 8,
        }, parent)
        U.Corner(card, 9)
        U.Stroke(card, Config.Theme.Border, 1, 0.45)

        U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = label,
            TextColor3             = Config.Theme.Text,
            TextSize               = 14,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(0.58,0,0,20),
            Position               = UDim2.new(0,12,0,desc and 9 or 11),
            ZIndex                 = 9,
        }, card)

        if desc then
            U.New("TextLabel", {
                BackgroundTransparency = 1,
                Font                   = Config.Font.Regular,
                Text                   = desc,
                TextColor3             = Config.Theme.TextDim,
                TextSize               = 11,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Size                   = UDim2.new(0.58,0,0,16),
                Position               = UDim2.new(0,12,0,29),
                ZIndex                 = 9,
            }, card)
        end

        local btn = U.New("TextButton", {
            BackgroundColor3     = color,
            BackgroundTransparency = 0.18,
            Text                   = label,
            Font                   = Config.Font.Semi,
            TextColor3             = Config.Theme.White,
            TextSize               = 13,
            Size                   = UDim2.new(0,88,0, desc and 32 or 26),
            Position               = UDim2.new(1,-100,0.5, desc and -16 or -13),
            ZIndex                 = 9,
        }, card)
        U.Corner(btn, 7)
        U.Gradient(btn, 90,
            Color3.fromRGB(
                math.min(255, color.R*255 + 30),
                math.min(255, color.G*255 + 30),
                math.min(255, color.B*255 + 30)
            ),
            color
        )

        btn.MouseEnter:Connect(function()  U.Tween(btn, {BackgroundTransparency = 0,   Size = UDim2.new(0,92,0, desc and 34 or 28)}, 0.15) end)
        btn.MouseLeave:Connect(function()  U.Tween(btn, {BackgroundTransparency = 0.18, Size = UDim2.new(0,88,0, desc and 32 or 26)}, 0.15) end)
        btn.MouseButton1Click:Connect(function()
            U.Tween(btn, {BackgroundTransparency = 0.55}, 0.08)
            task.wait(0.09)
            U.Tween(btn, {BackgroundTransparency = 0.18}, 0.12)
            if cb then cb() end
        end)

        return card
    end

    -- DROPDOWN
    function C.Dropdown(parent, label, opts, default, cb, order)
        local sel = default or opts[1]
        local open = false

        local card = U.New("Frame", {
            BackgroundColor3     = Config.Theme.BG_Mid,
            BackgroundTransparency = 0.18,
            Size                   = UDim2.new(1,0,0,42),
            LayoutOrder            = order or 1,
            ClipsDescendants       = false,
            ZIndex                 = 8,
        }, parent)
        U.Corner(card, 9)
        U.Stroke(card, Config.Theme.Border, 1, 0.45)
        U.Gradient(card, 90, Config.Theme.BG_Light, Config.Theme.BG_Dark, 0.18, 0.18)

        U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = label,
            TextColor3             = Config.Theme.Text,
            TextSize               = 14,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(0.48,0,1,0),
            Position               = UDim2.new(0,12,0,0),
            ZIndex                 = 9,
        }, card)

        local dropBtn = U.New("TextButton", {
            BackgroundColor3     = Config.Theme.BG_Light,
            BackgroundTransparency = 0.25,
            Text                   = "",
            Size                   = UDim2.new(0,148,0,30),
            Position               = UDim2.new(1,-160,0.5,-15),
            ZIndex                 = 9,
        }, card)
        U.Corner(dropBtn, 7)
        U.Stroke(dropBtn, Config.Theme.Accent, 1, 0.45)

        local SelTxt = U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Regular,
            Text                   = sel,
            TextColor3             = Config.Theme.AccentBright,
            TextSize               = 13,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(1,-30,1,0),
            Position               = UDim2.new(0,8,0,0),
            ZIndex                 = 10,
        }, dropBtn)

        local Arrow = U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Regular,
            Text                   = "▾",
            TextColor3             = Config.Theme.TextDim,
            TextSize               = 14,
            TextXAlignment         = Enum.TextXAlignment.Center,
            Size                   = UDim2.new(0,22,1,0),
            Position               = UDim2.new(1,-24,0,0),
            ZIndex                 = 10,
        }, dropBtn)

        -- List
        local list = U.New("Frame", {
            BackgroundColor3     = Color3.fromRGB(8, 20, 54),
            BackgroundTransparency = 0.04,
            Size                   = UDim2.new(0,148,0,0),
            Position               = UDim2.new(1,-160,1,5),
            Visible                = false,
            ClipsDescendants       = true,
            ZIndex                 = 50,
        }, card)
        U.Corner(list, 9)
        U.Stroke(list, Config.Theme.Accent, 1, 0.3)
        U.Shadow(list, 0.5)

        local ll = U.New("UIListLayout", {Padding = UDim.new(0,2)}, list)
        U.New("UIPadding", {
            PaddingTop    = UDim.new(0,4),
            PaddingBottom = UDim.new(0,4),
            PaddingLeft   = UDim.new(0,4),
            PaddingRight  = UDim.new(0,4),
        }, list)

        for _, opt in ipairs(opts) do
            local ob = U.New("TextButton", {
                BackgroundColor3     = Config.Theme.BG_Light,
                BackgroundTransparency = 0.75,
                Text                   = opt,
                Font                   = Config.Font.Regular,
                TextColor3             = Config.Theme.TextSub,
                TextSize               = 13,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Size                   = UDim2.new(1,0,0,28),
                ZIndex                 = 51,
            }, list)
            U.Corner(ob, 5)
            U.New("UIPadding", {PaddingLeft = UDim.new(0,8)}, ob)

            ob.MouseEnter:Connect(function()  U.Tween(ob, {BackgroundTransparency = 0.2, TextColor3 = Config.Theme.White}, 0.14) end)
            ob.MouseLeave:Connect(function()  U.Tween(ob, {BackgroundTransparency = 0.75, TextColor3 = Config.Theme.TextSub}, 0.14) end)
            ob.MouseButton1Click:Connect(function()
                sel = opt
                SelTxt.Text = opt
                open = false
                U.Tween(list,  {Size = UDim2.new(0,148,0,0)}, 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                U.Tween(Arrow, {Rotation = 0}, 0.18)
                task.wait(0.2)
                list.Visible = false
                if cb then cb(opt) end
            end)
        end

        dropBtn.MouseButton1Click:Connect(function()
            open = not open
            local th = #opts * 30 + 8
            if open then
                list.Visible = true
                list.Size    = UDim2.new(0,148,0,0)
                U.Tween(list,  {Size = UDim2.new(0,148,0,th)}, 0.22, Enum.EasingStyle.Back)
                U.Tween(Arrow, {Rotation = 180}, 0.2)
            else
                U.Tween(list,  {Size = UDim2.new(0,148,0,0)}, 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                U.Tween(Arrow, {Rotation = 0}, 0.18)
                task.wait(0.2)
                list.Visible = false
            end
        end)
        return card
    end

    -- INPUT BOX
    function C.Input(parent, label, placeholder, cb, order)
        local card = U.New("Frame", {
            BackgroundColor3     = Config.Theme.BG_Mid,
            BackgroundTransparency = 0.18,
            Size                   = UDim2.new(1,0,0,56),
            LayoutOrder            = order or 1,
            ZIndex                 = 8,
        }, parent)
        U.Corner(card, 9)
        U.Stroke(card, Config.Theme.Border, 1, 0.45)

        U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = label,
            TextColor3             = Config.Theme.TextSub,
            TextSize               = 12,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(1,-24,0,18),
            Position               = UDim2.new(0,12,0,6),
            ZIndex                 = 9,
        }, card)

        local box = U.New("TextBox", {
            BackgroundColor3      = Config.Theme.BG_Deep,
            BackgroundTransparency = 0.25,
            Font                  = Config.Font.Regular,
            PlaceholderText       = placeholder or "Enter value...",
            PlaceholderColor3     = Config.Theme.TextFaint,
            Text                  = "",
            TextColor3            = Config.Theme.Text,
            TextSize              = 13,
            TextXAlignment        = Enum.TextXAlignment.Left,
            ClearTextOnFocus      = false,
            Size                  = UDim2.new(1,-24,0,24),
            Position              = UDim2.new(0,12,0,26),
            ZIndex                = 9,
        }, card)
        U.Corner(box, 6)
        U.Stroke(box, Config.Theme.AccentDim, 1, 0.45)
        U.New("UIPadding", {PaddingLeft = UDim.new(0,8)}, box)

        box.Focused:Connect(function()    U.Tween(box, {BackgroundTransparency = 0.08}, 0.18) end)
        box.FocusLost:Connect(function(enter)
            U.Tween(box, {BackgroundTransparency = 0.25}, 0.18)
            if enter and cb then cb(box.Text) end
        end)
        return card
    end

    -- INFO BOX
    function C.Info(parent, label, value, accent, order)
        accent = accent or Config.Theme.Accent
        local card = U.New("Frame", {
            BackgroundColor3     = Config.Theme.BG_Mid,
            BackgroundTransparency = 0.2,
            Size                   = UDim2.new(1,0,0,40),
            LayoutOrder            = order or 1,
            ZIndex                 = 8,
        }, parent)
        U.Corner(card, 9)
        U.Stroke(card, Config.Theme.Border, 1, 0.5)

        -- Left accent bar
        U.New("Frame", {
            BackgroundColor3 = accent,
            Size             = UDim2.new(0,3,1,-14),
            Position         = UDim2.new(0,0,0,7),
            ZIndex           = 9,
        }, card)

        U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Regular,
            Text                   = label,
            TextColor3             = Config.Theme.TextDim,
            TextSize               = 12,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(0.5,0,1,0),
            Position               = UDim2.new(0,14,0,0),
            ZIndex                 = 9,
        }, card)

        local vLbl = U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = tostring(value),
            TextColor3             = Config.Theme.Text,
            TextSize               = 13,
            TextXAlignment         = Enum.TextXAlignment.Right,
            Size                   = UDim2.new(0.5,-12,1,0),
            Position               = UDim2.new(0.5,0,0,0),
            ZIndex                 = 9,
        }, card)

        return card, vLbl
    end

    -- COLORED DIVIDER
    function C.Divider(parent, order)
        local f = U.New("Frame", {
            BackgroundColor3     = Config.Theme.Border,
            BackgroundTransparency = 0.6,
            Size                   = UDim2.new(1,0,0,1),
            LayoutOrder            = order or 1,
            ZIndex                 = 8,
        }, parent)
        U.Gradient(f, 0, Config.Theme.Accent, Config.Theme.BG_Dark, 0.1, 1)
        return f
    end

    -- LABEL
    function C.Label(parent, text, color, size, order)
        return U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Regular,
            Text                   = text,
            TextColor3             = color or Config.Theme.TextDim,
            TextSize               = size or 12,
            TextXAlignment         = Enum.TextXAlignment.Left,
            TextWrapped            = true,
            Size                   = UDim2.new(1,0,0,18),
            LayoutOrder            = order or 1,
            ZIndex                 = 8,
        }, parent)
    end

    -- ==========================================
    -- ── TAB: HOME
    -- ==========================================
    local tHome = NewTab("Home", "⌂", 1)

    C.Section(tHome.page, "── OVERVIEW", 1)

    -- Welcome card
    local welcome = U.New("Frame", {
        BackgroundColor3     = Config.Theme.BG_Light,
        BackgroundTransparency = 0.1,
        Size                   = UDim2.new(1,0,0,74),
        LayoutOrder            = 2,
        ZIndex                 = 8,
    }, tHome.page)
    U.Corner(welcome, 11)
    U.Stroke(welcome, Config.Theme.AccentBright, 1, 0.3)
    U.Gradient(welcome, 135,
        Color3.fromRGB(22, 55, 140),
        Color3.fromRGB(6, 15, 45),
        0, 0
    )

    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Bold,
        Text                   = "Welcome to Swroyx",
        TextColor3             = Config.Theme.White,
        TextSize               = 18,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Size                   = UDim2.new(1,-56,0,26),
        Position               = UDim2.new(0,14,0,12),
        ZIndex                 = 9,
    }, welcome)
    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Regular,
        Text                   = "Premium Edition  ·  Advanced Framework  ·  By Minh Thật",
        TextColor3             = Config.Theme.TextDim,
        TextSize               = 12,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Size                   = UDim2.new(1,-24,0,18),
        Position               = UDim2.new(0,14,0,38),
        ZIndex                 = 9,
    }, welcome)

    -- Animated star icon
    local star = U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Black,
        Text                   = "✦",
        TextColor3             = Config.Theme.Accent,
        TextSize               = 28,
        TextXAlignment         = Enum.TextXAlignment.Center,
        Size                   = UDim2.new(0,46,1,0),
        Position               = UDim2.new(1,-54,0,0),
        ZIndex                 = 9,
    }, welcome)
    U.Spawn(function()
        while star.Parent do
            U.Tween(star, {TextColor3 = Config.Theme.AccentNeon, TextTransparency = 0.2}, 1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1.4)
            U.Tween(star, {TextColor3 = Config.Theme.Accent, TextTransparency = 0}, 1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1.4)
        end
    end)

    C.Info(tHome.page, "Status",   "Active ✓",       Config.Theme.Success, 3)
    C.Info(tHome.page, "Version",  Config.Ver,        Config.Theme.AccentBright, 4)
    C.Info(tHome.page, "Creator",  "Minh Thật",       Config.Theme.Purple, 5)
    C.Info(tHome.page, "Platform", "Roblox / Luau",   Color3.fromRGB(255,120,30), 6)
    C.Info(tHome.page, "Player",   Player.DisplayName, Config.Theme.Pink, 7)

    C.Section(tHome.page, "── QUICK ACTIONS", 8)
    C.Button(tHome.page, "Refresh", "Reload all modules", Config.Theme.Accent, function() end, 9)
    C.Button(tHome.page, "Discord", "Join the community", Color3.fromRGB(88,101,242), function() end, 10)
    C.Button(tHome.page, "GitHub",  "View source code",   Color3.fromRGB(36, 41, 62), function() end, 11)

    -- ==========================================
    -- ── TAB: COMBAT
    -- ==========================================
    local tCombat = NewTab("Combat", "⚔", 2)

    C.Section(tCombat.page, "── AIM ASSIST", 1)
    C.Toggle(tCombat.page,  "Aim Assist",       "Automatically assist targeting", false, nil, 2)
    C.Slider(tCombat.page,  "Sensitivity",      1, 100, 50,  "%",  nil, 3)
    C.Slider(tCombat.page,  "Smoothness",       1, 20,  5,   "x",  nil, 4)
    C.Toggle(tCombat.page,  "Silent Aim",       "Invisible aim correction",       false, nil, 5)
    C.Dropdown(tCombat.page,"Hit Part",         {"Head","Torso","HumanoidRootPart","Nearest"}, "Head", nil, 6)
    C.Slider(tCombat.page,  "FOV Circle",       5, 360, 90,  "°",  nil, 7)

    C.Section(tCombat.page, "── MOVEMENT", 8)
    C.Toggle(tCombat.page,  "Bunny Hop",        "Auto jump while sprinting",      false, nil, 9)
    C.Toggle(tCombat.page,  "Infinite Jump",    "Jump without cooldown",          false, nil, 10)
    C.Toggle(tCombat.page,  "Anti Knockback",   "Reduce knockback forces",        false, nil, 11)

    C.Section(tCombat.page, "── BYPASS", 12)
    C.Toggle(tCombat.page,  "Anti-Cheat Bypass","Avoid detection systems",        false, nil, 13)
    C.Toggle(tCombat.page,  "Lag Switch",       "Brief network lag on demand",    false, nil, 14)

    -- ==========================================
    -- ── TAB: VISUALS
    -- ==========================================
    local tVis = NewTab("Visuals", "◈", 3)

    C.Section(tVis.page, "── ESP", 1)
    C.Toggle(tVis.page,  "Player ESP",      "See players through walls",      false, nil, 2)
    C.Toggle(tVis.page,  "Name Tags",       "Player names above heads",       false, nil, 3)
    C.Toggle(tVis.page,  "Health Bar",      "Display HP above players",       false, nil, 4)
    C.Toggle(tVis.page,  "Box ESP",         "Draw boxes around players",      false, nil, 5)
    C.Toggle(tVis.page,  "Tracer Lines",    "Lines from screen bottom",       false, nil, 6)
    C.Slider(tVis.page,  "ESP Distance",    100, 5000, 1500, "m",   nil, 7)

    C.Section(tVis.page, "── CHAMS", 8)
    C.Toggle(tVis.page,  "Chams",           "Colorize player models",         false, nil, 9)
    C.Dropdown(tVis.page,"Style",           {"Flat","Neon","Glass","Wireframe","Rainbow"}, "Flat", nil, 10)
    C.Toggle(tVis.page,  "Fullbright",      "Max visibility in dark areas",   false, nil, 11)
    C.Toggle(tVis.page,  "Remove Fog",      "Disable all weather fog",        false, nil, 12)

    C.Section(tVis.page, "── CROSSHAIR", 13)
    C.Toggle(tVis.page,  "Custom Crosshair","Replace default crosshair",      false, nil, 14)
    C.Dropdown(tVis.page,"Shape",           {"Cross","Circle","Dot","Square","T"}, "Cross", nil, 15)
    C.Slider(tVis.page,  "Crosshair Size",  4, 40, 12, "px", nil, 16)

    -- ==========================================
    -- ── TAB: MOVEMENT
    -- ==========================================
    local tMove = NewTab("Movement", "↑", 4)

    C.Section(tMove.page, "── SPEED", 1)
    C.Toggle(tMove.page,  "Speed Hack",     "Increase walk speed",            false, nil, 2)
    C.Slider(tMove.page,  "Walk Speed",     16, 500, 16,   " ws",  nil, 3)
    C.Slider(tMove.page,  "Sprint Speed",   16, 500, 80,   " ws",  nil, 4)
    C.Toggle(tMove.page,  "Auto Sprint",    "Always sprint when walking",     false, nil, 5)

    C.Section(tMove.page, "── FLY", 6)
    C.Toggle(tMove.page,  "Fly Mode",       "Enable free flight",             false, nil, 7)
    C.Slider(tMove.page,  "Fly Speed",      10, 400, 60,   " ws",  nil, 8)
    C.Toggle(tMove.page,  "Hover",          "Stay still in the air",          false, nil, 9)

    C.Section(tMove.page, "── MISC", 10)
    C.Toggle(tMove.page,  "No Clip",        "Walk through walls",             false, nil, 11)
    C.Toggle(tMove.page,  "No Fall Damage", "Disable fall damage",            false, nil, 12)
    C.Toggle(tMove.page,  "Teleport Cursor","Click to teleport",              false, nil, 13)
    C.Toggle(tMove.page,  "High Jump",      "Greatly increases jump height",  false, nil, 14)
    C.Slider(tMove.page,  "Jump Power",     50, 500, 50,   " jp",  nil, 15)

    -- ==========================================
    -- ── TAB: MISC
    -- ==========================================
    local tMisc = NewTab("Misc", "☰", 5)

    C.Section(tMisc.page, "── UTILITY", 1)
    C.Toggle(tMisc.page,  "Anti-AFK",       "Prevent inactivity kick",        true,  nil, 2)
    C.Toggle(tMisc.page,  "Auto Farm",      "Automatically gather resources", false, nil, 3)
    C.Toggle(tMisc.page,  "Chat Bypass",    "Skip chat content filter",       false, nil, 4)
    C.Input(tMisc.page,   "Chat Message",   "Enter message to broadcast...",  nil, 5)

    C.Section(tMisc.page, "── PLAYER", 6)
    C.Toggle(tMisc.page,  "Invisible",      "Hide your character",            false, nil, 7)
    C.Toggle(tMisc.page,  "God Mode",       "Invincibility mode",             false, nil, 8)
    C.Toggle(tMisc.page,  "Infinite Ammo",  "No reload needed",               false, nil, 9)
    C.Toggle(tMisc.page,  "Third Person",   "Force third-person view",        false, nil, 10)
    C.Slider(tMisc.page,  "FOV",            50, 130, 70,   "°",    nil, 11)

    C.Section(tMisc.page, "── WORLD", 12)
    C.Toggle(tMisc.page,  "Freeze Players", "Stop all other players",         false, nil, 13)
    C.Dropdown(tMisc.page,"Time of Day",    {"Default","Dawn","Day","Dusk","Night","Midnight"}, "Default", nil, 14)

    -- ==========================================
    -- ── TAB: SETTINGS
    -- ==========================================
    local tSet = NewTab("Settings", "⚙", 6)

    C.Section(tSet.page, "── INTERFACE", 1)
    C.Toggle(tSet.page,   "Animations",     "Enable all UI animations",       true,  nil, 2)
    C.Slider(tSet.page,   "Transparency",   0, 90, 6,    "%",
        function(v) U.Tween(Win, {BackgroundTransparency = v/100}, 0.18) end, 3)
    C.Toggle(tSet.page,   "Blur BG",        "Blur game behind the UI",        true,  nil, 4)
    C.Dropdown(tSet.page, "Keybind",        {"RShift","Delete","Insert","F5","End","Home"}, "RShift", nil, 5)
    C.Dropdown(tSet.page, "Theme",          {"Deep Blue","Midnight","Arctic","Crimson"}, "Deep Blue", nil, 6)

    C.Section(tSet.page, "── NOTIFICATIONS", 7)
    C.Toggle(tSet.page,   "Notifications",  "Show toast notifications",       true,  nil, 8)
    C.Slider(tSet.page,   "Notif Duration", 2, 12, 5,   "s",    nil, 9)

    C.Section(tSet.page, "── ABOUT", 10)
    C.Info(tSet.page, "Script",  "Swroyx Premium",       Config.Theme.AccentBright, 11)
    C.Info(tSet.page, "Build",   "2025.06",              Config.Theme.Success,      12)
    C.Info(tSet.page, "Runtime", "Luau",                 Color3.fromRGB(255,150,50), 13)
    C.Info(tSet.page, "Exploit", "Universal",            Config.Theme.Purple,       14)

    C.Divider(tSet.page, 15)
    C.Button(tSet.page, "Reset",    "Restore all defaults", Config.Theme.Error, nil, 16)
    C.Button(tSet.page, "Reload",   "Re-execute script",    Config.Theme.Accent, nil, 17)

    -- ── Activate first tab ──
    do
        local t = tHome
        t.active = true
        ActiveTab = t
        t.page.Visible = true
        t.btn.BackgroundColor3     = Config.Theme.TabActive
        t.btn.BackgroundTransparency = 0.1
        t.nameLbl.TextColor3       = Config.Theme.White
        t.icon.TextColor3          = Config.Theme.AccentNeon
        t.activeBar.BackgroundTransparency = 0
    end

    -- ── Minimize ──
    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            U.Tween(Win, {Size = UDim2.new(0,Config.Window.W,0,52)}, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            MinBtn.Text = "+"
        else
            U.Tween(Win, {Size = UDim2.new(0,Config.Window.W,0,Config.Window.H)}, 0.28, Enum.EasingStyle.Back)
            MinBtn.Text = "−"
        end
    end)

    -- ── Window open animation ──
    Win.Size     = UDim2.new(0,Config.Window.W,0,0)
    Win.Position = UDim2.new(0.5,-Config.Window.W/2,0.5,0)
    U.Tween(Win, {
        Size     = UDim2.new(0,Config.Window.W,0,Config.Window.H),
        Position = UDim2.new(0.5,-Config.Window.W/2,0.5,-Config.Window.H/2),
    }, 0.45, Enum.EasingStyle.Back)

    return Root
end

-- ==========================================
-- ██ NOTIFICATION SYSTEM
-- ==========================================
local NotifHolder = U.New("Frame", {
    Name                 = "NotifHolder",
    BackgroundTransparency = 1,
    Size                   = UDim2.new(0,330,1,0),
    Position               = UDim2.new(1,-344,0,0),
    ZIndex                 = 300,
}, GUI)

U.New("UIListLayout", {
    FillDirection       = Enum.FillDirection.Vertical,
    VerticalAlignment   = Enum.VerticalAlignment.Bottom,
    Padding             = UDim.new(0,6),
    SortOrder           = Enum.SortOrder.LayoutOrder,
}, NotifHolder)

U.New("UIPadding", {
    PaddingBottom = UDim.new(0,22),
}, NotifHolder)

local function Notify(title, message, kind, dur)
    kind = kind or "info"
    dur  = dur  or 5

    local palette = {
        success = {Color3.fromRGB(38,185,88),   "✓"},
        error   = {Color3.fromRGB(210,52,52),   "✕"},
        warning = {Color3.fromRGB(210,148,22),  "⚠"},
        info    = {Color3.fromRGB(38,118,220),  "ℹ"},
    }

    local col, icon = table.unpack(palette[kind] or palette.info)

    local card = U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(7, 17, 48),
        BackgroundTransparency = 0.04,
        Size                   = UDim2.new(1,0,0,68),
        Position               = UDim2.new(1.08,0,0,0),
        ZIndex                 = 301,
    }, NotifHolder)
    U.Corner(card, 11)
    U.Stroke(card, col, 1, 0.4)
    U.Shadow(card, 0.48)
    U.Gradient(card, 90,
        Color3.fromRGB(11, 26, 70),
        Color3.fromRGB(5, 12, 36),
        0, 0
    )

    -- Top accent stripe
    local stripe = U.New("Frame", {
        BackgroundColor3 = col,
        Size             = UDim2.new(1,-20,0,2),
        Position         = UDim2.new(0,10,0,0),
        ZIndex           = 302,
    }, card)
    U.Corner(stripe, 1)

    -- Left bar
    U.New("Frame", {
        BackgroundColor3 = col,
        Size             = UDim2.new(0,3,1,-14),
        Position         = UDim2.new(0,0,0,7),
        ZIndex           = 302,
    }, card)

    -- Icon
    local iconBox = U.New("Frame", {
        BackgroundColor3     = col,
        BackgroundTransparency = 0.68,
        Size                   = UDim2.new(0,32,0,32),
        Position               = UDim2.new(0,10,0.5,-16),
        ZIndex                 = 302,
    }, card)
    U.Corner(iconBox, 9)
    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Bold,
        Text                   = icon,
        TextColor3             = col,
        TextSize               = 17,
        TextXAlignment         = Enum.TextXAlignment.Center,
        Size                   = UDim2.new(1,0,1,0),
        ZIndex                 = 303,
    }, iconBox)

    -- Text
    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Semi,
        Text                   = title,
        TextColor3             = Config.Theme.Text,
        TextSize               = 14,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Size                   = UDim2.new(1,-62,0,20),
        Position               = UDim2.new(0,52,0,10),
        ZIndex                 = 302,
    }, card)

    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Regular,
        Text                   = message,
        TextColor3             = Config.Theme.TextDim,
        TextSize               = 12,
        TextXAlignment         = Enum.TextXAlignment.Left,
        TextWrapped            = true,
        Size                   = UDim2.new(1,-62,0,28),
        Position               = UDim2.new(0,52,0,32),
        ZIndex                 = 302,
    }, card)

    -- Progress bar
    local pgBg = U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(18, 38, 88),
        BackgroundTransparency = 0.45,
        Size                   = UDim2.new(1,-20,0,3),
        Position               = UDim2.new(0,10,1,-8),
        ZIndex                 = 302,
    }, card)
    U.Corner(pgBg, 2)

    local pgFill = U.New("Frame", {
        BackgroundColor3 = col,
        Size             = UDim2.new(1,0,1,0),
        ZIndex           = 303,
    }, pgBg)
    U.Corner(pgFill, 2)

    -- Slide in
    U.Tween(card, {Position = UDim2.new(0,0,0,0)}, 0.35, Enum.EasingStyle.Back)
    -- Progress drain
    U.Tween(pgFill, {Size = UDim2.new(0,0,1,0)}, dur, Enum.EasingStyle.Linear)

    U.Spawn(function()
        task.wait(dur)
        U.Tween(card, {Position = UDim2.new(1.1,0,0,0), BackgroundTransparency = 1}, 0.3)
        task.wait(0.35)
        card:Destroy()
    end)

    return card
end

-- ==========================================
-- ██ SHOW / HIDE TOGGLE BUTTON
-- ==========================================
local ToggleBtn = U.New("TextButton", {
    Name                 = "ToggleBtn",
    BackgroundColor3     = Config.Theme.AccentDim,
    BackgroundTransparency = 0.18,
    Text                   = "[ Hide ]",
    Font                   = Config.Font.Semi,
    TextColor3             = Config.Theme.AccentBright,
    TextSize               = 13,
    Size                   = UDim2.new(0,92,0,30),
    Position               = UDim2.new(0,14,1,-44),
    ZIndex                 = 100,
}, GUI)
U.Corner(ToggleBtn, 7)
U.Stroke(ToggleBtn, Config.Theme.Accent, 1, 0.28)
U.Shadow(ToggleBtn, 0.55)
U.Gradient(ToggleBtn, 90,
    Color3.fromRGB(30, 84, 190),
    Color3.fromRGB(10, 38, 108)
)

ToggleBtn.MouseEnter:Connect(function()  U.Tween(ToggleBtn, {BackgroundTransparency = 0,    TextColor3 = Config.Theme.White}, 0.18) end)
ToggleBtn.MouseLeave:Connect(function()  U.Tween(ToggleBtn, {BackgroundTransparency = 0.18, TextColor3 = Config.Theme.AccentBright}, 0.18) end)

-- ==========================================
-- ██ LAUNCH
-- ==========================================
local mainUI = nil
local uiVisible = true

local function ToggleUI()
    if not mainUI then return end
    uiVisible = not uiVisible
    local win = mainUI:FindFirstChild("Window")
    if not win then return end

    if uiVisible then
        win.Visible = true
        ToggleBtn.Text = "[ Hide ]"
        U.Tween(win, {Position = UDim2.new(0.5,-Config.Window.W/2,0.5,-Config.Window.H/2)}, 0.3, Enum.EasingStyle.Back)
    else
        ToggleBtn.Text = "[ Show ]"
        U.Tween(win, {Position = UDim2.new(0.5,-Config.Window.W/2,-0.12,0)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.3, function() if win then win.Visible = false end end)
    end
end

ToggleBtn.MouseButton1Click:Connect(ToggleUI)

-- Keybind
UserInputService.InputBegan:Connect(function(inp, gpe)
    if not gpe and inp.KeyCode == Config.KeyBind then
        ToggleUI()
    end
end)

-- ── Fire intro, then build UI ──
U.Spawn(function()
    PlayIntro(function()
        mainUI = BuildMainUI()
        task.wait(0.9)
        Notify("Swroyx Premium", "Script loaded successfully!", "success", 5)
        task.wait(1.6)
        Notify("By Minh Thật", "Welcome, " .. Player.DisplayName .. "!", "info", 4)
    end)
end)

-- ==========================================
-- PUBLIC API
-- ==========================================
return {
    Notify = Notify,
    Toggle = ToggleUI,
}

-- END OF SWROYX | PREMIUM UI FRAMEWORK

-- ==========================================
-- ██ EXTENDED MODULE: PARTICLE SYSTEM
-- ==========================================
-- Particle emitter attached to window edges for ambient effect
local ParticleModule = {}

function ParticleModule.StartAmbient(guiRoot)
    local pRoot = U.New("Frame", {
        Name = "ParticleRoot",
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1,0),
        ZIndex = 1,
    }, guiRoot)

    local function SpawnParticle()
        local side = math.random(1,4)
        local startX, startY
        if side == 1 then startX, startY = math.random(0,100)/100, 0
        elseif side == 2 then startX, startY = math.random(0,100)/100, 1
        elseif side == 3 then startX, startY = 0, math.random(0,100)/100
        else startX, startY = 1, math.random(0,100)/100 end

        local colors = {
            Color3.fromRGB(40,120,255),
            Color3.fromRGB(80,180,255),
            Color3.fromRGB(120,200,255),
            Color3.fromRGB(160,220,255),
            Color3.fromRGB(60,100,220),
        }
        local col = colors[math.random(#colors)]
        local sz  = math.random(2,7)

        local p = U.New("Frame", {
            BackgroundColor3     = col,
            BackgroundTransparency = math.random(20,60)/100,
            Size                   = UDim2.new(0,sz,0,sz),
            Position               = UDim2.new(startX,0,startY,0),
            ZIndex                 = 2,
        }, pRoot)
        U.Corner(p, 100)

        local targetX = startX + (math.random(-40,40)/100)
        local targetY = startY + (math.random(-40,40)/100)
        local tDur    = math.random(3,8) + math.random()/1
        local tw      = TweenService:Create(p, TweenInfo.new(tDur, Enum.EasingStyle.Linear), {
            Position               = UDim2.new(targetX,0,targetY,0),
            BackgroundTransparency = 1,
            Size                   = UDim2.new(0,0,0,0),
        })
        tw:Play()
        tw.Completed:Connect(function() pcall(function() p:Destroy() end) end)
    end

    U.Spawn(function()
        while pRoot and pRoot.Parent do
            SpawnParticle()
            task.wait(math.random(8,20)/100)
        end
    end)

    return pRoot
end

-- ==========================================
-- ██ EXTENDED MODULE: KEYBIND MANAGER
-- ==========================================
local KeybindModule = {}
KeybindModule._binds = {}

function KeybindModule.Register(key, label, fn)
    table.insert(KeybindModule._binds, {key = key, label = label, fn = fn, active = false})
    UserInputService.InputBegan:Connect(function(inp, gpe)
        if not gpe and inp.KeyCode == key then
            fn()
        end
    end)
end

function KeybindModule.List()
    for i, b in ipairs(KeybindModule._binds) do
        print(string.format("[%d] %s → %s", i, tostring(b.key), b.label))
    end
end

-- ==========================================
-- ██ EXTENDED MODULE: CONFIG SERIALIZER
-- ==========================================
local ConfigModule = {}
ConfigModule._data = {}

function ConfigModule.Set(key, value)
    ConfigModule._data[key] = value
end

function ConfigModule.Get(key, default)
    return ConfigModule._data[key] ~= nil and ConfigModule._data[key] or default
end

function ConfigModule.Reset()
    ConfigModule._data = {}
end

function ConfigModule.Export()
    local lines = {}
    for k, v in pairs(ConfigModule._data) do
        table.insert(lines, tostring(k) .. "=" .. tostring(v))
    end
    return table.concat(lines, "\n")
end

function ConfigModule.Import(str)
    for line in str:gmatch("[^\n]+") do
        local k, v = line:match("^(.-)=(.+)$")
        if k then
            local n = tonumber(v)
            if n then
                ConfigModule._data[k] = n
            elseif v == "true" then
                ConfigModule._data[k] = true
            elseif v == "false" then
                ConfigModule._data[k] = false
            else
                ConfigModule._data[k] = v
            end
        end
    end
end

-- ==========================================
-- ██ EXTENDED MODULE: WATERMARK
-- ==========================================
local WatermarkModule = {}

function WatermarkModule.Create(guiRoot)
    local bar = U.New("Frame", {
        Name                 = "Watermark",
        BackgroundColor3     = Color3.fromRGB(5, 12, 38),
        BackgroundTransparency = 0.08,
        Size                   = UDim2.new(0,320,0,28),
        Position               = UDim2.new(0.5,-160,0,14),
        ZIndex                 = 150,
    }, guiRoot)
    U.Corner(bar, 7)
    U.Stroke(bar, Config.Theme.Accent, 1, 0.3)
    U.Gradient(bar, 0,
        Color3.fromRGB(14, 38, 100),
        Color3.fromRGB(5, 12, 38)
    )

    local wLbl = U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Semi,
        Text                   = "Swroyx Premium  ·  By Minh Thật  ·  " .. Config.Ver,
        TextColor3             = Config.Theme.AccentBright,
        TextSize               = 12,
        TextXAlignment         = Enum.TextXAlignment.Center,
        Size                   = UDim2.new(0.78,0,1,0),
        Position               = UDim2.new(0.11,0,0,0),
        ZIndex                 = 151,
    }, bar)

    -- Ping / FPS display (right side)
    local fpsTxt = U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Regular,
        Text                   = "60 FPS",
        TextColor3             = Config.Theme.Success,
        TextSize               = 11,
        TextXAlignment         = Enum.TextXAlignment.Right,
        Size                   = UDim2.new(0,70,1,0),
        Position               = UDim2.new(1,-74,0,0),
        ZIndex                 = 151,
    }, bar)

    -- Live FPS updater
    local lastTick, frames = tick(), 0
    U.Spawn(function()
        while bar and bar.Parent do
            RunService.RenderStepped:Wait()
            frames = frames + 1
            local now = tick()
            if now - lastTick >= 1 then
                local fps = math.floor(frames / (now - lastTick))
                local col = fps >= 55 and Config.Theme.Success
                         or fps >= 30 and Config.Theme.Warning
                         or Config.Theme.Error
                fpsTxt.Text      = fps .. " FPS"
                fpsTxt.TextColor3 = col
                frames, lastTick = 0, now
            end
        end
    end)

    return bar
end

-- ==========================================
-- ██ EXTENDED MODULE: TOOLTIP SYSTEM
-- ==========================================
local TooltipModule = {}
local _tooltip = nil

function TooltipModule.Init(guiRoot)
    _tooltip = U.New("Frame", {
        Name                 = "Tooltip",
        BackgroundColor3     = Color3.fromRGB(6, 15, 44),
        BackgroundTransparency = 0.05,
        Size                   = UDim2.new(0,200,0,36),
        Position               = UDim2.new(0,0,0,0),
        Visible                = false,
        ZIndex                 = 500,
    }, guiRoot)
    U.Corner(_tooltip, 7)
    U.Stroke(_tooltip, Config.Theme.Accent, 1, 0.35)
    U.Shadow(_tooltip, 0.5)

    U.New("TextLabel", {
        Name                   = "TipText",
        BackgroundTransparency = 1,
        Font                   = Config.Font.Regular,
        Text                   = "",
        TextColor3             = Config.Theme.TextSub,
        TextSize               = 12,
        TextXAlignment         = Enum.TextXAlignment.Left,
        TextWrapped            = true,
        Size                   = UDim2.new(1,-14,1,0),
        Position               = UDim2.new(0,7,0,0),
        ZIndex                 = 501,
    }, _tooltip)
end

function TooltipModule.Show(text, x, y)
    if not _tooltip then return end
    local tip = _tooltip:FindFirstChild("TipText")
    if tip then tip.Text = text end
    _tooltip.Position = UDim2.new(0, x+14, 0, y+14)
    _tooltip.Visible  = true
    U.Tween(_tooltip, {BackgroundTransparency = 0.05}, 0.15)
end

function TooltipModule.Hide()
    if not _tooltip then return end
    U.Tween(_tooltip, {BackgroundTransparency = 1}, 0.12)
    task.delay(0.13, function()
        if _tooltip then _tooltip.Visible = false end
    end)
end

-- ==========================================
-- ██ EXTENDED MODULE: ANIMATION LIBRARY
-- ==========================================
local AnimLib = {}

-- Shake a GuiObject (e.g. on error)
function AnimLib.Shake(obj, intensity, duration)
    intensity = intensity or 8
    duration  = duration or 0.35
    local orig = obj.Position
    local endT = tick() + duration
    U.Spawn(function()
        while tick() < endT do
            local ox = math.random(-intensity, intensity)
            local oy = math.random(-intensity, intensity)
            obj.Position = UDim2.new(
                orig.X.Scale, orig.X.Offset + ox,
                orig.Y.Scale, orig.Y.Offset + oy
            )
            task.wait(0.025)
        end
        obj.Position = orig
    end)
end

-- Bounce scale animation
function AnimLib.Bounce(obj, scale, dur)
    scale = scale or 1.06
    dur   = dur or 0.18
    local os = obj.Size
    U.Tween(obj, {Size = UDim2.new(os.X.Scale*scale, os.X.Offset*scale, os.Y.Scale*scale, os.Y.Offset*scale)}, dur/2, Enum.EasingStyle.Back)
    task.delay(dur/2, function()
        U.Tween(obj, {Size = os}, dur/2, Enum.EasingStyle.Back)
    end)
end

-- Rainbow text cycle
function AnimLib.RainbowText(lbl, speed)
    speed = speed or 1
    U.Spawn(function()
        local hue = 0
        while lbl and lbl.Parent do
            hue = (hue + speed * 0.005) % 1
            lbl.TextColor3 = Color3.fromHSV(hue, 0.85, 1)
            RunService.RenderStepped:Wait()
        end
    end)
end

-- Typewriter effect
function AnimLib.Typewriter(lbl, text, speed)
    speed = speed or 0.04
    U.Spawn(function()
        lbl.Text = ""
        for i = 1, #text do
            lbl.Text = text:sub(1, i)
            task.wait(speed)
        end
    end)
end

-- Fade in
function AnimLib.FadeIn(obj, dur)
    local orig = obj.BackgroundTransparency
    obj.BackgroundTransparency = 1
    U.Tween(obj, {BackgroundTransparency = orig}, dur or 0.3)
end

-- ==========================================
-- ██ EXTENDED MODULE: THEME ENGINE
-- ==========================================
local ThemeEngine = {}
ThemeEngine._themes = {
    ["Deep Blue"] = {
        BG_Dark  = Color3.fromRGB(8, 18, 48),
        Accent   = Color3.fromRGB(40, 110, 230),
        Border   = Color3.fromRGB(35, 82, 170),
    },
    ["Midnight"] = {
        BG_Dark  = Color3.fromRGB(12, 12, 20),
        Accent   = Color3.fromRGB(130, 60, 230),
        Border   = Color3.fromRGB(80, 40, 160),
    },
    ["Arctic"] = {
        BG_Dark  = Color3.fromRGB(10, 28, 40),
        Accent   = Color3.fromRGB(50, 190, 220),
        Border   = Color3.fromRGB(30, 130, 170),
    },
    ["Crimson"] = {
        BG_Dark  = Color3.fromRGB(28, 8, 12),
        Accent   = Color3.fromRGB(210, 45, 55),
        Border   = Color3.fromRGB(150, 28, 38),
    },
}

function ThemeEngine.Apply(name)
    local t = ThemeEngine._themes[name]
    if not t then return end
    for k, v in pairs(t) do
        Config.Theme[k] = v
    end
end

function ThemeEngine.List()
    local names = {}
    for k in pairs(ThemeEngine._themes) do table.insert(names, k) end
    return names
end

function ThemeEngine.AddCustom(name, data)
    ThemeEngine._themes[name] = data
end

-- ==========================================
-- ██ EXTENDED MODULE: LOGGER
-- ==========================================
local Logger = {}
Logger._log = {}
Logger._maxLines = 200

function Logger.Log(level, msg)
    local entry = {
        time  = os.date("%H:%M:%S"),
        level = level,
        msg   = msg,
    }
    table.insert(Logger._log, entry)
    if #Logger._log > Logger._maxLines then
        table.remove(Logger._log, 1)
    end
    -- Optional: print to output
    -- print(string.format("[%s][%s] %s", entry.time, level, msg))
end

function Logger.Info(msg)    Logger.Log("INFO",    msg) end
function Logger.Warn(msg)    Logger.Log("WARN",    msg) end
function Logger.Error(msg)   Logger.Log("ERROR",   msg) end
function Logger.Success(msg) Logger.Log("SUCCESS", msg) end

function Logger.Dump()
    local lines = {}
    for _, e in ipairs(Logger._log) do
        table.insert(lines, string.format("[%s][%s] %s", e.time, e.level, e.msg))
    end
    return table.concat(lines, "\n")
end

function Logger.Clear()
    Logger._log = {}
end

-- ==========================================
-- ██ EXTENDED MODULE: ESP ENGINE
-- ==========================================
local ESPEngine = {}
ESPEngine._highlights = {}
ESPEngine._enabled    = false

function ESPEngine.Highlight(player)
    if not player.Character then return end
    local h = Instance.new("Highlight")
    h.FillColor       = Color3.fromRGB(40, 120, 255)
    h.OutlineColor    = Color3.fromRGB(130, 200, 255)
    h.FillTransparency    = 0.65
    h.OutlineTransparency = 0
    h.Adornee = player.Character
    h.Parent  = player.Character
    ESPEngine._highlights[player.UserId] = h
end

function ESPEngine.Remove(player)
    local h = ESPEngine._highlights[player.UserId]
    if h then
        h:Destroy()
        ESPEngine._highlights[player.UserId] = nil
    end
end

function ESPEngine.Enable()
    ESPEngine._enabled = true
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player then
            ESPEngine.Highlight(p)
        end
    end
    Players.PlayerAdded:Connect(function(p)
        if ESPEngine._enabled and p ~= Player then
            p.CharacterAdded:Connect(function()
                task.wait(0.5)
                ESPEngine.Highlight(p)
            end)
        end
    end)
end

function ESPEngine.Disable()
    ESPEngine._enabled = false
    for uid, h in pairs(ESPEngine._highlights) do
        pcall(function() h:Destroy() end)
        ESPEngine._highlights[uid] = nil
    end
end

-- ==========================================
-- ██ EXTENDED MODULE: FOV CIRCLE
-- ==========================================
local FOVModule = {}

function FOVModule.Create(guiRoot, radius)
    radius = radius or 90
    local circle = U.New("Frame", {
        Name                 = "FOVCircle",
        BackgroundTransparency = 1,
        Size                   = UDim2.new(0, radius*2, 0, radius*2),
        Position               = UDim2.new(0.5,-radius,0.5,-radius),
        ZIndex                 = 80,
    }, guiRoot)
    U.Corner(circle, 100)
    U.Stroke(circle, Color3.fromRGB(80, 190, 255), 1.5, 0.25)

    -- Crosshair dot center
    local dot = U.New("Frame", {
        BackgroundColor3 = Color3.fromRGB(255,255,255),
        Size             = UDim2.new(0,4,0,4),
        Position         = UDim2.new(0.5,-2,0.5,-2),
        ZIndex           = 81,
    }, guiRoot)
    U.Corner(dot, 100)

    -- H line
    U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(255,255,255),
        BackgroundTransparency = 0.3,
        Size                   = UDim2.new(0,18,0,1),
        Position               = UDim2.new(0.5,-9,0.5,0),
        ZIndex                 = 81,
    }, guiRoot)

    -- V line
    U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(255,255,255),
        BackgroundTransparency = 0.3,
        Size                   = UDim2.new(0,1,0,18),
        Position               = UDim2.new(0.5,0,0.5,-9),
        ZIndex                 = 81,
    }, guiRoot)

    return circle
end

function FOVModule.SetRadius(circle, r)
    U.Tween(circle, {
        Size     = UDim2.new(0,r*2,0,r*2),
        Position = UDim2.new(0.5,-r,0.5,-r),
    }, 0.22)
end

-- ==========================================
-- ██ EXTENDED MODULE: RAINBOW BORDER
-- ==========================================
local RainbowBorder = {}

function RainbowBorder.Apply(frame, stroke, speed)
    speed = speed or 0.8
    U.Spawn(function()
        local hue = 0
        while frame and frame.Parent do
            hue = (hue + speed * 0.005) % 1
            stroke.Color = Color3.fromHSV(hue, 0.9, 1)
            RunService.RenderStepped:Wait()
        end
    end)
end

-- ==========================================
-- ██ EXTENDED MODULE: BLUR CONTROLLER
-- ==========================================
local BlurCtrl = {}

function BlurCtrl.SetBlur(intensity)
    local lb = game:GetService("Lighting")
    local b  = lb:FindFirstChildOfClass("BlurEffect")
    if not b then
        b = Instance.new("BlurEffect")
        b.Parent = lb
    end
    TweenService:Create(b, TweenInfo.new(0.35), {Size = intensity}):Play()
end

function BlurCtrl.EnableBlur()  BlurCtrl.SetBlur(8)  end
function BlurCtrl.DisableBlur() BlurCtrl.SetBlur(0)  end

-- ==========================================
-- ██ EXTENDED MODULE: CLOCK WIDGET
-- ==========================================
local ClockWidget = {}

function ClockWidget.Create(guiRoot)
    local frame = U.New("Frame", {
        Name                 = "ClockWidget",
        BackgroundColor3     = Color3.fromRGB(5, 13, 38),
        BackgroundTransparency = 0.14,
        Size                   = UDim2.new(0,100,0,28),
        Position               = UDim2.new(1,-114,0,14),
        ZIndex                 = 150,
    }, guiRoot)
    U.Corner(frame, 7)
    U.Stroke(frame, Config.Theme.Accent, 1, 0.45)

    local clockLbl = U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Semi,
        Text                   = "00:00:00",
        TextColor3             = Config.Theme.AccentBright,
        TextSize               = 13,
        TextXAlignment         = Enum.TextXAlignment.Center,
        Size                   = UDim2.new(1,0,1,0),
        ZIndex                 = 151,
    }, frame)

    U.Spawn(function()
        while clockLbl and clockLbl.Parent do
            clockLbl.Text = os.date("%H:%M:%S")
            task.wait(1)
        end
    end)
    return frame
end

-- ==========================================
-- ██ EXTENDED MODULE: STATS DISPLAY
-- ==========================================
local StatsDisplay = {}

function StatsDisplay.Create(guiRoot)
    local panel = U.New("Frame", {
        Name                 = "StatsPanel",
        BackgroundColor3     = Color3.fromRGB(5, 13, 38),
        BackgroundTransparency = 0.08,
        Size                   = UDim2.new(0,180,0,110),
        Position               = UDim2.new(0,14,0,56),
        ZIndex                 = 90,
    }, guiRoot)
    U.Corner(panel, 10)
    U.Stroke(panel, Config.Theme.Border, 1, 0.4)
    U.Shadow(panel, 0.52)

    U.New("UIListLayout", {
        FillDirection       = Enum.FillDirection.Vertical,
        Padding             = UDim.new(0,5),
        SortOrder           = Enum.SortOrder.LayoutOrder,
    }, panel)
    U.New("UIPadding", {
        PaddingTop    = UDim.new(0,8),
        PaddingLeft   = UDim.new(0,10),
        PaddingRight  = UDim.new(0,10),
    }, panel)

    local function Stat(lbl, val, col)
        local row = U.New("Frame", {
            BackgroundTransparency = 1,
            Size                   = UDim2.new(1,0,0,20),
            ZIndex                 = 91,
        }, panel)
        U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Regular,
            Text                   = lbl,
            TextColor3             = Config.Theme.TextDim,
            TextSize               = 11,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Size                   = UDim2.new(0.55,0,1,0),
            ZIndex                 = 92,
        }, row)
        local vl = U.New("TextLabel", {
            BackgroundTransparency = 1,
            Font                   = Config.Font.Semi,
            Text                   = val,
            TextColor3             = col or Config.Theme.Text,
            TextSize               = 11,
            TextXAlignment         = Enum.TextXAlignment.Right,
            Size                   = UDim2.new(0.45,0,1,0),
            Position               = UDim2.new(0.55,0,0,0),
            ZIndex                 = 92,
        }, row)
        return vl
    end

    local _, fpsLbl  = Stat("FPS",    "60",        Config.Theme.Success)
    local _, pingLbl = Stat("Ping",   "32ms",      Config.Theme.AccentBright)
    local _, memLbl  = Stat("Memory", "0 MB",      Config.Theme.Warning)
    local _, plrLbl  = Stat("Players","0",         Config.Theme.Purple)

    -- Live updates
    U.Spawn(function()
        local lastT, fc = tick(), 0
        while fpsLbl and fpsLbl.Parent do
            RunService.RenderStepped:Wait()
            fc = fc + 1
            local now = tick()
            if now - lastT >= 0.8 then
                local fps = math.floor(fc / (now - lastT))
                fpsLbl.Text = fps .. " fps"
                fpsLbl.TextColor3 = fps >= 55 and Config.Theme.Success
                                 or fps >= 30 and Config.Theme.Warning
                                 or Config.Theme.Error
                fc, lastT = 0, now
            end
        end
    end)

    U.Spawn(function()
        while pingLbl and pingLbl.Parent do
            local stats = game:GetService("Stats")
            if stats then
                local p = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
                pingLbl.Text = p .. " ms"
                pingLbl.TextColor3 = p < 80  and Config.Theme.Success
                                  or p < 150 and Config.Theme.Warning
                                  or Config.Theme.Error
            end
            task.wait(2)
        end
    end)

    U.Spawn(function()
        while memLbl and memLbl.Parent do
            local mb = math.floor(game:GetService("Stats"):GetTotalMemoryUsageMb())
            memLbl.Text = mb .. " MB"
            task.wait(3)
        end
    end)

    U.Spawn(function()
        while plrLbl and plrLbl.Parent do
            plrLbl.Text = tostring(#Players:GetPlayers())
            task.wait(5)
        end
    end)

    return panel
end

-- ==========================================
-- ██ EXTENDED MODULE: CONFIRMATION DIALOG
-- ==========================================
local Dialog = {}

function Dialog.Confirm(guiRoot, title, message, onYes, onNo)
    local overlay = U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.55,
        Size                   = UDim2.new(1,0,1,0),
        ZIndex                 = 800,
    }, guiRoot)

    local box = U.New("Frame", {
        BackgroundColor3     = Color3.fromRGB(8, 18, 54),
        BackgroundTransparency = 0.04,
        Size                   = UDim2.new(0,320,0,160),
        Position               = UDim2.new(0.5,-160,0.5,-80),
        ZIndex                 = 801,
    }, overlay)
    U.Corner(box, 12)
    U.Stroke(box, Config.Theme.Accent, 1, 0.3)
    U.Shadow(box, 0.42)

    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Bold,
        Text                   = title,
        TextColor3             = Config.Theme.White,
        TextSize               = 17,
        TextXAlignment         = Enum.TextXAlignment.Center,
        Size                   = UDim2.new(1,-24,0,24),
        Position               = UDim2.new(0,12,0,18),
        ZIndex                 = 802,
    }, box)

    U.New("TextLabel", {
        BackgroundTransparency = 1,
        Font                   = Config.Font.Regular,
        Text                   = message,
        TextColor3             = Config.Theme.TextDim,
        TextSize               = 13,
        TextXAlignment         = Enum.TextXAlignment.Center,
        TextWrapped            = true,
        Size                   = UDim2.new(1,-24,0,50),
        Position               = UDim2.new(0,12,0,48),
        ZIndex                 = 802,
    }, box)

    -- Buttons row
    local function DialogBtn(txt, col, xpos, action)
        local b = U.New("TextButton", {
            BackgroundColor3     = col,
            BackgroundTransparency = 0.2,
            Text                   = txt,
            Font                   = Config.Font.Semi,
            TextColor3             = Config.Theme.White,
            TextSize               = 14,
            Size                   = UDim2.new(0,120,0,36),
            Position               = UDim2.new(0,xpos,1,-52),
            ZIndex                 = 802,
        }, box)
        U.Corner(b, 8)
        b.MouseEnter:Connect(function()  U.Tween(b, {BackgroundTransparency = 0}, 0.15) end)
        b.MouseLeave:Connect(function()  U.Tween(b, {BackgroundTransparency = 0.2}, 0.15) end)
        b.MouseButton1Click:Connect(function()
            U.Tween(overlay, {BackgroundTransparency = 1}, 0.2)
            U.Tween(box, {BackgroundTransparency = 1}, 0.2)
            task.delay(0.22, function() overlay:Destroy() end)
            if action then action() end
        end)
        return b
    end

    DialogBtn("Confirm", Config.Theme.Success, 20,  onYes)
    DialogBtn("Cancel",  Config.Theme.Error,   180, onNo)

    -- Animate in
    box.Size = UDim2.new(0,320,0,0)
    U.Tween(box, {Size = UDim2.new(0,320,0,160)}, 0.28, Enum.EasingStyle.Back)

    return overlay
end

-- ==========================================
-- ██ EXTENDED MODULE: CONTEXT MENU
-- ==========================================
local ContextMenu = {}

function ContextMenu.Show(guiRoot, options, x, y)
    local menu = U.New("Frame", {
        Name                 = "ContextMenu",
        BackgroundColor3     = Color3.fromRGB(7, 17, 50),
        BackgroundTransparency = 0.04,
        Size                   = UDim2.new(0,180,0,0),
        Position               = UDim2.new(0,x,0,y),
        ClipsDescendants       = true,
        ZIndex                 = 600,
    }, guiRoot)
    U.Corner(menu, 9)
    U.Stroke(menu, Config.Theme.Accent, 1, 0.3)
    U.Shadow(menu, 0.48)

    local ll = U.New("UIListLayout", {
        Padding   = UDim.new(0,2),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, menu)
    U.New("UIPadding", {
        PaddingTop    = UDim.new(0,4),
        PaddingBottom = UDim.new(0,4),
        PaddingLeft   = UDim.new(0,4),
        PaddingRight  = UDim.new(0,4),
    }, menu)

    local totalH = #options * 30 + 8
    for i, opt in ipairs(options) do
        if opt == "---" then
            U.New("Frame", {
                BackgroundColor3     = Config.Theme.Border,
                BackgroundTransparency = 0.6,
                Size                   = UDim2.new(1,0,0,1),
                LayoutOrder            = i,
                ZIndex                 = 601,
            }, menu)
        else
            local row = U.New("TextButton", {
                BackgroundColor3     = Config.Theme.BG_Light,
                BackgroundTransparency = 0.78,
                Text                   = opt.label or tostring(opt),
                Font                   = Config.Font.Regular,
                TextColor3             = Config.Theme.TextSub,
                TextSize               = 13,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Size                   = UDim2.new(1,0,0,28),
                LayoutOrder            = i,
                ZIndex                 = 601,
            }, menu)
            U.Corner(row, 5)
            U.New("UIPadding", {PaddingLeft = UDim.new(0,10)}, row)
            row.MouseEnter:Connect(function()  U.Tween(row, {BackgroundTransparency = 0.15, TextColor3 = Config.Theme.White}, 0.12) end)
            row.MouseLeave:Connect(function()  U.Tween(row, {BackgroundTransparency = 0.78, TextColor3 = Config.Theme.TextSub}, 0.12) end)
            row.MouseButton1Click:Connect(function()
                menu:Destroy()
                if opt.action then opt.action() end
            end)
        end
    end

    U.Tween(menu, {Size = UDim2.new(0,180,0,totalH)}, 0.22, Enum.EasingStyle.Back)

    -- Click outside to close
    U.Spawn(function()
        task.wait(0.1)
        local conn
        conn = UserInputService.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                task.wait(0.05)
                if menu and menu.Parent then
                    U.Tween(menu, {Size = UDim2.new(0,180,0,0)}, 0.15)
                    task.delay(0.16, function() pcall(function() menu:Destroy() end) end)
                end
                conn:Disconnect()
            end
        end)
    end)

    return menu
end

-- ==========================================
-- ██ EXTENDED MODULE: NUMBER FORMATTING
-- ==========================================
local NumFmt = {}

function NumFmt.Comma(n)
    local s = tostring(math.floor(n))
    local result = ""
    local len = #s
    for i = 1, len do
        if i > 1 and (len - i) % 3 == 2 then result = result .. "," end
        result = result .. s:sub(i, i)
    end
    return result
end

function NumFmt.Short(n)
    if n >= 1e9  then return string.format("%.1fB", n/1e9)
    elseif n >= 1e6  then return string.format("%.1fM", n/1e6)
    elseif n >= 1e3  then return string.format("%.1fK", n/1e3)
    else return tostring(n) end
end

function NumFmt.Hex(n)
    return string.format("0x%X", n)
end

function NumFmt.Pad(n, width, char)
    local s = tostring(n)
    char = char or "0"
    while #s < width do s = char .. s end
    return s
end

-- ==========================================
-- ██ EXTENDED MODULE: STRING UTILITIES
-- ==========================================
local StrUtil = {}

function StrUtil.Trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function StrUtil.Split(s, sep)
    local parts = {}
    for part in s:gmatch("[^" .. sep .. "]+") do
        table.insert(parts, part)
    end
    return parts
end

function StrUtil.StartsWith(s, prefix)
    return s:sub(1, #prefix) == prefix
end

function StrUtil.EndsWith(s, suffix)
    return s:sub(-#suffix) == suffix
end

function StrUtil.Contains(s, sub)
    return s:find(sub, 1, true) ~= nil
end

function StrUtil.Title(s)
    return s:gsub("(%a)([%w_']*)", function(a, b) return a:upper() .. b:lower() end)
end

function StrUtil.Repeat(s, n)
    local out = ""
    for _ = 1, n do out = out .. s end
    return out
end

-- ==========================================
-- ██ EXTENDED MODULE: TWEEN PRESETS
-- ==========================================
local TweenPresets = {}

TweenPresets.FastSnap  = TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
TweenPresets.Smooth    = TweenInfo.new(0.30, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
TweenPresets.Bouncy    = TweenInfo.new(0.40, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)
TweenPresets.Elastic   = TweenInfo.new(0.55, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
TweenPresets.Sine      = TweenInfo.new(0.50, Enum.EasingStyle.Sine,  Enum.EasingDirection.InOut)
TweenPresets.Linear    = TweenInfo.new(0.30, Enum.EasingStyle.Linear)
TweenPresets.SlowIn    = TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
TweenPresets.SlowOut   = TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

-- ==========================================
-- ██ EXTENDED MODULE: CONNECTION POOL
-- ==========================================
local ConnPool = {}
ConnPool._pool = {}

function ConnPool.Add(conn, tag)
    tag = tag or "default"
    if not ConnPool._pool[tag] then ConnPool._pool[tag] = {} end
    table.insert(ConnPool._pool[tag], conn)
end

function ConnPool.DisconnectAll(tag)
    if tag then
        for _, c in ipairs(ConnPool._pool[tag] or {}) do
            pcall(function() c:Disconnect() end)
        end
        ConnPool._pool[tag] = {}
    else
        for t, group in pairs(ConnPool._pool) do
            for _, c in ipairs(group) do
                pcall(function() c:Disconnect() end)
            end
            ConnPool._pool[t] = {}
        end
    end
end

-- ==========================================
-- ██ EXTENDED MODULE: RANDOM COLOR GEN
-- ==========================================
local ColorGen = {}

function ColorGen.FromHue(h, s, v)
    return Color3.fromHSV(h or math.random(), s or 0.75, v or 1)
end

function ColorGen.Pastel()
    return Color3.fromHSV(math.random(), 0.45, 1)
end

function ColorGen.Neon()
    return Color3.fromHSV(math.random(), 1, 1)
end

function ColorGen.Lerp(a, b, t)
    return a:Lerp(b, t)
end

function ColorGen.ToHex(c)
    return string.format("#%02X%02X%02X",
        math.floor(c.R*255),
        math.floor(c.G*255),
        math.floor(c.B*255)
    )
end

function ColorGen.FromHex(hex)
    hex = hex:gsub("#","")
    local r = tonumber(hex:sub(1,2),16)/255
    local g = tonumber(hex:sub(3,4),16)/255
    local b = tonumber(hex:sub(5,6),16)/255
    return Color3.new(r,g,b)
end

-- ==========================================
-- ██ EXTENDED MODULE: SOUND FEEDBACK
-- ==========================================
local SFX = {}
SFX._enabled = true

function SFX.Play(id, volume, pitch)
    if not SFX._enabled then return end
    local s = Instance.new("Sound")
    s.SoundId    = "rbxassetid://" .. tostring(id)
    s.Volume     = volume or 0.5
    s.PlaybackSpeed = pitch or 1
    s.Parent     = game:GetService("SoundService")
    s:Play()
    game:GetService("Debris"):AddItem(s, 5)
end

function SFX.Click()   SFX.Play(6042053626, 0.4, 1.0) end
function SFX.Toggle()  SFX.Play(4590662766, 0.5, 1.1) end
function SFX.Notify()  SFX.Play(3691944553, 0.6, 1.0) end
function SFX.Error()   SFX.Play(4982066294, 0.5, 0.9) end
function SFX.Success() SFX.Play(4590662766, 0.6, 1.3) end

-- ==========================================
-- ██ MODULE INIT LOG
-- ==========================================
Logger.Info("ParticleModule loaded")
Logger.Info("KeybindModule loaded")
Logger.Info("ConfigModule loaded")
Logger.Info("WatermarkModule loaded")
Logger.Info("TooltipModule loaded")
Logger.Info("AnimLib loaded")
Logger.Info("ThemeEngine loaded")
Logger.Info("Logger loaded")
Logger.Info("ESPEngine loaded")
Logger.Info("FOVModule loaded")
Logger.Info("RainbowBorder loaded")
Logger.Info("BlurCtrl loaded")
Logger.Info("ClockWidget loaded")
Logger.Info("StatsDisplay loaded")
Logger.Info("Dialog loaded")
Logger.Info("ContextMenu loaded")
Logger.Info("NumFmt loaded")
Logger.Info("StrUtil loaded")
Logger.Info("TweenPresets loaded")
Logger.Info("ConnPool loaded")
Logger.Info("ColorGen loaded")
Logger.Info("SFX loaded")
Logger.Success("All modules initialized — Swroyx Premium is operational")

-- ==========================================
-- ██ EXPORTED FRAMEWORK OBJECT
-- ==========================================
local Framework = {
    Particle    = ParticleModule,
    Keybind     = KeybindModule,
    Config      = ConfigModule,
    Watermark   = WatermarkModule,
    Tooltip     = TooltipModule,
    Anim        = AnimLib,
    Theme       = ThemeEngine,
    Logger      = Logger,
    ESP         = ESPEngine,
    FOV         = FOVModule,
    Rainbow     = RainbowBorder,
    Blur        = BlurCtrl,
    Clock       = ClockWidget,
    Stats       = StatsDisplay,
    Dialog      = Dialog,
    ContextMenu = ContextMenu,
    NumFmt      = NumFmt,
    StrUtil     = StrUtil,
    Tweens      = TweenPresets,
    ConnPool    = ConnPool,
    ColorGen    = ColorGen,
    SFX         = SFX,
    Notify      = Notify,
    Toggle      = ToggleUI,
    Utils       = U,
    Version     = Config.Ver,
    Author      = Config.Creator,
}

-- ==========================================
-- ██ GITHUB LOADER TEMPLATE
-- ==========================================
--[[
=== CÁCH SỬ DỤNG (USAGE) ===

Sau khi đẩy file này lên GitHub, gọi bằng:

    local Swroyx = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/YourUser/YourRepo/main/SwroyxPremium.lua"
    ))()

Tích hợp thêm tính năng vào Framework:
    Swroyx.Notify("Title", "Message", "success", 5)
    Swroyx.Toggle()
    Swroyx.ESP:Enable()
    Swroyx.Blur:EnableBlur()
    Swroyx.Logger:Info("Custom module ready")

═══════════════════════════════════════════
  Swroyx | Premium  —  By Minh Thật  ©2025
═══════════════════════════════════════════
--]]

return Framework
-- ╔═══════════════════════════════════════╗
-- ║  END OF SWROYX | PREMIUM FRAMEWORK   ║
-- ╚═══════════════════════════════════════╝
