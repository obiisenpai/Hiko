--[[
================================================================================
                    Swroyx | Premium UI Library
                          By Minh Thật
================================================================================
    Mô tả : Thư viện giao diện cao cấp dành cho Roblox với phong cách
            Glassmorphism + Industrial Sharp + Cinematic Intro.
    Phiên bản : 2.0.0
    Tác giả : Minh Thật
    Ngày phát hành : 2026
================================================================================
    Sử dụng :
        loadstring(game:HttpGet("YOUR_GITHUB_RAW_URL_HERE"))()

        local Window = Swroyx:CreateWindow({
            Name = "Swroyx | Premium",
            SubTitle = "By Minh Thật",
            AvatarId = 16060333448,
        })

        local Tab = Window:CreateTab("Main", "rbxassetid://0")
        local Section = Tab:CreateSection("General")

        Section:CreateButton({
            Name = "Click Me",
            Callback = function() print("Clicked!") end,
        })
================================================================================
--]]

--==============================================================================
--                              CORE SERVICES
--==============================================================================

local TweenService              = game:GetService("TweenService")
local UserInputService          = game:GetService("UserInputService")
local Players                   = game:GetService("Players")
local RunService                = game:GetService("RunService")
local CoreGui                   = game:GetService("CoreGui")
local HttpService               = game:GetService("HttpService")
local TextService               = game:GetService("TextService")
local GuiService                = game:GetService("GuiService")
local ContextActionService      = game:GetService("ContextActionService")
local Lighting                  = game:GetService("Lighting")
local Workspace                 = game:GetService("Workspace")
local StarterGui                = game:GetService("StarterGui")
local MarketplaceService        = game:GetService("MarketplaceService")
local Stats                     = game:GetService("Stats")

--==============================================================================
--                              GLOBAL VARIABLES
--==============================================================================

local LocalPlayer               = Players.LocalPlayer
local Mouse                     = LocalPlayer:GetMouse()
local Camera                    = Workspace.CurrentCamera
local PlayerGui                 = LocalPlayer:WaitForChild("PlayerGui")

--==============================================================================
--                              LIBRARY TABLE
--==============================================================================

local Swroyx = {
    Version             = "2.0.0",
    Author              = "Minh Thật",
    Title               = "Swroyx | Premium",
    Windows             = {},
    Notifications       = {},
    Connections         = {},
    Flags               = {},
    Themes              = {},
    Toggled             = true,
    NotificationCount   = 0,
    NotificationOffset  = 0,
    Loaded              = false,
}
Swroyx.__index = Swroyx

--==============================================================================
--                              THEME SYSTEM
--==============================================================================

local Theme = {
    -- Background Colors
    Background          = Color3.fromRGB(8, 12, 24),
    BackgroundSecondary = Color3.fromRGB(12, 18, 36),
    BackgroundTertiary  = Color3.fromRGB(16, 24, 48),
    BackgroundOverlay   = Color3.fromRGB(0, 0, 0),

    -- Glass Effect Colors
    GlassPrimary        = Color3.fromRGB(20, 30, 60),
    GlassSecondary      = Color3.fromRGB(15, 22, 45),
    GlassBorder         = Color3.fromRGB(60, 100, 180),

    -- Accent Colors
    Accent              = Color3.fromRGB(0, 90, 200),
    AccentLight         = Color3.fromRGB(64, 156, 255),
    AccentDark          = Color3.fromRGB(0, 60, 140),
    AccentGlow          = Color3.fromRGB(80, 180, 255),

    -- Deep Blue Vignette
    DeepBlue            = Color3.fromRGB(0, 30, 80),
    DeepBlueLight       = Color3.fromRGB(20, 60, 120),
    DeepBlueDark        = Color3.fromRGB(0, 15, 40),

    -- Light Blue (Toggle)
    LightBlue           = Color3.fromRGB(120, 180, 240),
    LightBlueHover      = Color3.fromRGB(150, 200, 250),
    LightBlueDim        = Color3.fromRGB(90, 140, 200),

    -- Text Colors
    Text                = Color3.fromRGB(255, 255, 255),
    TextPrimary         = Color3.fromRGB(240, 245, 255),
    TextSecondary       = Color3.fromRGB(180, 200, 230),
    TextTertiary        = Color3.fromRGB(120, 140, 180),
    TextDisabled        = Color3.fromRGB(80, 90, 110),

    -- Border Colors
    Border              = Color3.fromRGB(40, 60, 100),
    BorderActive        = Color3.fromRGB(80, 120, 200),
    BorderHover         = Color3.fromRGB(60, 90, 160),

    -- Status Colors
    Success             = Color3.fromRGB(80, 220, 140),
    SuccessDim          = Color3.fromRGB(40, 140, 90),
    Error               = Color3.fromRGB(255, 80, 100),
    ErrorDim            = Color3.fromRGB(180, 40, 60),
    Warning             = Color3.fromRGB(255, 180, 60),
    WarningDim          = Color3.fromRGB(200, 130, 30),
    Info                = Color3.fromRGB(80, 160, 255),
    InfoDim             = Color3.fromRGB(40, 100, 200),

    -- Component Specific
    ButtonNormal        = Color3.fromRGB(20, 30, 60),
    ButtonHover         = Color3.fromRGB(30, 50, 90),
    ButtonActive        = Color3.fromRGB(40, 70, 130),
    ToggleOff           = Color3.fromRGB(40, 50, 70),
    ToggleOn            = Color3.fromRGB(0, 90, 200),
    SliderTrack         = Color3.fromRGB(20, 30, 60),
    SliderFill          = Color3.fromRGB(64, 156, 255),
    SliderHandle        = Color3.fromRGB(255, 255, 255),
    DropdownClosed      = Color3.fromRGB(15, 22, 45),
    DropdownOpen        = Color3.fromRGB(25, 38, 75),
    DropdownItem        = Color3.fromRGB(20, 30, 60),
    DropdownItemHover   = Color3.fromRGB(30, 50, 90),
    InputBg             = Color3.fromRGB(10, 16, 32),
    InputBgFocus        = Color3.fromRGB(15, 24, 48),
    SectionBg           = Color3.fromRGB(10, 15, 30),
    TabBg               = Color3.fromRGB(8, 12, 24),
    TabActive           = Color3.fromRGB(0, 90, 200),
    HeaderBg            = Color3.fromRGB(5, 8, 18),
    SidebarBg           = Color3.fromRGB(6, 10, 22),

    -- Animation Settings
    TweenSpeed          = 0.25,
    TweenStyle          = Enum.EasingStyle.Quart,
    TweenDirection      = Enum.EasingDirection.Out,

    -- Font Settings
    Font                = Enum.Font.Gotham,
    FontBold            = Enum.Font.GothamBold,
    FontMedium          = Enum.Font.GothamMedium,
    FontSemibold        = Enum.Font.GothamSemibold,
    FontMono            = Enum.Font.RobotoMono,

    -- Sizes
    HeaderHeight        = 50,
    TabHeight           = 36,
    ButtonHeight        = 38,
    ToggleHeight        = 36,
    SliderHeight        = 50,
    DropdownHeight      = 38,
    InputHeight         = 38,
    SectionTitleHeight  = 32,
    SectionPadding      = 8,
    ComponentSpacing    = 6,
    EdgePadding         = 12,

    -- Corner Radii (Industrial Sharp = small or none)
    SharpRadius         = 0,
    SmallRadius         = 2,
    MediumRadius        = 4,
    LargeRadius         = 8,
    GlassRadius         = 6,
}

Swroyx.Theme = Theme

--==============================================================================
--                              UTILITY HELPERS
--==============================================================================

local Utility = {}

-- Convert RGB color to Color3
function Utility:RGB(r, g, b)
    return Color3.fromRGB(r or 0, g or 0, b or 0)
end

-- Lerp two colors
function Utility:LerpColor(c1, c2, alpha)
    return Color3.new(
        c1.R + (c2.R - c1.R) * alpha,
        c1.G + (c2.G - c1.G) * alpha,
        c1.B + (c2.B - c1.B) * alpha
    )
end

-- Lerp two numbers
function Utility:Lerp(a, b, alpha)
    return a + (b - a) * alpha
end

-- Clamp value
function Utility:Clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

-- Round value
function Utility:Round(value, decimals)
    local mult = 10 ^ (decimals or 0)
    return math.floor(value * mult + 0.5) / mult
end

-- Create a tween
function Utility:Tween(object, info, properties)
    local tweenInfo = info or TweenInfo.new(
        Theme.TweenSpeed,
        Theme.TweenStyle,
        Theme.TweenDirection
    )
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Quick tween with default settings
function Utility:QuickTween(object, properties, duration)
    local tweenInfo = TweenInfo.new(
        duration or Theme.TweenSpeed,
        Theme.TweenStyle,
        Theme.TweenDirection
    )
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Add stroke to instance
function Utility:AddStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.LineJoinMode = Enum.LineJoinMode.Round
    stroke.Parent = parent
    return stroke
end

-- Add corner radius
function Utility:AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or Theme.MediumRadius)
    corner.Parent = parent
    return corner
end

-- Add padding
function Utility:AddPadding(parent, top, bottom, left, right)
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, top or 0)
    padding.PaddingBottom = UDim.new(0, bottom or top or 0)
    padding.PaddingLeft = UDim.new(0, left or top or 0)
    padding.PaddingRight = UDim.new(0, right or left or top or 0)
    padding.Parent = parent
    return padding
end

-- Add gradient
function Utility:AddGradient(parent, colors, rotation, transparency)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 0
    if colors then
        gradient.Color = ColorSequence.new(colors)
    end
    if transparency then
        gradient.Transparency = transparency
    end
    gradient.Parent = parent
    return gradient
end

-- Add list layout
function Utility:AddListLayout(parent, padding, direction, alignment)
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, padding or Theme.ComponentSpacing)
    layout.FillDirection = direction or Enum.FillDirection.Vertical
    layout.HorizontalAlignment = alignment or Enum.HorizontalAlignment.Left
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = parent
    return layout
end

-- Add grid layout
function Utility:AddGridLayout(parent, cellSize, padding)
    local layout = Instance.new("UIGridLayout")
    layout.CellSize = cellSize or UDim2.new(0, 100, 0, 100)
    layout.CellPadding = padding or UDim2.new(0, 6, 0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = parent
    return layout
end

-- Add size constraint
function Utility:AddSizeConstraint(parent, min, max)
    local constraint = Instance.new("UISizeConstraint")
    if min then constraint.MinSize = min end
    if max then constraint.MaxSize = max end
    constraint.Parent = parent
    return constraint
end

-- Add aspect ratio constraint
function Utility:AddAspectRatio(parent, ratio)
    local constraint = Instance.new("UIAspectRatioConstraint")
    constraint.AspectRatio = ratio or 1
    constraint.Parent = parent
    return constraint
end

-- Make instance draggable
function Utility:MakeDraggable(frame, dragHandle)
    dragHandle = dragHandle or frame
    local dragging = false
    local dragStart, startPos
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Get text size
function Utility:GetTextSize(text, fontSize, font, bounds)
    return TextService:GetTextSize(
        text,
        fontSize,
        font or Theme.Font,
        bounds or Vector2.new(math.huge, math.huge)
    )
end

-- Generate random ID
function Utility:GenerateId()
    return HttpService:GenerateGUID(false):sub(1, 8)
end

-- Safe parent to CoreGui or PlayerGui
function Utility:SafeParent(gui)
    local success = pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(gui)
            gui.Parent = CoreGui
        elseif gethui then
            gui.Parent = gethui()
        elseif CoreGui:FindFirstChild("RobloxGui") then
            gui.Parent = CoreGui
        else
            gui.Parent = PlayerGui
        end
    end)
    if not success then
        gui.Parent = PlayerGui
    end
end

-- Add ripple effect to button
function Utility:AddRipple(button, color)
    button.ClipsDescendants = true
    
    button.MouseButton1Down:Connect(function(x, y)
        local ripple = Instance.new("Frame")
        ripple.Name = "Ripple"
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.BackgroundColor3 = color or Theme.AccentLight
        ripple.BackgroundTransparency = 0.6
        ripple.BorderSizePixel = 0
        ripple.Position = UDim2.new(
            0, x - button.AbsolutePosition.X,
            0, y - button.AbsolutePosition.Y
        )
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.Parent = button
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = ripple
        
        local maxSize = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
        
        local expandTween = TweenService:Create(
            ripple,
            TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, maxSize, 0, maxSize),
                BackgroundTransparency = 1,
            }
        )
        expandTween:Play()
        expandTween.Completed:Connect(function()
            ripple:Destroy()
        end)
    end)
end

-- Add hover effect
function Utility:AddHover(instance, enterColor, leaveColor, property, speed)
    property = property or "BackgroundColor3"
    speed = speed or 0.15
    
    instance.MouseEnter:Connect(function()
        Utility:QuickTween(instance, { [property] = enterColor }, speed)
    end)
    instance.MouseLeave:Connect(function()
        Utility:QuickTween(instance, { [property] = leaveColor }, speed)
    end)
end

-- Add glow effect using ImageLabel
function Utility:AddGlow(parent, color, intensity)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.Size = UDim2.new(1, 30, 1, 30)
    glow.ZIndex = parent.ZIndex - 1
    glow.Image = "rbxassetid://99153110613948"
    glow.ImageColor3 = color or Theme.Accent
    glow.ImageTransparency = 1 - (intensity or 0.5)
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(24, 24, 276, 276)
    glow.Parent = parent
    return glow
end

-- Get player avatar URL by user ID
function Utility:GetAvatar(userId, size)
    size = size or "420x420"
    local success, content = pcall(function()
        return Players:GetUserThumbnailAsync(
            userId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size420x420
        )
    end)
    if success then
        return content
    else
        return "rbxassetid://99153110613948"
    end
end

-- Format number to string
function Utility:FormatNumber(n)
    local formatted = tostring(math.floor(n))
    while true do
        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return formatted
end

-- Deep copy table
function Utility:DeepCopy(t)
    if type(t) ~= "table" then return t end
    local copy = {}
    for k, v in pairs(t) do
        copy[k] = type(v) == "table" and Utility:DeepCopy(v) or v
    end
    return copy
end

Swroyx.Utility = Utility

--==============================================================================
--                          CINEMATIC INTRO ANIMATION
--==============================================================================

function Swroyx:CreateIntro()
    -- Create the intro ScreenGui
    local IntroGui = Instance.new("ScreenGui")
    IntroGui.Name = "Swroyx_Intro_" .. Utility:GenerateId()
    IntroGui.IgnoreGuiInset = true
    IntroGui.ResetOnSpawn = false
    IntroGui.DisplayOrder = 999999
    IntroGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Utility:SafeParent(IntroGui)
    
    -- Black backdrop (solid base for the cinematic feel)
    local Backdrop = Instance.new("Frame")
    Backdrop.Name = "Backdrop"
    Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Backdrop.BackgroundTransparency = 1
    Backdrop.BorderSizePixel = 0
    Backdrop.Size = UDim2.new(1, 0, 1, 0)
    Backdrop.ZIndex = 1
    Backdrop.Parent = IntroGui
    
    -- Deep blue vignette (radial gradient effect simulated by image)
    local Vignette = Instance.new("ImageLabel")
    Vignette.Name = "Vignette"
    Vignette.BackgroundTransparency = 1
    Vignette.BorderSizePixel = 0
    Vignette.Size = UDim2.new(1, 0, 1, 0)
    Vignette.ZIndex = 2
    Vignette.Image = "rbxassetid://99153110613948"
    Vignette.ImageColor3 = Theme.DeepBlue
    Vignette.ImageTransparency = 1
    Vignette.ScaleType = Enum.ScaleType.Slice
    Vignette.SliceCenter = Rect.new(150, 150, 150, 150)
    Vignette.Parent = IntroGui
    
    -- Secondary vignette layer for depth
    local VignetteSecondary = Instance.new("ImageLabel")
    VignetteSecondary.Name = "VignetteSecondary"
    VignetteSecondary.BackgroundTransparency = 1
    VignetteSecondary.BorderSizePixel = 0
    VignetteSecondary.Size = UDim2.new(1.2, 0, 1.2, 0)
    VignetteSecondary.AnchorPoint = Vector2.new(0.5, 0.5)
    VignetteSecondary.Position = UDim2.new(0.5, 0, 0.5, 0)
    VignetteSecondary.ZIndex = 3
    VignetteSecondary.Image = "rbxassetid://99153110613948"
    VignetteSecondary.ImageColor3 = Theme.DeepBlueDark
    VignetteSecondary.ImageTransparency = 1
    VignetteSecondary.ScaleType = Enum.ScaleType.Slice
    VignetteSecondary.SliceCenter = Rect.new(120, 120, 120, 120)
    VignetteSecondary.Parent = IntroGui
    
    -- Center container for the radiant heart
    local Center = Instance.new("Frame")
    Center.Name = "Center"
    Center.AnchorPoint = Vector2.new(0.5, 0.5)
    Center.BackgroundTransparency = 1
    Center.BorderSizePixel = 0
    Center.Position = UDim2.new(0.5, 0, 0.5, 0)
    Center.Size = UDim2.new(0, 600, 0, 200)
    Center.ZIndex = 5
    Center.Parent = IntroGui
    
    -- Outer glow halo
    local Halo = Instance.new("ImageLabel")
    Halo.Name = "Halo"
    Halo.AnchorPoint = Vector2.new(0.5, 0.5)
    Halo.BackgroundTransparency = 1
    Halo.Position = UDim2.new(0.5, 0, 0.5, 0)
    Halo.Size = UDim2.new(0, 0, 0, 0)
    Halo.ZIndex = 4
    Halo.Image = "rbxassetid://99153110613948"
    Halo.ImageColor3 = Theme.AccentGlow
    Halo.ImageTransparency = 1
    Halo.ScaleType = Enum.ScaleType.Slice
    Halo.SliceCenter = Rect.new(120, 120, 120, 120)
    Halo.Parent = Center
    
    -- Secondary halo for richer glow
    local HaloOuter = Instance.new("ImageLabel")
    HaloOuter.Name = "HaloOuter"
    HaloOuter.AnchorPoint = Vector2.new(0.5, 0.5)
    HaloOuter.BackgroundTransparency = 1
    HaloOuter.Position = UDim2.new(0.5, 0, 0.5, 0)
    HaloOuter.Size = UDim2.new(0, 0, 0, 0)
    HaloOuter.ZIndex = 3
    HaloOuter.Image = "rbxassetid://99153110613948"
    HaloOuter.ImageColor3 = Theme.DeepBlueLight
    HaloOuter.ImageTransparency = 1
    HaloOuter.ScaleType = Enum.ScaleType.Slice
    HaloOuter.SliceCenter = Rect.new(120, 120, 120, 120)
    HaloOuter.Parent = Center
    
    -- Main title text "Swroyx"
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.5, 0, 0.5, 0)
    Title.Size = UDim2.new(1, 0, 0, 80)
    Title.ZIndex = 6
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Swroyx"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 64
    Title.TextTransparency = 1
    Title.TextStrokeTransparency = 1
    Title.TextStrokeColor3 = Theme.AccentGlow
    Title.Parent = Center
    
    -- Title gradient for radiant white effect
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 240, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
    })
    TitleGradient.Rotation = 90
    TitleGradient.Parent = Title
    
    -- Subtitle "Premium"
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Position = UDim2.new(0.5, 0, 0.5, 50)
    Subtitle.Size = UDim2.new(1, 0, 0, 24)
    Subtitle.ZIndex = 6
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Text = "P R E M I U M"
    Subtitle.TextColor3 = Theme.AccentLight
    Subtitle.TextSize = 14
    Subtitle.TextTransparency = 1
    Subtitle.Parent = Center
    
    -- Loading bar container
    local LoadingBar = Instance.new("Frame")
    LoadingBar.Name = "LoadingBar"
    LoadingBar.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingBar.BackgroundColor3 = Theme.GlassPrimary
    LoadingBar.BackgroundTransparency = 1
    LoadingBar.BorderSizePixel = 0
    LoadingBar.Position = UDim2.new(0.5, 0, 0.5, 90)
    LoadingBar.Size = UDim2.new(0, 200, 0, 2)
    LoadingBar.ZIndex = 6
    LoadingBar.Parent = Center
    
    -- Loading bar fill
    local LoadingFill = Instance.new("Frame")
    LoadingFill.Name = "Fill"
    LoadingFill.BackgroundColor3 = Theme.AccentLight
    LoadingFill.BorderSizePixel = 0
    LoadingFill.Size = UDim2.new(0, 0, 1, 0)
    LoadingFill.ZIndex = 7
    LoadingFill.Parent = LoadingBar
    
    -- Particle container for ambient particles
    local Particles = Instance.new("Frame")
    Particles.Name = "Particles"
    Particles.BackgroundTransparency = 1
    Particles.BorderSizePixel = 0
    Particles.Size = UDim2.new(1, 0, 1, 0)
    Particles.ZIndex = 4
    Particles.Parent = IntroGui
    
    -- Spawn ambient particles
    local function SpawnParticle()
        local particle = Instance.new("Frame")
        particle.BackgroundColor3 = Theme.AccentLight
        particle.BackgroundTransparency = 0.3
        particle.BorderSizePixel = 0
        particle.AnchorPoint = Vector2.new(0.5, 0.5)
        local startX = math.random(0, 100) / 100
        local startY = math.random(0, 100) / 100
        particle.Position = UDim2.new(startX, 0, startY, 0)
        local pSize = math.random(2, 5)
        particle.Size = UDim2.new(0, pSize, 0, pSize)
        particle.ZIndex = 4
        particle.Parent = Particles
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        local targetX = startX + (math.random(-30, 30) / 100)
        local targetY = startY - (math.random(20, 60) / 100)
        
        local fadeTween = TweenService:Create(
            particle,
            TweenInfo.new(math.random(2, 4), Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(targetX, 0, targetY, 0),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 0),
            }
        )
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            particle:Destroy()
        end)
    end
    
    -- Particle spawning loop
    local particleConnection
    particleConnection = RunService.Heartbeat:Connect(function()
        if math.random() < 0.15 then
            SpawnParticle()
        end
    end)
    
    -- ====== INTRO ANIMATION SEQUENCE ======
    -- Phase 1 (0.0s - 0.6s): Backdrop fade in
    Utility:Tween(Backdrop, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.2,
    })
    
    -- Phase 2 (0.2s - 1.2s): Vignette appears
    task.delay(0.2, function()
        Utility:Tween(Vignette, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ImageTransparency = 0.1,
        })
        Utility:Tween(VignetteSecondary, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ImageTransparency = 0.3,
        })
    end)
    
    -- Phase 3 (0.8s - 1.6s): Halo appears
    task.delay(0.8, function()
        Utility:Tween(Halo, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 800, 0, 800),
            ImageTransparency = 0.5,
        })
        Utility:Tween(HaloOuter, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 1200, 0, 1200),
            ImageTransparency = 0.7,
        })
    end)
    
    -- Phase 4 (1.0s - 1.8s): Title appears with neon glow
    task.delay(1.0, function()
        Utility:Tween(Title, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            TextStrokeTransparency = 0.5,
        })
    end)
    
    -- Phase 5 (1.4s - 2.0s): Subtitle appears
    task.delay(1.4, function()
        Utility:Tween(Subtitle, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            TextTransparency = 0.2,
        })
    end)
    
    -- Phase 6 (1.6s - 1.8s): Loading bar appears
    task.delay(1.6, function()
        Utility:Tween(LoadingBar, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.5,
        })
    end)
    
    -- Phase 7 (1.8s - 4.0s): Loading bar fills
    task.delay(1.8, function()
        Utility:Tween(LoadingFill, TweenInfo.new(2.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0),
        })
    end)
    
    -- Phase 8 (3.5s - 4.0s): Title pulse for emphasis
    task.delay(3.5, function()
        Utility:Tween(Halo, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 1000, 0, 1000),
            ImageTransparency = 0.3,
        })
    end)
    
    -- Phase 9 (4.0s - 5.0s): Everything fades out gracefully
    task.delay(4.0, function()
        Utility:Tween(Title, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
        })
        Utility:Tween(Subtitle, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            TextTransparency = 1,
        })
        Utility:Tween(LoadingBar, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            BackgroundTransparency = 1,
        })
        Utility:Tween(LoadingFill, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            BackgroundTransparency = 1,
        })
        Utility:Tween(Halo, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 1500, 0, 1500),
            ImageTransparency = 1,
        })
        Utility:Tween(HaloOuter, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 1800, 0, 1800),
            ImageTransparency = 1,
        })
        Utility:Tween(Vignette, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            ImageTransparency = 1,
        })
        Utility:Tween(VignetteSecondary, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            ImageTransparency = 1,
        })
        Utility:Tween(Backdrop, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            BackgroundTransparency = 1,
        })
    end)
    
    -- Phase 10 (5.0s): Cleanup
    task.delay(5.0, function()
        if particleConnection then
            particleConnection:Disconnect()
        end
        IntroGui:Destroy()
    end)
    
    -- Wait for the intro to complete before continuing
    task.wait(5.0)
end


--==============================================================================
--                          NOTIFICATION SYSTEM
--==============================================================================

-- Initialize notification container
function Swroyx:InitNotificationSystem()
    if Swroyx.NotificationGui then return end
    
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "Swroyx_Notifications_" .. Utility:GenerateId()
    NotificationGui.IgnoreGuiInset = true
    NotificationGui.ResetOnSpawn = false
    NotificationGui.DisplayOrder = 99999
    NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Utility:SafeParent(NotificationGui)
    
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.AnchorPoint = Vector2.new(1, 0)
    Container.BackgroundTransparency = 1
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(1, -20, 0, 20)
    Container.Size = UDim2.new(0, 320, 1, -40)
    Container.Parent = NotificationGui
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    Layout.VerticalAlignment = Enum.VerticalAlignment.Top
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Container
    
    Swroyx.NotificationGui = NotificationGui
    Swroyx.NotificationContainer = Container
end

-- Create a notification
function Swroyx:Notify(options)
    options = options or {}
    options.Title = options.Title or "Swroyx"
    options.Content = options.Content or "[ Thành công ]"
    options.Duration = options.Duration or 5
    options.Type = options.Type or "Success"
    
    Swroyx:InitNotificationSystem()
    Swroyx.NotificationCount = Swroyx.NotificationCount + 1
    
    -- Determine icon and accent color based on type
    local accentColor = Theme.Success
    local typeIcon = "✓"
    if options.Type == "Error" then
        accentColor = Theme.Error
        typeIcon = "✕"
    elseif options.Type == "Warning" then
        accentColor = Theme.Warning
        typeIcon = "!"
    elseif options.Type == "Info" then
        accentColor = Theme.Info
        typeIcon = "i"
    elseif options.Type == "Premium" then
        accentColor = Theme.AccentLight
        typeIcon = "★"
    end
    
    -- Notification frame (Industrial Sharp - sharp corners)
    local Notification = Instance.new("Frame")
    Notification.Name = "Notification_" .. Swroyx.NotificationCount
    Notification.BackgroundColor3 = Theme.GlassPrimary
    Notification.BackgroundTransparency = 0.05
    Notification.BorderSizePixel = 0
    Notification.Size = UDim2.new(1, 0, 0, 80)
    Notification.AnchorPoint = Vector2.new(1, 0)
    Notification.Position = UDim2.new(1, 350, 0, 0)
    Notification.LayoutOrder = -Swroyx.NotificationCount
    Notification.ClipsDescendants = false
    Notification.Parent = Swroyx.NotificationContainer
    
    -- Sharp stroke border (Industrial style - no rounded corners)
    Utility:AddStroke(Notification, accentColor, 1, 0.3)
    
    -- Background gradient for depth
    local BgGradient = Instance.new("UIGradient")
    BgGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.GlassSecondary),
        ColorSequenceKeypoint.new(1, Theme.GlassPrimary),
    })
    BgGradient.Rotation = 135
    BgGradient.Parent = Notification
    
    -- Left accent stripe
    local AccentStripe = Instance.new("Frame")
    AccentStripe.Name = "AccentStripe"
    AccentStripe.BackgroundColor3 = accentColor
    AccentStripe.BorderSizePixel = 0
    AccentStripe.Size = UDim2.new(0, 3, 1, 0)
    AccentStripe.Parent = Notification
    
    -- Glow on accent stripe
    local StripeGlow = Instance.new("UIGradient")
    StripeGlow.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, accentColor),
        ColorSequenceKeypoint.new(0.5, Theme.AccentGlow),
        ColorSequenceKeypoint.new(1, accentColor),
    })
    StripeGlow.Rotation = 90
    StripeGlow.Parent = AccentStripe
    
    -- Type icon container
    local IconContainer = Instance.new("Frame")
    IconContainer.Name = "IconContainer"
    IconContainer.BackgroundColor3 = accentColor
    IconContainer.BackgroundTransparency = 0.85
    IconContainer.BorderSizePixel = 0
    IconContainer.Position = UDim2.new(0, 12, 0.5, -16)
    IconContainer.Size = UDim2.new(0, 32, 0, 32)
    IconContainer.Parent = Notification
    
    Utility:AddStroke(IconContainer, accentColor, 1, 0.4)
    
    -- Type icon text
    local IconText = Instance.new("TextLabel")
    IconText.BackgroundTransparency = 1
    IconText.Size = UDim2.new(1, 0, 1, 0)
    IconText.Font = Enum.Font.GothamBold
    IconText.Text = typeIcon
    IconText.TextColor3 = accentColor
    IconText.TextSize = 16
    IconText.Parent = IconContainer
    
    -- Title text
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 56, 0, 12)
    TitleLabel.Size = UDim2.new(1, -68, 0, 18)
    TitleLabel.Font = Theme.FontSemibold
    TitleLabel.Text = options.Title
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    TitleLabel.Parent = Notification
    
    -- Content text
    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Name = "Content"
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.Position = UDim2.new(0, 56, 0, 32)
    ContentLabel.Size = UDim2.new(1, -68, 0, 36)
    ContentLabel.Font = Theme.Font
    ContentLabel.Text = options.Content
    ContentLabel.TextColor3 = Theme.TextSecondary
    ContentLabel.TextSize = 12
    ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
    ContentLabel.TextWrapped = true
    ContentLabel.Parent = Notification
    
    -- Progress bar (countdown timer indicator)
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.BackgroundColor3 = accentColor
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Position = UDim2.new(0, 0, 1, -2)
    ProgressBar.Size = UDim2.new(1, 0, 0, 2)
    ProgressBar.Parent = Notification
    
    local ProgressGradient = Instance.new("UIGradient")
    ProgressGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, accentColor),
        ColorSequenceKeypoint.new(1, Theme.AccentGlow),
    })
    ProgressGradient.Parent = ProgressBar
    
    -- Slide in animation
    Utility:Tween(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, 0, 0, 0),
    })
    
    -- Progress bar countdown
    Utility:Tween(ProgressBar, TweenInfo.new(options.Duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 2),
    })
    
    -- Auto dismiss after duration
    task.delay(options.Duration, function()
        Utility:Tween(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 350, 0, 0),
            BackgroundTransparency = 1,
        })
        task.wait(0.3)
        Notification:Destroy()
    end)
    
    table.insert(Swroyx.Notifications, Notification)
    return Notification
end


--==============================================================================
--                          MAIN WINDOW CREATION
--==============================================================================

function Swroyx:CreateWindow(options)
    options = options or {}
    options.Name = options.Name or "Swroyx | Premium"
    options.SubTitle = options.SubTitle or "By Minh Thật"
    options.AvatarId = options.AvatarId or 16060333448
    options.Size = options.Size or UDim2.new(0, 620, 0, 420)
    options.MinSize = options.MinSize or Vector2.new(500, 350)
    options.ConfigurationSaving = options.ConfigurationSaving or false
    options.KeySystem = options.KeySystem or false
    
    -- Show intro if not already shown
    if not Swroyx.Loaded then
        Swroyx:CreateIntro()
        Swroyx.Loaded = true
    end
    
    local Window = setmetatable({
        Tabs = {},
        ActiveTab = nil,
        Visible = true,
        Minimized = false,
        Options = options,
    }, Swroyx)
    
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Swroyx_Window_" .. Utility:GenerateId()
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 9999
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Utility:SafeParent(ScreenGui)
    Window.ScreenGui = ScreenGui
    
    -- Background blur effect (Glassmorphism)
    local BlurEffect = Instance.new("BlurEffect")
    BlurEffect.Size = 0
    BlurEffect.Parent = Lighting
    Window.BlurEffect = BlurEffect
    
    Utility:Tween(BlurEffect, TweenInfo.new(0.5), { Size = 8 })
    
    -- Main window frame (Glassmorphism container)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    Window.MainFrame = MainFrame
    
    -- Glass corner radius
    Utility:AddCorner(MainFrame, Theme.GlassRadius)
    
    -- Animated entrance
    Utility:Tween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = options.Size,
    })
    
    -- Glass effect via gradient overlay
    local GlassGradient = Instance.new("UIGradient")
    GlassGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.GlassPrimary),
        ColorSequenceKeypoint.new(0.5, Theme.GlassSecondary),
        ColorSequenceKeypoint.new(1, Theme.Background),
    })
    GlassGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.05),
        NumberSequenceKeypoint.new(1, 0.15),
    })
    GlassGradient.Rotation = 135
    GlassGradient.Parent = MainFrame
    
    -- Subtle border
    Utility:AddStroke(MainFrame, Theme.GlassBorder, 1, 0.5)
    
    -- Drop shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = -1
    Shadow.Image = "rbxassetid://99153110613948"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(24, 24, 276, 276)
    Shadow.Parent = MainFrame
    
    -- ============== HEADER SECTION ==============
    
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.BackgroundColor3 = Theme.HeaderBg
    Header.BackgroundTransparency = 0.2
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, Theme.HeaderHeight)
    Header.ZIndex = 2
    Header.Parent = MainFrame
    Window.Header = Header
    
    -- Header gradient
    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.HeaderBg),
        ColorSequenceKeypoint.new(1, Theme.BackgroundSecondary),
    })
    HeaderGradient.Rotation = 90
    HeaderGradient.Parent = Header
    
    -- Header bottom divider
    local HeaderDivider = Instance.new("Frame")
    HeaderDivider.Name = "Divider"
    HeaderDivider.BackgroundColor3 = Theme.GlassBorder
    HeaderDivider.BackgroundTransparency = 0.5
    HeaderDivider.BorderSizePixel = 0
    HeaderDivider.Position = UDim2.new(0, 0, 1, -1)
    HeaderDivider.Size = UDim2.new(1, 0, 0, 1)
    HeaderDivider.Parent = Header
    
    -- Logo / Title container
    local TitleContainer = Instance.new("Frame")
    TitleContainer.BackgroundTransparency = 1
    TitleContainer.Position = UDim2.new(0, 16, 0, 0)
    TitleContainer.Size = UDim2.new(0, 300, 1, 0)
    TitleContainer.Parent = Header
    
    -- Main title text "Swroyx | Premium"
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "Title"
    TitleText.BackgroundTransparency = 1
    TitleText.Position = UDim2.new(0, 0, 0, 8)
    TitleText.Size = UDim2.new(1, 0, 0, 20)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Text = options.Name
    TitleText.TextColor3 = Theme.Text
    TitleText.TextSize = 16
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleContainer
    
    -- Title gradient for premium effect
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.Text),
        ColorSequenceKeypoint.new(0.5, Theme.AccentLight),
        ColorSequenceKeypoint.new(1, Theme.Text),
    })
    TitleGradient.Parent = TitleText
    
    -- Subtitle "By Minh Thật"
    local SubtitleText = Instance.new("TextLabel")
    SubtitleText.Name = "Subtitle"
    SubtitleText.BackgroundTransparency = 1
    SubtitleText.Position = UDim2.new(0, 0, 0, 28)
    SubtitleText.Size = UDim2.new(1, 0, 0, 14)
    SubtitleText.Font = Enum.Font.Gotham
    SubtitleText.Text = options.SubTitle
    SubtitleText.TextColor3 = Theme.TextTertiary
    SubtitleText.TextSize = 11
    SubtitleText.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleText.Parent = TitleContainer
    
    -- ============== AVATAR PROFILE (Bottom-right) ==============
    
    local AvatarContainer = Instance.new("Frame")
    AvatarContainer.Name = "AvatarContainer"
    AvatarContainer.AnchorPoint = Vector2.new(1, 1)
    AvatarContainer.BackgroundColor3 = Theme.GlassPrimary
    AvatarContainer.BackgroundTransparency = 0.2
    AvatarContainer.BorderSizePixel = 0
    AvatarContainer.Position = UDim2.new(1, -10, 1, -10)
    AvatarContainer.Size = UDim2.new(0, 50, 0, 50)
    AvatarContainer.ZIndex = 5
    AvatarContainer.Parent = MainFrame
    
    Utility:AddCorner(AvatarContainer, 25)
    Utility:AddStroke(AvatarContainer, Theme.AccentLight, 2, 0.3)
    
    -- Avatar image
    local AvatarImage = Instance.new("ImageLabel")
    AvatarImage.Name = "Avatar"
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Size = UDim2.new(1, -4, 1, -4)
    AvatarImage.Position = UDim2.new(0, 2, 0, 2)
    AvatarImage.Image = Utility:GetAvatar(options.AvatarId)
    AvatarImage.ScaleType = Enum.ScaleType.Crop
    AvatarImage.ZIndex = 6
    AvatarImage.Parent = AvatarContainer
    
    Utility:AddCorner(AvatarImage, 23)
    
    -- Avatar glow
    local AvatarGlow = Instance.new("ImageLabel")
    AvatarGlow.Name = "Glow"
    AvatarGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    AvatarGlow.BackgroundTransparency = 1
    AvatarGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    AvatarGlow.Size = UDim2.new(1, 20, 1, 20)
    AvatarGlow.ZIndex = 4
    AvatarGlow.Image = "rbxassetid://99153110613948"
    AvatarGlow.ImageColor3 = Theme.AccentLight
    AvatarGlow.ImageTransparency = 0.7
    AvatarGlow.ScaleType = Enum.ScaleType.Slice
    AvatarGlow.SliceCenter = Rect.new(24, 24, 276, 276)
    AvatarGlow.Parent = AvatarContainer
    
    -- Premium badge on avatar
    local PremiumBadge = Instance.new("Frame")
    PremiumBadge.Name = "PremiumBadge"
    PremiumBadge.AnchorPoint = Vector2.new(1, 1)
    PremiumBadge.BackgroundColor3 = Theme.AccentLight
    PremiumBadge.BorderSizePixel = 0
    PremiumBadge.Position = UDim2.new(1, 2, 1, 2)
    PremiumBadge.Size = UDim2.new(0, 16, 0, 16)
    PremiumBadge.ZIndex = 7
    PremiumBadge.Parent = AvatarContainer
    
    Utility:AddCorner(PremiumBadge, 8)
    Utility:AddStroke(PremiumBadge, Theme.Background, 1, 0)
    
    local PremiumIcon = Instance.new("TextLabel")
    PremiumIcon.BackgroundTransparency = 1
    PremiumIcon.Size = UDim2.new(1, 0, 1, 0)
    PremiumIcon.Font = Enum.Font.GothamBold
    PremiumIcon.Text = "★"
    PremiumIcon.TextColor3 = Theme.Background
    PremiumIcon.TextSize = 10
    PremiumIcon.ZIndex = 8
    PremiumIcon.Parent = PremiumBadge
    
    -- ============== CLOSE BUTTON ==============
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.AnchorPoint = Vector2.new(1, 0)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.BackgroundTransparency = 0.8
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -10, 0, 10)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Theme.Text
    CloseButton.TextSize = 14
    CloseButton.AutoButtonColor = false
    CloseButton.Parent = Header
    
    Utility:AddCorner(CloseButton, 4)
    Utility:AddStroke(CloseButton, Theme.Error, 1, 0.5)
    
    Utility:AddHover(CloseButton, Theme.Error, Color3.fromRGB(255, 80, 100), "BackgroundColor3")
    
    CloseButton.MouseButton1Click:Connect(function()
        Utility:Tween(MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
        })
        Utility:Tween(BlurEffect, TweenInfo.new(0.3), { Size = 0 })
        task.wait(0.4)
        ScreenGui:Destroy()
        BlurEffect:Destroy()
    end)
    
    -- ============== MINIMIZE BUTTON ==============
    
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.AnchorPoint = Vector2.new(1, 0)
    MinimizeButton.BackgroundColor3 = Theme.Warning
    MinimizeButton.BackgroundTransparency = 0.8
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Position = UDim2.new(1, -46, 0, 10)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Theme.Text
    MinimizeButton.TextSize = 16
    MinimizeButton.AutoButtonColor = false
    MinimizeButton.Parent = Header
    
    Utility:AddCorner(MinimizeButton, 4)
    Utility:AddStroke(MinimizeButton, Theme.Warning, 1, 0.5)
    
    Utility:AddHover(MinimizeButton, Theme.Warning, Color3.fromRGB(255, 180, 60), "BackgroundColor3")
    
    -- ============== MAIN BODY ==============
    
    local Body = Instance.new("Frame")
    Body.Name = "Body"
    Body.BackgroundTransparency = 1
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0, 0, 0, Theme.HeaderHeight)
    Body.Size = UDim2.new(1, 0, 1, -Theme.HeaderHeight)
    Body.Parent = MainFrame
    Window.Body = Body
    
    -- ============== SIDEBAR (Tab buttons) ==============
    
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.BackgroundColor3 = Theme.SidebarBg
    Sidebar.BackgroundTransparency = 0.3
    Sidebar.BorderSizePixel = 0
    Sidebar.Size = UDim2.new(0, 150, 1, 0)
    Sidebar.Parent = Body
    Window.Sidebar = Sidebar
    
    -- Sidebar gradient
    local SidebarGradient = Instance.new("UIGradient")
    SidebarGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.SidebarBg),
        ColorSequenceKeypoint.new(1, Theme.Background),
    })
    SidebarGradient.Rotation = 0
    SidebarGradient.Parent = Sidebar
    
    -- Sidebar right border
    local SidebarBorder = Instance.new("Frame")
    SidebarBorder.BackgroundColor3 = Theme.GlassBorder
    SidebarBorder.BackgroundTransparency = 0.6
    SidebarBorder.BorderSizePixel = 0
    SidebarBorder.Position = UDim2.new(1, -1, 0, 0)
    SidebarBorder.Size = UDim2.new(0, 1, 1, 0)
    SidebarBorder.Parent = Sidebar
    
    -- Tab list scroll frame
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.BackgroundTransparency = 1
    TabList.BorderSizePixel = 0
    TabList.Position = UDim2.new(0, 8, 0, 8)
    TabList.Size = UDim2.new(1, -16, 1, -70)
    TabList.ScrollBarThickness = 2
    TabList.ScrollBarImageColor3 = Theme.AccentLight
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabList.Parent = Sidebar
    Window.TabList = TabList
    
    Utility:AddListLayout(TabList, 4)
    
    -- Sidebar footer with version info
    local SidebarFooter = Instance.new("Frame")
    SidebarFooter.Name = "Footer"
    SidebarFooter.BackgroundTransparency = 1
    SidebarFooter.AnchorPoint = Vector2.new(0, 1)
    SidebarFooter.Position = UDim2.new(0, 8, 1, -8)
    SidebarFooter.Size = UDim2.new(1, -16, 0, 50)
    SidebarFooter.Parent = Sidebar
    
    local VersionLabel = Instance.new("TextLabel")
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Size = UDim2.new(1, 0, 0, 14)
    VersionLabel.Font = Theme.Font
    VersionLabel.Text = "v" .. Swroyx.Version
    VersionLabel.TextColor3 = Theme.TextTertiary
    VersionLabel.TextSize = 10
    VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
    VersionLabel.Parent = SidebarFooter
    
    local AuthorLabel = Instance.new("TextLabel")
    AuthorLabel.BackgroundTransparency = 1
    AuthorLabel.Position = UDim2.new(0, 0, 0, 14)
    AuthorLabel.Size = UDim2.new(1, 0, 0, 14)
    AuthorLabel.Font = Theme.Font
    AuthorLabel.Text = "© " .. Swroyx.Author
    AuthorLabel.TextColor3 = Theme.TextTertiary
    AuthorLabel.TextSize = 10
    AuthorLabel.TextXAlignment = Enum.TextXAlignment.Left
    AuthorLabel.Parent = SidebarFooter
    
    -- ============== CONTENT AREA ==============
    
    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.Position = UDim2.new(0, 150, 0, 0)
    Content.Size = UDim2.new(1, -150, 1, -65)
    Content.Parent = Body
    Window.Content = Content
    
    -- Make window draggable from header
    Utility:MakeDraggable(MainFrame, Header)
    
    -- ============== HIDE/SHOW TOGGLE BUTTON ==============
    -- Light blue rectangular button at bottom-left of screen
    
    local ToggleGui = Instance.new("ScreenGui")
    ToggleGui.Name = "Swroyx_Toggle_" .. Utility:GenerateId()
    ToggleGui.IgnoreGuiInset = true
    ToggleGui.ResetOnSpawn = false
    ToggleGui.DisplayOrder = 9998
    Utility:SafeParent(ToggleGui)
    Window.ToggleGui = ToggleGui
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.AnchorPoint = Vector2.new(0, 1)
    ToggleButton.BackgroundColor3 = Theme.LightBlue
    ToggleButton.BackgroundTransparency = 0.1
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(0, 20, 1, -20)
    ToggleButton.Size = UDim2.new(0, 80, 0, 30)
    ToggleButton.Font = Theme.FontSemibold
    ToggleButton.Text = "[ Hide ]"
    ToggleButton.TextColor3 = Theme.Background
    ToggleButton.TextSize = 12
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ToggleGui
    
    Utility:AddCorner(ToggleButton, 4)
    Utility:AddStroke(ToggleButton, Theme.LightBlueDim, 1, 0.3)
    
    -- Toggle button glow
    local ToggleGlow = Instance.new("ImageLabel")
    ToggleGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    ToggleGlow.BackgroundTransparency = 1
    ToggleGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    ToggleGlow.Size = UDim2.new(1, 20, 1, 20)
    ToggleGlow.ZIndex = 0
    ToggleGlow.Image = "rbxassetid://99153110613948"
    ToggleGlow.ImageColor3 = Theme.LightBlue
    ToggleGlow.ImageTransparency = 0.7
    ToggleGlow.ScaleType = Enum.ScaleType.Slice
    ToggleGlow.SliceCenter = Rect.new(24, 24, 276, 276)
    ToggleGlow.Parent = ToggleButton
    
    -- Hover effect on toggle button
    ToggleButton.MouseEnter:Connect(function()
        Utility:QuickTween(ToggleButton, { 
            BackgroundColor3 = Theme.LightBlueHover,
            Size = UDim2.new(0, 90, 0, 32),
        }, 0.2)
        Utility:QuickTween(ToggleGlow, { ImageTransparency = 0.4 }, 0.2)
    end)
    
    ToggleButton.MouseLeave:Connect(function()
        Utility:QuickTween(ToggleButton, { 
            BackgroundColor3 = Theme.LightBlue,
            Size = UDim2.new(0, 80, 0, 30),
        }, 0.2)
        Utility:QuickTween(ToggleGlow, { ImageTransparency = 0.7 }, 0.2)
    end)
    
    -- Toggle visibility function
    local function ToggleVisibility()
        Window.Visible = not Window.Visible
        if Window.Visible then
            ToggleButton.Text = "[ Hide ]"
            ScreenGui.Enabled = true
            Utility:Tween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = options.Size,
            })
            Utility:Tween(BlurEffect, TweenInfo.new(0.4), { Size = 8 })
        else
            ToggleButton.Text = "[ Show ]"
            Utility:Tween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
            })
            Utility:Tween(BlurEffect, TweenInfo.new(0.3), { Size = 0 })
            task.wait(0.35)
            if not Window.Visible then
                ScreenGui.Enabled = false
            end
        end
    end
    
    ToggleButton.MouseButton1Click:Connect(ToggleVisibility)
    Utility:AddRipple(ToggleButton, Theme.AccentGlow)
    
    -- Keyboard shortcut: RightShift to toggle
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            ToggleVisibility()
        end
    end)
    
    Window.ToggleButton = ToggleButton
    Window.ToggleVisibility = ToggleVisibility
    
    -- Minimize button click
    MinimizeButton.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            Utility:Tween(MainFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0, options.Size.X.Offset, 0, Theme.HeaderHeight),
            })
            MinimizeButton.Text = "+"
        else
            Utility:Tween(MainFrame, TweenInfo.new(0.3), {
                Size = options.Size,
            })
            MinimizeButton.Text = "−"
        end
    end)
    
    -- Show welcome notification
    task.delay(0.5, function()
        Swroyx:Notify({
            Title = "Swroyx | Premium",
            Content = "[ Thành công ] Đã khởi động giao diện",
            Type = "Premium",
            Duration = 5,
        })
    end)
    
    -- =================== TAB CREATION ===================
    
    function Window:CreateTab(name, icon)
        local Tab = {
            Name = name,
            Icon = icon,
            Sections = {},
            Window = Window,
        }
        
        -- Tab button in sidebar
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "Tab_" .. name
        TabButton.BackgroundColor3 = Theme.TabBg
        TabButton.BackgroundTransparency = 0.5
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, Theme.TabHeight)
        TabButton.Font = Theme.FontMedium
        TabButton.Text = ""
        TabButton.AutoButtonColor = false
        TabButton.Parent = TabList
        
        Utility:AddCorner(TabButton, 4)
        local TabStroke = Utility:AddStroke(TabButton, Theme.Border, 1, 0.7)
        
        -- Tab icon
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "Icon"
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 8, 0.5, -8)
        TabIcon.Size = UDim2.new(0, 16, 0, 16)
        TabIcon.Image = icon or "rbxassetid://7733715400"
        TabIcon.ImageColor3 = Theme.TextSecondary
        TabIcon.Parent = TabButton
        
        -- Tab text
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Name = "Label"
        TabLabel.BackgroundTransparency = 1
        TabLabel.Position = UDim2.new(0, 32, 0, 0)
        TabLabel.Size = UDim2.new(1, -40, 1, 0)
        TabLabel.Font = Theme.FontMedium
        TabLabel.Text = name
        TabLabel.TextColor3 = Theme.TextSecondary
        TabLabel.TextSize = 12
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Parent = TabButton
        
        -- Active indicator
        local ActiveIndicator = Instance.new("Frame")
        ActiveIndicator.Name = "Indicator"
        ActiveIndicator.BackgroundColor3 = Theme.AccentLight
        ActiveIndicator.BorderSizePixel = 0
        ActiveIndicator.Position = UDim2.new(0, 0, 0.5, -6)
        ActiveIndicator.Size = UDim2.new(0, 0, 0, 12)
        ActiveIndicator.Parent = TabButton
        
        Utility:AddCorner(ActiveIndicator, 2)
        
        -- Tab content frame
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "Content_" .. name
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Position = UDim2.new(0, 12, 0, 12)
        TabContent.Size = UDim2.new(1, -24, 1, -24)
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = Theme.AccentLight
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContent.Visible = false
        TabContent.Parent = Content
        
        local ContentLayout = Utility:AddListLayout(TabContent, 8)
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Indicator = ActiveIndicator
        Tab.Label = TabLabel
        Tab.Icon = TabIcon
        
        -- Tab selection logic
        local function SelectTab()
            for _, otherTab in pairs(Window.Tabs) do
                if otherTab ~= Tab then
                    otherTab.Content.Visible = false
                    Utility:QuickTween(otherTab.Button, { 
                        BackgroundColor3 = Theme.TabBg,
                        BackgroundTransparency = 0.5,
                    })
                    Utility:QuickTween(otherTab.Indicator, {
                        Size = UDim2.new(0, 0, 0, 12),
                    })
                    Utility:QuickTween(otherTab.Label, {
                        TextColor3 = Theme.TextSecondary,
                    })
                    Utility:QuickTween(otherTab.Icon, {
                        ImageColor3 = Theme.TextSecondary,
                    })
                end
            end
            
            TabContent.Visible = true
            Window.ActiveTab = Tab
            
            Utility:QuickTween(TabButton, { 
                BackgroundColor3 = Theme.TabActive,
                BackgroundTransparency = 0.7,
            })
            Utility:QuickTween(ActiveIndicator, {
                Size = UDim2.new(0, 3, 0, 20),
            })
            Utility:QuickTween(TabLabel, {
                TextColor3 = Theme.Text,
            })
            Utility:QuickTween(TabIcon, {
                ImageColor3 = Theme.AccentLight,
            })
        end
        
        TabButton.MouseEnter:Connect(function()
            if Window.ActiveTab ~= Tab then
                Utility:QuickTween(TabButton, {
                    BackgroundTransparency = 0.3,
                })
                Utility:QuickTween(TabLabel, {
                    TextColor3 = Theme.Text,
                })
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.ActiveTab ~= Tab then
                Utility:QuickTween(TabButton, {
                    BackgroundTransparency = 0.5,
                })
                Utility:QuickTween(TabLabel, {
                    TextColor3 = Theme.TextSecondary,
                })
            end
        end)
        
        TabButton.MouseButton1Click:Connect(SelectTab)
        
        Tab.Select = SelectTab
        
        -- Auto-select first tab
        if #Window.Tabs == 0 then
            task.spawn(SelectTab)
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- =================== SECTION CREATION ===================
        
        function Tab:CreateSection(sectionName)
            local Section = {
                Name = sectionName,
                Components = {},
                Tab = Tab,
            }
            
            -- Section container
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = "Section_" .. sectionName
            SectionFrame.BackgroundColor3 = Theme.SectionBg
            SectionFrame.BackgroundTransparency = 0.3
            SectionFrame.BorderSizePixel = 0
            SectionFrame.Size = UDim2.new(1, 0, 0, 40)
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            SectionFrame.Parent = TabContent
            
            Utility:AddCorner(SectionFrame, 4)
            Utility:AddStroke(SectionFrame, Theme.Border, 1, 0.5)
            Utility:AddPadding(SectionFrame, 12, 12, 12, 12)
            
            -- Section gradient
            local SectionGradient = Instance.new("UIGradient")
            SectionGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Theme.SectionBg),
                ColorSequenceKeypoint.new(1, Theme.BackgroundSecondary),
            })
            SectionGradient.Rotation = 135
            SectionGradient.Parent = SectionFrame
            
            -- Section title
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(1, 0, 0, 18)
            SectionTitle.Font = Theme.FontBold
            SectionTitle.Text = sectionName
            SectionTitle.TextColor3 = Theme.AccentLight
            SectionTitle.TextSize = 13
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.LayoutOrder = 0
            SectionTitle.Parent = SectionFrame
            
            -- Section divider
            local SectionDivider = Instance.new("Frame")
            SectionDivider.BackgroundColor3 = Theme.AccentLight
            SectionDivider.BackgroundTransparency = 0.7
            SectionDivider.BorderSizePixel = 0
            SectionDivider.Size = UDim2.new(1, 0, 0, 1)
            SectionDivider.LayoutOrder = 1
            SectionDivider.Parent = SectionFrame
            
            -- Components container
            local ComponentsContainer = Instance.new("Frame")
            ComponentsContainer.Name = "Components"
            ComponentsContainer.BackgroundTransparency = 1
            ComponentsContainer.Size = UDim2.new(1, 0, 0, 0)
            ComponentsContainer.AutomaticSize = Enum.AutomaticSize.Y
            ComponentsContainer.LayoutOrder = 2
            ComponentsContainer.Parent = SectionFrame
            
            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.Padding = UDim.new(0, 6)
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Parent = ComponentsContainer
            
            local SectionPadding = Instance.new("UIPadding")
            SectionPadding.PaddingTop = UDim.new(0, 8)
            SectionPadding.Parent = ComponentsContainer
            
            local FrameLayout = Instance.new("UIListLayout")
            FrameLayout.Padding = UDim.new(0, 8)
            FrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
            FrameLayout.Parent = SectionFrame
            
            Section.Frame = SectionFrame
            Section.ComponentsContainer = ComponentsContainer
            
            -- ============ BUTTON COMPONENT ============
            
            function Section:CreateButton(opts)
                opts = opts or {}
                opts.Name = opts.Name or "Button"
                opts.Description = opts.Description or nil
                opts.Callback = opts.Callback or function() end
                
                local Button = {}
                
                local ButtonFrame = Instance.new("TextButton")
                ButtonFrame.Name = "Button_" .. opts.Name
                ButtonFrame.BackgroundColor3 = Theme.ButtonNormal
                ButtonFrame.BackgroundTransparency = 0.2
                ButtonFrame.BorderSizePixel = 0
                ButtonFrame.Size = UDim2.new(1, 0, 0, Theme.ButtonHeight)
                ButtonFrame.Font = Theme.FontMedium
                ButtonFrame.Text = ""
                ButtonFrame.AutoButtonColor = false
                ButtonFrame.Parent = ComponentsContainer
                
                Utility:AddCorner(ButtonFrame, 4)
                local ButtonStroke = Utility:AddStroke(ButtonFrame, Theme.Border, 1, 0.4)
                
                local ButtonGradient = Instance.new("UIGradient")
                ButtonGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Theme.ButtonNormal),
                    ColorSequenceKeypoint.new(1, Theme.BackgroundSecondary),
                })
                ButtonGradient.Rotation = 90
                ButtonGradient.Parent = ButtonFrame
                
                local ButtonLabel = Instance.new("TextLabel")
                ButtonLabel.BackgroundTransparency = 1
                ButtonLabel.Position = UDim2.new(0, 12, 0, 0)
                ButtonLabel.Size = UDim2.new(1, -24, 1, 0)
                ButtonLabel.Font = Theme.FontMedium
                ButtonLabel.Text = opts.Name
                ButtonLabel.TextColor3 = Theme.Text
                ButtonLabel.TextSize = 12
                ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
                ButtonLabel.Parent = ButtonFrame
                
                local ButtonArrow = Instance.new("TextLabel")
                ButtonArrow.BackgroundTransparency = 1
                ButtonArrow.AnchorPoint = Vector2.new(1, 0.5)
                ButtonArrow.Position = UDim2.new(1, -10, 0.5, 0)
                ButtonArrow.Size = UDim2.new(0, 16, 0, 16)
                ButtonArrow.Font = Theme.FontBold
                ButtonArrow.Text = "›"
                ButtonArrow.TextColor3 = Theme.AccentLight
                ButtonArrow.TextSize = 16
                ButtonArrow.Parent = ButtonFrame
                
                ButtonFrame.MouseEnter:Connect(function()
                    Utility:QuickTween(ButtonFrame, { 
                        BackgroundColor3 = Theme.ButtonHover,
                        BackgroundTransparency = 0.1,
                    })
                    Utility:QuickTween(ButtonStroke, { 
                        Color = Theme.AccentLight,
                        Transparency = 0.2,
                    })
                    Utility:QuickTween(ButtonArrow, { 
                        Position = UDim2.new(1, -6, 0.5, 0),
                    })
                end)
                
                ButtonFrame.MouseLeave:Connect(function()
                    Utility:QuickTween(ButtonFrame, { 
                        BackgroundColor3 = Theme.ButtonNormal,
                        BackgroundTransparency = 0.2,
                    })
                    Utility:QuickTween(ButtonStroke, { 
                        Color = Theme.Border,
                        Transparency = 0.4,
                    })
                    Utility:QuickTween(ButtonArrow, { 
                        Position = UDim2.new(1, -10, 0.5, 0),
                    })
                end)
                
                ButtonFrame.MouseButton1Down:Connect(function()
                    Utility:QuickTween(ButtonFrame, { 
                        BackgroundColor3 = Theme.ButtonActive,
                    }, 0.1)
                end)
                
                ButtonFrame.MouseButton1Up:Connect(function()
                    Utility:QuickTween(ButtonFrame, { 
                        BackgroundColor3 = Theme.ButtonHover,
                    }, 0.1)
                end)
                
                Utility:AddRipple(ButtonFrame, Theme.AccentLight)
                
                ButtonFrame.MouseButton1Click:Connect(function()
                    local success, err = pcall(opts.Callback)
                    if not success then
                        Swroyx:Notify({
                            Title = "Error",
                            Content = "Button error: " .. tostring(err),
                            Type = "Error",
                        })
                    end
                end)
                
                Button.Frame = ButtonFrame
                Button.SetText = function(_, text)
                    ButtonLabel.Text = text
                end
                
                table.insert(Section.Components, Button)
                return Button
            end
            
            -- ============ TOGGLE COMPONENT ============
            
            function Section:CreateToggle(opts)
                opts = opts or {}
                opts.Name = opts.Name or "Toggle"
                opts.Default = opts.Default or false
                opts.Flag = opts.Flag or opts.Name
                opts.Callback = opts.Callback or function() end
                
                local Toggle = { Value = opts.Default }
                
                local ToggleFrame = Instance.new("TextButton")
                ToggleFrame.Name = "Toggle_" .. opts.Name
                ToggleFrame.BackgroundColor3 = Theme.ButtonNormal
                ToggleFrame.BackgroundTransparency = 0.2
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Size = UDim2.new(1, 0, 0, Theme.ToggleHeight)
                ToggleFrame.Text = ""
                ToggleFrame.AutoButtonColor = false
                ToggleFrame.Parent = ComponentsContainer
                
                Utility:AddCorner(ToggleFrame, 4)
                local ToggleStroke = Utility:AddStroke(ToggleFrame, Theme.Border, 1, 0.4)
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
                ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
                ToggleLabel.Font = Theme.FontMedium
                ToggleLabel.Text = opts.Name
                ToggleLabel.TextColor3 = Theme.Text
                ToggleLabel.TextSize = 12
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.Parent = ToggleFrame
                
                -- Toggle switch container
                local SwitchContainer = Instance.new("Frame")
                SwitchContainer.AnchorPoint = Vector2.new(1, 0.5)
                SwitchContainer.BackgroundColor3 = Theme.ToggleOff
                SwitchContainer.BorderSizePixel = 0
                SwitchContainer.Position = UDim2.new(1, -10, 0.5, 0)
                SwitchContainer.Size = UDim2.new(0, 36, 0, 18)
                SwitchContainer.Parent = ToggleFrame
                
                Utility:AddCorner(SwitchContainer, 9)
                local SwitchStroke = Utility:AddStroke(SwitchContainer, Theme.Border, 1, 0.5)
                
                -- Toggle knob
                local ToggleKnob = Instance.new("Frame")
                ToggleKnob.AnchorPoint = Vector2.new(0, 0.5)
                ToggleKnob.BackgroundColor3 = Theme.Text
                ToggleKnob.BorderSizePixel = 0
                ToggleKnob.Position = UDim2.new(0, 2, 0.5, 0)
                ToggleKnob.Size = UDim2.new(0, 14, 0, 14)
                ToggleKnob.Parent = SwitchContainer
                
                Utility:AddCorner(ToggleKnob, 7)
                
                local function UpdateToggle()
                    if Toggle.Value then
                        Utility:QuickTween(SwitchContainer, { 
                            BackgroundColor3 = Theme.ToggleOn,
                        })
                        Utility:QuickTween(SwitchStroke, { 
                            Color = Theme.AccentLight,
                            Transparency = 0.2,
                        })
                        Utility:QuickTween(ToggleKnob, { 
                            Position = UDim2.new(1, -16, 0.5, 0),
                        })
                    else
                        Utility:QuickTween(SwitchContainer, { 
                            BackgroundColor3 = Theme.ToggleOff,
                        })
                        Utility:QuickTween(SwitchStroke, { 
                            Color = Theme.Border,
                            Transparency = 0.5,
                        })
                        Utility:QuickTween(ToggleKnob, { 
                            Position = UDim2.new(0, 2, 0.5, 0),
                        })
                    end
                end
                
                UpdateToggle()
                
                ToggleFrame.MouseEnter:Connect(function()
                    Utility:QuickTween(ToggleFrame, { BackgroundTransparency = 0.1 })
                    Utility:QuickTween(ToggleStroke, { 
                        Color = Theme.AccentLight,
                        Transparency = 0.3,
                    })
                end)
                
                ToggleFrame.MouseLeave:Connect(function()
                    Utility:QuickTween(ToggleFrame, { BackgroundTransparency = 0.2 })
                    Utility:QuickTween(ToggleStroke, { 
                        Color = Theme.Border,
                        Transparency = 0.4,
                    })
                end)
                
                ToggleFrame.MouseButton1Click:Connect(function()
                    Toggle.Value = not Toggle.Value
                    UpdateToggle()
                    Swroyx.Flags[opts.Flag] = Toggle.Value
                    pcall(opts.Callback, Toggle.Value)
                end)
                
                Toggle.Set = function(_, value)
                    Toggle.Value = value
                    UpdateToggle()
                    Swroyx.Flags[opts.Flag] = Toggle.Value
                    pcall(opts.Callback, Toggle.Value)
                end
                
                Toggle.Get = function() return Toggle.Value end
                
                Swroyx.Flags[opts.Flag] = Toggle.Value
                table.insert(Section.Components, Toggle)
                return Toggle
            end
            
            -- ============ SLIDER COMPONENT ============
            
            function Section:CreateSlider(opts)
                opts = opts or {}
                opts.Name = opts.Name or "Slider"
                opts.Min = opts.Min or 0
                opts.Max = opts.Max or 100
                opts.Default = opts.Default or opts.Min
                opts.Increment = opts.Increment or 1
                opts.Suffix = opts.Suffix or ""
                opts.Flag = opts.Flag or opts.Name
                opts.Callback = opts.Callback or function() end
                
                local Slider = { Value = opts.Default }
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Name = "Slider_" .. opts.Name
                SliderFrame.BackgroundColor3 = Theme.ButtonNormal
                SliderFrame.BackgroundTransparency = 0.2
                SliderFrame.BorderSizePixel = 0
                SliderFrame.Size = UDim2.new(1, 0, 0, Theme.SliderHeight)
                SliderFrame.Parent = ComponentsContainer
                
                Utility:AddCorner(SliderFrame, 4)
                local SliderStroke = Utility:AddStroke(SliderFrame, Theme.Border, 1, 0.4)
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, 12, 0, 6)
                SliderLabel.Size = UDim2.new(1, -100, 0, 14)
                SliderLabel.Font = Theme.FontMedium
                SliderLabel.Text = opts.Name
                SliderLabel.TextColor3 = Theme.Text
                SliderLabel.TextSize = 12
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.Parent = SliderFrame
                
                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.AnchorPoint = Vector2.new(1, 0)
                ValueLabel.BackgroundColor3 = Theme.GlassPrimary
                ValueLabel.BackgroundTransparency = 0.2
                ValueLabel.BorderSizePixel = 0
                ValueLabel.Position = UDim2.new(1, -10, 0, 6)
                ValueLabel.Size = UDim2.new(0, 60, 0, 16)
                ValueLabel.Font = Theme.FontMono
                ValueLabel.Text = tostring(opts.Default) .. opts.Suffix
                ValueLabel.TextColor3 = Theme.AccentLight
                ValueLabel.TextSize = 11
                ValueLabel.Parent = SliderFrame
                
                Utility:AddCorner(ValueLabel, 3)
                Utility:AddStroke(ValueLabel, Theme.AccentDark, 1, 0.5)
                
                -- Slider track
                local SliderTrack = Instance.new("Frame")
                SliderTrack.BackgroundColor3 = Theme.SliderTrack
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Position = UDim2.new(0, 12, 1, -16)
                SliderTrack.Size = UDim2.new(1, -24, 0, 4)
                SliderTrack.Parent = SliderFrame
                
                Utility:AddCorner(SliderTrack, 2)
                
                -- Slider fill
                local SliderFill = Instance.new("Frame")
                SliderFill.BackgroundColor3 = Theme.SliderFill
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new(0, 0, 1, 0)
                SliderFill.Parent = SliderTrack
                
                Utility:AddCorner(SliderFill, 2)
                
                local FillGradient = Instance.new("UIGradient")
                FillGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Theme.Accent),
                    ColorSequenceKeypoint.new(1, Theme.AccentLight),
                })
                FillGradient.Parent = SliderFill
                
                -- Slider handle
                local SliderHandle = Instance.new("Frame")
                SliderHandle.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderHandle.BackgroundColor3 = Theme.SliderHandle
                SliderHandle.BorderSizePixel = 0
                SliderHandle.Position = UDim2.new(0, 0, 0.5, 0)
                SliderHandle.Size = UDim2.new(0, 12, 0, 12)
                SliderHandle.Parent = SliderTrack
                
                Utility:AddCorner(SliderHandle, 6)
                Utility:AddStroke(SliderHandle, Theme.AccentLight, 2, 0.2)
                
                local function UpdateSlider(value)
                    value = math.clamp(value, opts.Min, opts.Max)
                    value = math.floor((value - opts.Min) / opts.Increment + 0.5) * opts.Increment + opts.Min
                    Slider.Value = value
                    
                    local percent = (value - opts.Min) / (opts.Max - opts.Min)
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderHandle.Position = UDim2.new(percent, 0, 0.5, 0)
                    ValueLabel.Text = tostring(value) .. opts.Suffix
                    
                    Swroyx.Flags[opts.Flag] = value
                    pcall(opts.Callback, value)
                end
                
                UpdateSlider(opts.Default)
                
                local dragging = false
                
                SliderTrack.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 
                        or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end)
                
                SliderHandle.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 
                        or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 
                        or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
                        or input.UserInputType == Enum.UserInputType.Touch) then
                        local pos = input.Position.X - SliderTrack.AbsolutePosition.X
                        local percent = math.clamp(pos / SliderTrack.AbsoluteSize.X, 0, 1)
                        local value = opts.Min + (opts.Max - opts.Min) * percent
                        UpdateSlider(value)
                    end
                end)
                
                Slider.Set = function(_, value) UpdateSlider(value) end
                Slider.Get = function() return Slider.Value end
                
                Swroyx.Flags[opts.Flag] = Slider.Value
                table.insert(Section.Components, Slider)
                return Slider
            end
            
            -- ============ DROPDOWN COMPONENT ============
            
            function Section:CreateDropdown(opts)
                opts = opts or {}
                opts.Name = opts.Name or "Dropdown"
                opts.Options = opts.Options or {}
                opts.Default = opts.Default or opts.Options[1] or "Select..."
                opts.Flag = opts.Flag or opts.Name
                opts.Callback = opts.Callback or function() end
                opts.MultiSelect = opts.MultiSelect or false
                
                local Dropdown = { Value = opts.Default, Open = false }
                
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Name = "Dropdown_" .. opts.Name
                DropdownFrame.BackgroundTransparency = 1
                DropdownFrame.Size = UDim2.new(1, 0, 0, Theme.DropdownHeight)
                DropdownFrame.ClipsDescendants = false
                DropdownFrame.Parent = ComponentsContainer
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.BackgroundColor3 = Theme.DropdownClosed
                DropdownButton.BackgroundTransparency = 0.2
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Size = UDim2.new(1, 0, 0, Theme.DropdownHeight)
                DropdownButton.Text = ""
                DropdownButton.AutoButtonColor = false
                DropdownButton.Parent = DropdownFrame
                
                Utility:AddCorner(DropdownButton, 4)
                local DropdownStroke = Utility:AddStroke(DropdownButton, Theme.Border, 1, 0.4)
                
                local DropdownLabel = Instance.new("TextLabel")
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Position = UDim2.new(0, 12, 0, 4)
                DropdownLabel.Size = UDim2.new(1, -40, 0, 12)
                DropdownLabel.Font = Theme.Font
                DropdownLabel.Text = opts.Name
                DropdownLabel.TextColor3 = Theme.TextTertiary
                DropdownLabel.TextSize = 10
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                DropdownLabel.Parent = DropdownButton
                
                local DropdownValue = Instance.new("TextLabel")
                DropdownValue.BackgroundTransparency = 1
                DropdownValue.Position = UDim2.new(0, 12, 0, 16)
                DropdownValue.Size = UDim2.new(1, -40, 0, 16)
                DropdownValue.Font = Theme.FontMedium
                DropdownValue.Text = tostring(opts.Default)
                DropdownValue.TextColor3 = Theme.Text
                DropdownValue.TextSize = 12
                DropdownValue.TextXAlignment = Enum.TextXAlignment.Left
                DropdownValue.Parent = DropdownButton
                
                local DropdownArrow = Instance.new("TextLabel")
                DropdownArrow.AnchorPoint = Vector2.new(1, 0.5)
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(1, -10, 0.5, 0)
                DropdownArrow.Size = UDim2.new(0, 16, 0, 16)
                DropdownArrow.Font = Theme.FontBold
                DropdownArrow.Text = "▼"
                DropdownArrow.TextColor3 = Theme.AccentLight
                DropdownArrow.TextSize = 10
                DropdownArrow.Parent = DropdownButton
                
                -- Dropdown options container
                local OptionsContainer = Instance.new("Frame")
                OptionsContainer.BackgroundColor3 = Theme.DropdownOpen
                OptionsContainer.BackgroundTransparency = 0.1
                OptionsContainer.BorderSizePixel = 0
                OptionsContainer.Position = UDim2.new(0, 0, 1, 4)
                OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
                OptionsContainer.ClipsDescendants = true
                OptionsContainer.Visible = false
                OptionsContainer.ZIndex = 10
                OptionsContainer.Parent = DropdownFrame
                
                Utility:AddCorner(OptionsContainer, 4)
                Utility:AddStroke(OptionsContainer, Theme.AccentDark, 1, 0.4)
                
                local OptionsList = Instance.new("ScrollingFrame")
                OptionsList.BackgroundTransparency = 1
                OptionsList.BorderSizePixel = 0
                OptionsList.Size = UDim2.new(1, 0, 1, 0)
                OptionsList.ScrollBarThickness = 2
                OptionsList.ScrollBarImageColor3 = Theme.AccentLight
                OptionsList.CanvasSize = UDim2.new(0, 0, 0, 0)
                OptionsList.AutomaticCanvasSize = Enum.AutomaticSize.Y
                OptionsList.ZIndex = 11
                OptionsList.Parent = OptionsContainer
                
                Utility:AddListLayout(OptionsList, 2)
                Utility:AddPadding(OptionsList, 4, 4, 4, 4)
                
                local function CreateOption(optionName)
                    local Option = Instance.new("TextButton")
                    Option.BackgroundColor3 = Theme.DropdownItem
                    Option.BackgroundTransparency = 0.3
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(1, 0, 0, 26)
                    Option.Font = Theme.Font
                    Option.Text = "  " .. optionName
                    Option.TextColor3 = Theme.TextSecondary
                    Option.TextSize = 11
                    Option.TextXAlignment = Enum.TextXAlignment.Left
                    Option.AutoButtonColor = false
                    Option.ZIndex = 12
                    Option.Parent = OptionsList
                    
                    Utility:AddCorner(Option, 3)
                    
                    Option.MouseEnter:Connect(function()
                        Utility:QuickTween(Option, { 
                            BackgroundColor3 = Theme.DropdownItemHover,
                            BackgroundTransparency = 0.1,
                        })
                        Utility:QuickTween(Option, { TextColor3 = Theme.Text })
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        Utility:QuickTween(Option, { 
                            BackgroundColor3 = Theme.DropdownItem,
                            BackgroundTransparency = 0.3,
                        })
                        Utility:QuickTween(Option, { TextColor3 = Theme.TextSecondary })
                    end)
                    
                    Option.MouseButton1Click:Connect(function()
                        Dropdown.Value = optionName
                        DropdownValue.Text = optionName
                        Swroyx.Flags[opts.Flag] = optionName
                        pcall(opts.Callback, optionName)
                        
                        -- Close dropdown
                        Dropdown.Open = false
                        Utility:QuickTween(OptionsContainer, {
                            Size = UDim2.new(1, 0, 0, 0),
                        })
                        Utility:QuickTween(DropdownArrow, { Rotation = 0 })
                        task.wait(0.25)
                        OptionsContainer.Visible = false
                    end)
                end
                
                for _, opt in ipairs(opts.Options) do
                    CreateOption(opt)
                end
                
                local function ToggleDropdown()
                    Dropdown.Open = not Dropdown.Open
                    if Dropdown.Open then
                        OptionsContainer.Visible = true
                        local height = math.min(#opts.Options * 28 + 8, 150)
                        Utility:QuickTween(OptionsContainer, {
                            Size = UDim2.new(1, 0, 0, height),
                        })
                        Utility:QuickTween(DropdownArrow, { Rotation = 180 })
                        Utility:QuickTween(DropdownStroke, { 
                            Color = Theme.AccentLight,
                            Transparency = 0.2,
                        })
                    else
                        Utility:QuickTween(OptionsContainer, {
                            Size = UDim2.new(1, 0, 0, 0),
                        })
                        Utility:QuickTween(DropdownArrow, { Rotation = 0 })
                        Utility:QuickTween(DropdownStroke, { 
                            Color = Theme.Border,
                            Transparency = 0.4,
                        })
                        task.wait(0.25)
                        OptionsContainer.Visible = false
                    end
                end
                
                DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
                
                DropdownButton.MouseEnter:Connect(function()
                    if not Dropdown.Open then
                        Utility:QuickTween(DropdownButton, { BackgroundTransparency = 0.1 })
                    end
                end)
                
                DropdownButton.MouseLeave:Connect(function()
                    if not Dropdown.Open then
                        Utility:QuickTween(DropdownButton, { BackgroundTransparency = 0.2 })
                    end
                end)
                
                Dropdown.Set = function(_, value)
                    Dropdown.Value = value
                    DropdownValue.Text = tostring(value)
                    Swroyx.Flags[opts.Flag] = value
                    pcall(opts.Callback, value)
                end
                
                Dropdown.Get = function() return Dropdown.Value end
                
                Dropdown.Refresh = function(_, newOptions)
                    opts.Options = newOptions
                    for _, child in pairs(OptionsList:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    for _, opt in ipairs(newOptions) do
                        CreateOption(opt)
                    end
                end
                
                Swroyx.Flags[opts.Flag] = Dropdown.Value
                table.insert(Section.Components, Dropdown)
                return Dropdown
            end
            
            -- ============ TEXTBOX / INPUT COMPONENT ============
            
            function Section:CreateInput(opts)
                opts = opts or {}
                opts.Name = opts.Name or "Input"
                opts.Placeholder = opts.Placeholder or "Enter text..."
                opts.Default = opts.Default or ""
                opts.Flag = opts.Flag or opts.Name
                opts.Callback = opts.Callback or function() end
                opts.ClearOnFocus = opts.ClearOnFocus or false
                
                local Input = { Value = opts.Default }
                
                local InputFrame = Instance.new("Frame")
                InputFrame.Name = "Input_" .. opts.Name
                InputFrame.BackgroundColor3 = Theme.InputBg
                InputFrame.BackgroundTransparency = 0.2
                InputFrame.BorderSizePixel = 0
                InputFrame.Size = UDim2.new(1, 0, 0, Theme.InputHeight)
                InputFrame.Parent = ComponentsContainer
                
                Utility:AddCorner(InputFrame, 4)
                local InputStroke = Utility:AddStroke(InputFrame, Theme.Border, 1, 0.4)
                
                local InputLabel = Instance.new("TextLabel")
                InputLabel.BackgroundTransparency = 1
                InputLabel.Position = UDim2.new(0, 12, 0, 4)
                InputLabel.Size = UDim2.new(1, -24, 0, 12)
                InputLabel.Font = Theme.Font
                InputLabel.Text = opts.Name
                InputLabel.TextColor3 = Theme.TextTertiary
                InputLabel.TextSize = 10
                InputLabel.TextXAlignment = Enum.TextXAlignment.Left
                InputLabel.Parent = InputFrame
                
                local InputBox = Instance.new("TextBox")
                InputBox.BackgroundTransparency = 1
                InputBox.Position = UDim2.new(0, 12, 0, 16)
                InputBox.Size = UDim2.new(1, -24, 0, 18)
                InputBox.Font = Theme.FontMedium
                InputBox.PlaceholderText = opts.Placeholder
                InputBox.PlaceholderColor3 = Theme.TextDisabled
                InputBox.Text = opts.Default
                InputBox.TextColor3 = Theme.Text
                InputBox.TextSize = 12
                InputBox.TextXAlignment = Enum.TextXAlignment.Left
                InputBox.ClearTextOnFocus = opts.ClearOnFocus
                InputBox.Parent = InputFrame
                
                InputBox.Focused:Connect(function()
                    Utility:QuickTween(InputFrame, { 
                        BackgroundColor3 = Theme.InputBgFocus,
                        BackgroundTransparency = 0.1,
                    })
                    Utility:QuickTween(InputStroke, { 
                        Color = Theme.AccentLight,
                        Transparency = 0.2,
                    })
                end)
                
                InputBox.FocusLost:Connect(function(enterPressed)
                    Utility:QuickTween(InputFrame, { 
                        BackgroundColor3 = Theme.InputBg,
                        BackgroundTransparency = 0.2,
                    })
                    Utility:QuickTween(InputStroke, { 
                        Color = Theme.Border,
                        Transparency = 0.4,
                    })
                    Input.Value = InputBox.Text
                    Swroyx.Flags[opts.Flag] = InputBox.Text
                    pcall(opts.Callback, InputBox.Text, enterPressed)
                end)
                
                Input.Set = function(_, value)
                    InputBox.Text = tostring(value)
                    Input.Value = value
                    Swroyx.Flags[opts.Flag] = value
                end
                
                Input.Get = function() return Input.Value end
                
                Swroyx.Flags[opts.Flag] = Input.Value
                table.insert(Section.Components, Input)
                return Input
            end
            
            -- ============ KEYBIND COMPONENT ============
            
            function Section:CreateKeybind(opts)
                opts = opts or {}
                opts.Name = opts.Name or "Keybind"
                opts.Default = opts.Default or Enum.KeyCode.Unknown
                opts.Flag = opts.Flag or opts.Name
                opts.Callback = opts.Callback or function() end
                
                local Keybind = { Value = opts.Default, Listening = false }
                
                local KeybindFrame = Instance.new("Frame")
                KeybindFrame.Name = "Keybind_" .. opts.Name
                KeybindFrame.BackgroundColor3 = Theme.ButtonNormal
                KeybindFrame.BackgroundTransparency = 0.2
                KeybindFrame.BorderSizePixel = 0
                KeybindFrame.Size = UDim2.new(1, 0, 0, Theme.ButtonHeight)
                KeybindFrame.Parent = ComponentsContainer
                
                Utility:AddCorner(KeybindFrame, 4)
                local KeybindStroke = Utility:AddStroke(KeybindFrame, Theme.Border, 1, 0.4)
                
                local KeybindLabel = Instance.new("TextLabel")
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.Position = UDim2.new(0, 12, 0, 0)
                KeybindLabel.Size = UDim2.new(1, -100, 1, 0)
                KeybindLabel.Font = Theme.FontMedium
                KeybindLabel.Text = opts.Name
                KeybindLabel.TextColor3 = Theme.Text
                KeybindLabel.TextSize = 12
                KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                KeybindLabel.Parent = KeybindFrame
                
                local KeybindButton = Instance.new("TextButton")
                KeybindButton.AnchorPoint = Vector2.new(1, 0.5)
                KeybindButton.BackgroundColor3 = Theme.GlassPrimary
                KeybindButton.BackgroundTransparency = 0.2
                KeybindButton.BorderSizePixel = 0
                KeybindButton.Position = UDim2.new(1, -10, 0.5, 0)
                KeybindButton.Size = UDim2.new(0, 80, 0, 22)
                KeybindButton.Font = Theme.FontMono
                KeybindButton.Text = opts.Default.Name
                KeybindButton.TextColor3 = Theme.AccentLight
                KeybindButton.TextSize = 11
                KeybindButton.AutoButtonColor = false
                KeybindButton.Parent = KeybindFrame
                
                Utility:AddCorner(KeybindButton, 3)
                local KbStroke = Utility:AddStroke(KeybindButton, Theme.AccentDark, 1, 0.4)
                
                KeybindButton.MouseButton1Click:Connect(function()
                    Keybind.Listening = true
                    KeybindButton.Text = "[ ... ]"
                    Utility:QuickTween(KbStroke, { 
                        Color = Theme.AccentLight,
                        Transparency = 0.1,
                    })
                end)
                
                UserInputService.InputBegan:Connect(function(input, processed)
                    if Keybind.Listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            Keybind.Value = input.KeyCode
                            KeybindButton.Text = input.KeyCode.Name
                            Keybind.Listening = false
                            Swroyx.Flags[opts.Flag] = input.KeyCode
                            Utility:QuickTween(KbStroke, { 
                                Color = Theme.AccentDark,
                                Transparency = 0.4,
                            })
                        end
                    elseif not processed and input.KeyCode == Keybind.Value then
                        pcall(opts.Callback)
                    end
                end)
                
                Keybind.Set = function(_, key)
                    Keybind.Value = key
                    KeybindButton.Text = key.Name
                    Swroyx.Flags[opts.Flag] = key
                end
                
                Keybind.Get = function() return Keybind.Value end
                
                Swroyx.Flags[opts.Flag] = Keybind.Value
                table.insert(Section.Components, Keybind)
                return Keybind
            end
            
            -- ============ COLORPICKER COMPONENT ============
            
            function Section:CreateColorPicker(opts)
                opts = opts or {}
                opts.Name = opts.Name or "ColorPicker"
                opts.Default = opts.Default or Color3.fromRGB(255, 255, 255)
                opts.Flag = opts.Flag or opts.Name
                opts.Callback = opts.Callback or function() end
                
                local ColorPicker = { Value = opts.Default, Open = false }
                
                local CPFrame = Instance.new("Frame")
                CPFrame.Name = "ColorPicker_" .. opts.Name
                CPFrame.BackgroundColor3 = Theme.ButtonNormal
                CPFrame.BackgroundTransparency = 0.2
                CPFrame.BorderSizePixel = 0
                CPFrame.Size = UDim2.new(1, 0, 0, Theme.ButtonHeight)
                CPFrame.Parent = ComponentsContainer
                
                Utility:AddCorner(CPFrame, 4)
                Utility:AddStroke(CPFrame, Theme.Border, 1, 0.4)
                
                local CPLabel = Instance.new("TextLabel")
                CPLabel.BackgroundTransparency = 1
                CPLabel.Position = UDim2.new(0, 12, 0, 0)
                CPLabel.Size = UDim2.new(1, -50, 1, 0)
                CPLabel.Font = Theme.FontMedium
                CPLabel.Text = opts.Name
                CPLabel.TextColor3 = Theme.Text
                CPLabel.TextSize = 12
                CPLabel.TextXAlignment = Enum.TextXAlignment.Left
                CPLabel.Parent = CPFrame
                
                local ColorButton = Instance.new("TextButton")
                ColorButton.AnchorPoint = Vector2.new(1, 0.5)
                ColorButton.BackgroundColor3 = opts.Default
                ColorButton.BorderSizePixel = 0
                ColorButton.Position = UDim2.new(1, -10, 0.5, 0)
                ColorButton.Size = UDim2.new(0, 32, 0, 20)
                ColorButton.Text = ""
                ColorButton.AutoButtonColor = false
                ColorButton.Parent = CPFrame
                
                Utility:AddCorner(ColorButton, 3)
                Utility:AddStroke(ColorButton, Theme.Text, 1, 0.4)
                
                ColorButton.MouseButton1Click:Connect(function()
                    -- Simple color randomization on click for demo
                    local newColor = Color3.fromRGB(
                        math.random(0, 255),
                        math.random(0, 255),
                        math.random(0, 255)
                    )
                    ColorPicker.Value = newColor
                    Utility:QuickTween(ColorButton, { BackgroundColor3 = newColor })
                    Swroyx.Flags[opts.Flag] = newColor
                    pcall(opts.Callback, newColor)
                end)
                
                ColorPicker.Set = function(_, color)
                    ColorPicker.Value = color
                    ColorButton.BackgroundColor3 = color
                    Swroyx.Flags[opts.Flag] = color
                end
                
                ColorPicker.Get = function() return ColorPicker.Value end
                
                Swroyx.Flags[opts.Flag] = ColorPicker.Value
                table.insert(Section.Components, ColorPicker)
                return ColorPicker
            end
            
            -- ============ LABEL COMPONENT ============
            
            function Section:CreateLabel(text)
                local Label = {}
                
                local LabelFrame = Instance.new("Frame")
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Size = UDim2.new(1, 0, 0, 24)
                LabelFrame.Parent = ComponentsContainer
                
                local LabelText = Instance.new("TextLabel")
                LabelText.BackgroundTransparency = 1
                LabelText.Size = UDim2.new(1, 0, 1, 0)
                LabelText.Font = Theme.FontMedium
                LabelText.Text = text or "Label"
                LabelText.TextColor3 = Theme.TextSecondary
                LabelText.TextSize = 12
                LabelText.TextXAlignment = Enum.TextXAlignment.Left
                LabelText.Parent = LabelFrame
                
                Label.Set = function(_, newText)
                    LabelText.Text = newText
                end
                
                table.insert(Section.Components, Label)
                return Label
            end
            
            -- ============ PARAGRAPH COMPONENT ============
            
            function Section:CreateParagraph(opts)
                opts = opts or {}
                opts.Title = opts.Title or "Paragraph"
                opts.Content = opts.Content or "Content here..."
                
                local Paragraph = {}
                
                local ParagraphFrame = Instance.new("Frame")
                ParagraphFrame.BackgroundColor3 = Theme.SectionBg
                ParagraphFrame.BackgroundTransparency = 0.4
                ParagraphFrame.BorderSizePixel = 0
                ParagraphFrame.Size = UDim2.new(1, 0, 0, 60)
                ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y
                ParagraphFrame.Parent = ComponentsContainer
                
                Utility:AddCorner(ParagraphFrame, 4)
                Utility:AddStroke(ParagraphFrame, Theme.Border, 1, 0.5)
                Utility:AddPadding(ParagraphFrame, 10, 10, 12, 12)
                
                local ParagraphTitle = Instance.new("TextLabel")
                ParagraphTitle.BackgroundTransparency = 1
                ParagraphTitle.Size = UDim2.new(1, 0, 0, 16)
                ParagraphTitle.Font = Theme.FontBold
                ParagraphTitle.Text = opts.Title
                ParagraphTitle.TextColor3 = Theme.AccentLight
                ParagraphTitle.TextSize = 12
                ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
                ParagraphTitle.Parent = ParagraphFrame
                
                local ParagraphContent = Instance.new("TextLabel")
                ParagraphContent.BackgroundTransparency = 1
                ParagraphContent.Position = UDim2.new(0, 0, 0, 18)
                ParagraphContent.Size = UDim2.new(1, 0, 0, 0)
                ParagraphContent.AutomaticSize = Enum.AutomaticSize.Y
                ParagraphContent.Font = Theme.Font
                ParagraphContent.Text = opts.Content
                ParagraphContent.TextColor3 = Theme.TextSecondary
                ParagraphContent.TextSize = 11
                ParagraphContent.TextXAlignment = Enum.TextXAlignment.Left
                ParagraphContent.TextYAlignment = Enum.TextYAlignment.Top
                ParagraphContent.TextWrapped = true
                ParagraphContent.Parent = ParagraphFrame
                
                Paragraph.SetTitle = function(_, t) ParagraphTitle.Text = t end
                Paragraph.SetContent = function(_, c) ParagraphContent.Text = c end
                
                table.insert(Section.Components, Paragraph)
                return Paragraph
            end
            
            -- ============ DIVIDER COMPONENT ============
            
            function Section:CreateDivider()
                local DividerFrame = Instance.new("Frame")
                DividerFrame.BackgroundTransparency = 1
                DividerFrame.Size = UDim2.new(1, 0, 0, 8)
                DividerFrame.Parent = ComponentsContainer
                
                local Line = Instance.new("Frame")
                Line.AnchorPoint = Vector2.new(0.5, 0.5)
                Line.BackgroundColor3 = Theme.Border
                Line.BackgroundTransparency = 0.5
                Line.BorderSizePixel = 0
                Line.Position = UDim2.new(0.5, 0, 0.5, 0)
                Line.Size = UDim2.new(1, -20, 0, 1)
                Line.Parent = DividerFrame
                
                local LineGradient = Instance.new("UIGradient")
                LineGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(1, 1),
                })
                LineGradient.Parent = Line
                
                return DividerFrame
            end
            
            return Section
        end
        
        return Tab
    end
    
    table.insert(Swroyx.Windows, Window)
    return Window
end

--==============================================================================
--                          PUBLIC API EXAMPLE USAGE
--==============================================================================
-- The following demonstrates how to use the library. Uncomment to use directly,
-- or copy this pattern after your loadstring call.
--==============================================================================
--[[ DEMO USAGE - Comment out before publishing if you only want the library:

local Window = Swroyx:CreateWindow({
    Name = "Swroyx | Premium",
    SubTitle = "By Minh Thật",
    AvatarId = 16060333448,
    Size = UDim2.new(0, 620, 0, 420),
})

-- ===== MAIN TAB =====
local MainTab = Window:CreateTab("Main", "rbxassetid://7733964719")

local InfoSection = MainTab:CreateSection("Information")

InfoSection:CreateParagraph({
    Title = "Welcome to Swroyx | Premium",
    Content = "Bạn đang sử dụng phiên bản cao cấp dành cho người dùng tinh tế nhất. Tất cả tính năng đều được tối ưu hóa cho trải nghiệm mượt mà.",
})

InfoSection:CreateLabel("Status: Online")
InfoSection:CreateLabel("Version: " .. Swroyx.Version)
InfoSection:CreateLabel("Author: " .. Swroyx.Author)

local FeaturesSection = MainTab:CreateSection("Quick Features")

FeaturesSection:CreateButton({
    Name = "Test Notification",
    Callback = function()
        Swroyx:Notify({
            Title = "Notification Test",
            Content = "[ Thành công ] Hệ thống thông báo hoạt động!",
            Type = "Success",
            Duration = 5,
        })
    end,
})

FeaturesSection:CreateButton({
    Name = "Show Premium Badge",
    Callback = function()
        Swroyx:Notify({
            Title = "Premium",
            Content = "★ You are a Premium user ★",
            Type = "Premium",
            Duration = 4,
        })
    end,
})

FeaturesSection:CreateToggle({
    Name = "Auto Farm",
    Default = false,
    Flag = "AutoFarm",
    Callback = function(value)
        Swroyx:Notify({
            Title = "Auto Farm",
            Content = "Auto Farm: " .. (value and "ON" or "OFF"),
            Type = value and "Success" or "Warning",
        })
    end,
})

FeaturesSection:CreateToggle({
    Name = "ESP Players",
    Default = false,
    Flag = "ESPPlayers",
})

FeaturesSection:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Suffix = " studs/s",
    Flag = "WalkSpeed",
    Callback = function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end,
})

FeaturesSection:CreateSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 500,
    Default = 50,
    Increment = 1,
    Flag = "JumpPower",
    Callback = function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = value
        end
    end,
})

-- ===== COMBAT TAB =====
local CombatTab = Window:CreateTab("Combat", "rbxassetid://7743871002")

local AimbotSection = CombatTab:CreateSection("Aimbot")

AimbotSection:CreateToggle({
    Name = "Enable Aimbot",
    Default = false,
    Flag = "Aimbot",
})

AimbotSection:CreateSlider({
    Name = "FOV Radius",
    Min = 10,
    Max = 500,
    Default = 100,
    Flag = "AimbotFOV",
})

AimbotSection:CreateSlider({
    Name = "Smoothness",
    Min = 1,
    Max = 100,
    Default = 30,
    Suffix = "%",
    Flag = "Smoothness",
})

AimbotSection:CreateDropdown({
    Name = "Target Part",
    Options = { "Head", "Torso", "HumanoidRootPart", "LeftArm", "RightArm" },
    Default = "Head",
    Flag = "TargetPart",
})

AimbotSection:CreateDropdown({
    Name = "Target Mode",
    Options = { "Closest to Mouse", "Closest to Camera", "Lowest Health", "Highest Health" },
    Default = "Closest to Mouse",
    Flag = "TargetMode",
})

AimbotSection:CreateKeybind({
    Name = "Aimbot Key",
    Default = Enum.KeyCode.E,
    Flag = "AimbotKey",
})

local TriggerSection = CombatTab:CreateSection("Triggerbot")

TriggerSection:CreateToggle({
    Name = "Enable Triggerbot",
    Default = false,
})

TriggerSection:CreateSlider({
    Name = "Trigger Delay",
    Min = 0,
    Max = 1000,
    Default = 100,
    Suffix = " ms",
})

-- ===== VISUALS TAB =====
local VisualsTab = Window:CreateTab("Visuals", "rbxassetid://7733715400")

local ESPSection = VisualsTab:CreateSection("ESP Settings")

ESPSection:CreateToggle({
    Name = "Box ESP",
    Default = false,
    Flag = "BoxESP",
})

ESPSection:CreateToggle({
    Name = "Name ESP",
    Default = false,
    Flag = "NameESP",
})

ESPSection:CreateToggle({
    Name = "Distance ESP",
    Default = false,
    Flag = "DistanceESP",
})

ESPSection:CreateToggle({
    Name = "Health Bar",
    Default = false,
    Flag = "HealthBar",
})

ESPSection:CreateToggle({
    Name = "Tracers",
    Default = false,
    Flag = "Tracers",
})

ESPSection:CreateColorPicker({
    Name = "ESP Color",
    Default = Color3.fromRGB(64, 156, 255),
    Flag = "ESPColor",
})

ESPSection:CreateColorPicker({
    Name = "Team Color",
    Default = Color3.fromRGB(80, 220, 140),
    Flag = "TeamColor",
})

local WorldSection = VisualsTab:CreateSection("World")

WorldSection:CreateToggle({
    Name = "Fullbright",
    Default = false,
    Callback = function(value)
        if value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 100000
        else
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
            Lighting.FogEnd = 1000
        end
    end,
})

WorldSection:CreateToggle({
    Name = "No Fog",
    Default = false,
})

WorldSection:CreateSlider({
    Name = "FOV",
    Min = 70,
    Max = 120,
    Default = 70,
    Callback = function(value)
        Camera.FieldOfView = value
    end,
})

-- ===== SETTINGS TAB =====
local SettingsTab = Window:CreateTab("Settings", "rbxassetid://7734053495")

local UISection = SettingsTab:CreateSection("UI Configuration")

UISection:CreateInput({
    Name = "Custom Username",
    Placeholder = "Enter your name...",
    Default = LocalPlayer.Name,
    Flag = "CustomName",
})

UISection:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightShift,
    Flag = "ToggleUI",
    Callback = function() Window:ToggleVisibility() end,
})

UISection:CreateDropdown({
    Name = "Theme",
    Options = { "Deep Blue (Default)", "Midnight", "Ocean", "Galaxy" },
    Default = "Deep Blue (Default)",
    Flag = "Theme",
})

UISection:CreateButton({
    Name = "Reset to Defaults",
    Callback = function()
        Swroyx:Notify({
            Title = "Settings",
            Content = "All settings have been reset to defaults",
            Type = "Info",
        })
    end,
})

UISection:CreateButton({
    Name = "Unload Script",
    Callback = function()
        for _, gui in pairs(CoreGui:GetChildren()) do
            if gui.Name:find("Swroyx") then
                gui:Destroy()
            end
        end
        for _, gui in pairs(PlayerGui:GetChildren()) do
            if gui.Name:find("Swroyx") then
                gui:Destroy()
            end
        end
    end,
})

local CreditsSection = SettingsTab:CreateSection("Credits")

CreditsSection:CreateParagraph({
    Title = "Swroyx | Premium",
    Content = "Phát triển bởi Minh Thật. Phiên bản " .. Swroyx.Version .. ". Tất cả quyền được bảo lưu.",
})

CreditsSection:CreateLabel("Discord: minhthat#0000")
CreditsSection:CreateLabel("Telegram: @minhthat")
CreditsSection:CreateLabel("Email: support@swroyx.com")

--]]

--==============================================================================
--                          RETURN LIBRARY
--==============================================================================

-- Notify when library is loaded
task.spawn(function()
    -- Library is ready to use
end)

-- Print loaded message to console
print("[Swroyx] Premium UI Library v" .. Swroyx.Version .. " loaded by " .. Swroyx.Author)
print("[Swroyx] Use Swroyx:CreateWindow({...}) to start building your UI")

--==============================================================================
--                          END OF LIBRARY
--==============================================================================
--[[
    Dưới đây là thông tin chi tiết về thư viện:
    
    ╔══════════════════════════════════════════════════════════════════════════╗
    ║                       Swroyx | Premium UI Library                        ║
    ║                            By Minh Thật                                  ║
    ╠══════════════════════════════════════════════════════════════════════════╣
    ║  Version : 2.0.0                                                         ║
    ║  Author  : Minh Thật                                                     ║
    ║  License : Premium / Private Use                                         ║
    ╠══════════════════════════════════════════════════════════════════════════╣
    ║                                                                          ║
    ║  FEATURES :                                                              ║
    ║  ▸ Cinematic Intro Animation (5 seconds)                                 ║
    ║  ▸ Glassmorphism Main UI                                                 ║
    ║  ▸ Industrial Sharp Notifications                                        ║
    ║  ▸ Smart Toggle Controller (Hide/Show)                                   ║
    ║  ▸ Avatar Identity Profile                                               ║
    ║  ▸ Tab System with Smooth Animations                                     ║
    ║  ▸ Component Library:                                                    ║
    ║    - Button (with ripple effect)                                         ║
    ║    - Toggle (animated switch)                                            ║
    ║    - Slider (with gradient fill)                                         ║
    ║    - Dropdown (multi-option select)                                      ║
    ║    - Input/Textbox (with focus state)                                    ║
    ║    - Keybind (rebindable hotkeys)                                        ║
    ║    - ColorPicker (color selection)                                       ║
    ║    - Label (text display)                                                ║
    ║    - Paragraph (formatted text block)                                    ║
    ║    - Divider (visual separator)                                          ║
    ║                                                                          ║
    ║  COLOR PALETTE :                                                         ║
    ║  ▸ Background      : Deep Dark Blue                                      ║
    ║  ▸ Accent          : Premium Blue                                        ║
    ║  ▸ AccentLight     : Bright Sky Blue                                     ║
    ║  ▸ DeepBlue        : Ocean Depth                                         ║
    ║  ▸ LightBlue       : Soft Toggle Blue                                    ║
    ║  ▸ Success         : Mint Green                                          ║
    ║  ▸ Error           : Coral Red                                           ║
    ║  ▸ Warning         : Sunset Orange                                       ║
    ║                                                                          ║
    ║  ANIMATIONS :                                                            ║
    ║  ▸ Smooth tweens with Quart easing                                       ║
    ║  ▸ Ripple effects on buttons                                             ║
    ║  ▸ Hover state transitions                                               ║
    ║  ▸ Fade in/out for notifications                                         ║
    ║  ▸ Scale animations for window open/close                                ║
    ║  ▸ Particle effects in intro                                             ║
    ║  ▸ Glow effects on accents                                               ║
    ║                                                                          ║
    ║  COMPATIBILITY :                                                         ║
    ║  ▸ All major Roblox executors                                            ║
    ║  ▸ Mobile (touch-friendly drag/click)                                    ║
    ║  ▸ Desktop (keyboard shortcuts)                                          ║
    ║                                                                          ║
    ╚══════════════════════════════════════════════════════════════════════════╝
    
    USAGE EXAMPLE :
    
    loadstring(game:HttpGet("YOUR_GITHUB_RAW_URL"))()
    
    local Swroyx = _G.Swroyx or Swroyx -- access the library
    
    local Window = Swroyx:CreateWindow({
        Name = "My Script | Premium",
        SubTitle = "By Your Name",
        AvatarId = 16060333448,
    })
    
    local Tab = Window:CreateTab("Main", "rbxassetid://7733964719")
    local Section = Tab:CreateSection("Features")
    
    Section:CreateButton({
        Name = "Click Me",
        Callback = function()
            print("Button clicked!")
            Swroyx:Notify({
                Title = "Success",
                Content = "[ Thành công ] Button works!",
                Type = "Success",
            })
        end,
    })
    
    Section:CreateToggle({
        Name = "Enable Feature",
        Default = false,
        Callback = function(value)
            print("Toggle:", value)
        end,
    })
    
    Section:CreateSlider({
        Name = "Speed",
        Min = 1,
        Max = 100,
        Default = 50,
        Callback = function(value)
            print("Slider:", value)
        end,
    })
    
    Section:CreateDropdown({
        Name = "Mode",
        Options = { "Easy", "Medium", "Hard" },
        Default = "Easy",
        Callback = function(option)
            print("Dropdown:", option)
        end,
    })
    
    NOTES :
    ▸ Press RightShift to toggle UI visibility
    ▸ Press the [ Hide ] button at bottom-left to hide
    ▸ Drag the header to move the window
    ▸ Click X to close the window completely
    ▸ Click − to minimize to header only
    
    This library is part of the Swroyx | Premium experience.
    For support, contact: support@swroyx.com
    
    © 2026 Minh Thật. All rights reserved.
--]]

-- Make library globally accessible
_G.Swroyx = Swroyx
getgenv = getgenv or function() return _G end
getgenv().Swroyx = Swroyx

--==============================================================================
--                        AUTO-INIT (DEMO WINDOW)
--==============================================================================
-- Khi script được nạp bằng loadstring(...)() thì giao diện sẽ tự hiện ra
-- gồm cinematic intro 5 giây + cửa sổ chính "Swroyx | Premium" / "By Minh Thật".
--==============================================================================

task.spawn(function()
    local ok, err = pcall(function()
        -- Phát intro 5 giây
        Swroyx:CreateIntro()

        -- Tạo cửa sổ chính
        local Window = Swroyx:CreateWindow({
            Name      = "Swroyx | Premium",
            SubTitle  = "By Minh Thật",
            AvatarId  = 16060333448,
        })

        -- ============ TAB : MAIN ============
        local MainTab     = Window:CreateTab("Main", "rbxassetid://7733964719")
        local MainSection = MainTab:CreateSection("Tổng quan")

        MainSection:CreateLabel("Chào mừng đến với Swroyx | Premium")
        MainSection:CreateParagraph(
            "Giới thiệu",
            "Thư viện UI cao cấp với hiệu ứng kính mờ, intro điện ảnh và hệ thống thông báo công nghiệp."
        )

        MainSection:CreateButton({
            Name = "Thông báo thử",
            Callback = function()
                Swroyx:Notify({
                    Title    = "Swroyx",
                    Content  = "[ Thành công ] Mọi thứ đang hoạt động !",
                    Type     = "Success",
                    Duration = 4,
                })
            end,
        })

        MainSection:CreateToggle({
            Name = "Bật tính năng",
            Default = false,
            Callback = function(v)
                Swroyx:Notify({
                    Title   = "Toggle",
                    Content = "[ Trạng thái ] " .. tostring(v),
                    Type    = v and "Success" or "Info",
                })
            end,
        })

        MainSection:CreateSlider({
            Name = "Tốc độ",
            Min = 1, Max = 100, Default = 50,
            Callback = function(v) end,
        })

        -- ============ TAB : SETTINGS ============
        local SetTab = Window:CreateTab("Settings", "rbxassetid://7734053495")
        local SetSec = SetTab:CreateSection("Cấu hình")

        SetSec:CreateDropdown({
            Name = "Chế độ",
            Options = { "Easy", "Medium", "Hard", "Insane" },
            Default = "Medium",
            Callback = function(opt) end,
        })

        SetSec:CreateKeybind({
            Name = "Phím tắt UI",
            Default = Enum.KeyCode.RightShift,
            Callback = function(key) end,
        })

        SetSec:CreateButton({
            Name = "Hủy / Unload",
            Callback = function()
                if Swroyx.Unload then Swroyx:Unload() end
            end,
        })

        -- Thông báo chào mừng sau intro
        task.wait(0.4)
        Swroyx:Notify({
            Title    = "Swroyx | Premium",
            Content  = "[ Thành công ] Đã tải xong - by Minh Thật",
            Type     = "Premium",
            Duration = 5,
        })
    end)

    if not ok then
        warn("[Swroyx] Lỗi khởi động : " .. tostring(err))
    end
end)

return Swroyx
