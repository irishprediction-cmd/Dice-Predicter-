
-- IRISH DICE PREDICTION
-- Independent GUI - No KEY
-- Visual random color demo

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "IrishDicePrediction"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- COLORS

local colors = {
    {name="Green", color=Color3.fromRGB(32,168,74)},
    {name="Yellow",color=Color3.fromRGB(245,211,41)},
    {name="Red",color=Color3.fromRGB(239,52,52)},
    {name="Purple",color=Color3.fromRGB(150,62,213)},
    {name="Blue",color=Color3.fromRGB(40,89,232)},
    {name="Orange",color=Color3.fromRGB(242,139,25)}
}

local BG = Color3.fromRGB(15,15,20)
local PANEL = Color3.fromRGB(20,20,27)
local WHITE = Color3.fromRGB(245,245,250)
local MUTED = Color3.fromRGB(145,145,160)
local BORDER = Color3.fromRGB(60,60,70)

-- HELPERS

local function make(class,parent,props)
    local obj = Instance.new(class)
    for k,v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function corner(obj,r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,r)
    c.Parent = obj
end

local function stroke(obj,color,thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or BORDER
    s.Thickness = thickness or 1.5
    s.Parent = obj
end

local function label(parent,txt,pos,size)
    return make("TextLabel",parent,{
        Size=size,
        Position=pos,
        BackgroundTransparency=1,
        Text=txt,
        TextColor3=MUTED,
        Font=Enum.Font.GothamBold,
        TextScaled=true,
        TextXAlignment=Enum.TextXAlignment.Left
    })
end

-- MAIN GUI

local main = make("Frame",gui,{
    Size=UDim2.fromScale(0.95,0.92),
    Position=UDim2.fromScale(0.5,0.5),
    AnchorPoint=Vector2.new(0.5,0.5),
    BackgroundColor3=BG,
    BorderSizePixel=0
})
corner(main,24)
stroke(main,BORDER,2)

-- RESPONSIVE SCALE

local scale = Instance.new("UIScale")
scale.Scale = 0.65
scale.Parent = main

-- HEADER

local header = make("Frame",main,{
    Size=UDim2.new(1,-20,0.13,0),
    Position=UDim2.new(0,10,0,10),
    BackgroundColor3=PANEL,
    BorderSizePixel=0
})
corner(header,20)
stroke(header)

local logo = make("TextLabel",header,{
    Size=UDim2.fromScale(0.065,0.75),
    Position=UDim2.fromScale(0.015,0.12),
    BackgroundColor3=BG,
    Text="☘",
    TextColor3=Color3.fromRGB(120,190,65),
    TextScaled=true
})
corner(logo,14)

make("TextLabel",header,{
    Size=UDim2.fromScale(0.48,0.4),
    Position=UDim2.fromScale(0.095,0.20),
    BackgroundTransparency=1,
    Text="IRISH DICE PREDICTION",
    TextColor3=WHITE,
    Font=Enum.Font.GothamBold,
    TextScaled=true,
    TextXAlignment=Enum.TextXAlignment.Left
})

make("TextLabel",header,{
    Size=UDim2.fromScale(0.45,0.25),
    Position=UDim2.fromScale(0.095,0.59),
    BackgroundTransparency=1,
    Text="discord.gg/irsh  ·  Love You Guys",
    TextColor3=MUTED,
    Font=Enum.Font.Gotham,
    TextScaled=true,
    TextXAlignment=Enum.TextXAlignment.Left
})

local zoomMinus = make("TextButton",header,{
    Size=UDim2.fromScale(0.045,0.5),
    Position=UDim2.fromScale(0.72,0.25),
    BackgroundColor3=BG,
    Text="−",
    TextColor3=WHITE,
    TextScaled=true
})
corner(zoomMinus,10)

local zoomText = make("TextLabel",header,{
    Size=UDim2.fromScale(0.09,0.5),
    Position=UDim2.fromScale(0.77,0.25),
    BackgroundColor3=BG,
    Text="65%",
    TextColor3=WHITE,
    Font=Enum.Font.GothamBold,
    TextScaled=true
})
corner(zoomText,10)

local zoomPlus = make("TextButton",header,{
    Size=UDim2.fromScale(0.045,0.5),
    Position=UDim2.fromScale(0.865,0.25),
    BackgroundColor3=BG,
    Text="+",
    TextColor3=WHITE,
    TextScaled=true
})
corner(zoomPlus,10)

local fps = make("TextLabel",header,{
    Size=UDim2.fromScale(0.07,0.6),
    Position=UDim2.fromScale(0.92,0.2),
    BackgroundTransparency=1,
    Text="FPS --",
    TextColor3=WHITE,
    TextScaled=true
})

zoomMinus.MouseButton1Click:Connect(function()
    scale.Scale=math.max(0.40,scale.Scale-0.05)
    zoomText.Text=math.floor(scale.Scale*100).."%"
end)

zoomPlus.MouseButton1Click:Connect(function()
    scale.Scale=math.min(1,scale.Scale+0.05)
    zoomText.Text=math.floor(scale.Scale*100).."%"
end)

-- LEFT PANEL

local left = make("Frame",main,{
    Size=UDim2.new(0.21,0,0.81,-10),
    Position=UDim2.new(0.015,0,0.16,0),
    BackgroundColor3=PANEL,
    BorderSizePixel=0
})
corner(left,20)
stroke(left)

label(left,"VERSION",
    UDim2.fromScale(0.07,0.035),
    UDim2.fromScale(0.85,0.045))

local versionButtons={}
local selectedVersion="V1"

for i=1,4 do
    local name="V"..i

    local b=make("TextButton",left,{
        Size=UDim2.fromScale(0.86,0.075),
        Position=UDim2.fromScale(0.07,0.10+(i-1)*0.085),
        BackgroundColor3=i==1 and Color3.fromRGB(43,43,54) or BG,
        Text=name,
        TextColor3=WHITE,
        Font=Enum.Font.GothamBold,
        TextScaled=true
    })
    corner(b,12)
    stroke(b)
    versionButtons[name]=b

    b.MouseButton1Click:Connect(function()
        selectedVersion=name
        for v,button in pairs(versionButtons) do
            button.BackgroundColor3=
                v==name and Color3.fromRGB(43,43,54) or BG
        end
    end)
end

label(left,"STATUS",
    UDim2.fromScale(0.07,0.47),
    UDim2.fromScale(0.85,0.045))

local status=make("TextLabel",left,{
    Size=UDim2.fromScale(0.86,0.075),
    Position=UDim2.fromScale(0.07,0.52),
    BackgroundColor3=BG,
    Text="●  IDLE",
    TextColor3=Color3.fromRGB(170,170,180),
    Font=Enum.Font.GothamBold,
    TextScaled=true
})
corner(status,12)
stroke(status)

local logCount=0

local logs=make("TextLabel",left,{
    Size=UDim2.fromScale(0.86,0.075),
    Position=UDim2.fromScale(0.07,0.61),
    BackgroundColor3=BG,
    Text="Logs: 0",
    TextColor3=MUTED,
    Font=Enum.Font.Gotham,
    TextScaled=true
})
corner(logs,12)
stroke(logs)

-- CENTER PANEL

local center=make("Frame",main,{
    Size=UDim2.new(0.53,0,0.81,-10),
    Position=UDim2.new(0.235,0,0.16,0),
    BackgroundTransparency=1
})

label(center,"SELECT DICE COLORS",
    UDim2.fromScale(0,0.005),
    UDim2.fromScale(0.8,0.05))

-- FOUR SELECTABLE COLOR SQUARES

local selected={1,1,1,1}
local colorButtons={}

for i=1,4 do

    local b=make("TextButton",center,{
        Size=UDim2.fromScale(0.18,0.17),
        Position=UDim2.fromScale((i-1)*0.205,0.055),
        BackgroundColor3=Color3.fromRGB(25,25,32),
        Text="●\nGreen",
        TextColor3=colors[1].color,
        Font=Enum.Font.GothamBold,
        TextScaled=true
    })

    corner(b,25)
    stroke(b,BORDER,2)
    colorButtons[i]=b

    b.MouseButton1Click:Connect(function()
        selected[i]=(selected[i]%#colors)+1
        local chosen=colors[selected[i]]

        b.Text="●\n"..chosen.name
        b.TextColor3=chosen.color

        logCount=logCount+1
        logs.Text="Logs: "..logCount
    end)
end

-- PREDICT BUTTON

local predict=make("TextButton",center,{
    Size=UDim2.fromScale(0.99,0.105),
    Position=UDim2.fromScale(0,0.265),
    BackgroundColor3=WHITE,
    Text="PREDICT",
    TextColor3=Color3.fromRGB(15,15,20),
    Font=Enum.Font.GothamBold,
    TextScaled=true
})
corner(predict,17)

-- RESULT PANEL

local result=make("Frame",center,{
    Size=UDim2.fromScale(0.99,0.65),
    Position=UDim2.fromScale(0,0.40),
    BackgroundColor3=PANEL,
    BorderSizePixel=0
})
corner(result,22)
stroke(result)

label(result,"PREDICTION",
    UDim2.fromScale(0.04,0.045),
    UDim2.fromScale(0.45,0.055))

label(result,"CONFIDENCE —",
    UDim2.fromScale(0.70,0.045),
    UDim2.fromScale(0.27,0.055))

-- FIFTH COLOR SQUARE

local resultSquare=make("Frame",result,{
    Size=UDim2.fromScale(0.16,0.25),
    Position=UDim2.fromScale(0.04,0.18),
    BackgroundColor3=Color3.fromRGB(25,25,32),
    BorderSizePixel=0
})
corner(resultSquare,24)
stroke(resultSquare,BORDER,2)

local resultDot=make("TextLabel",resultSquare,{
    Size=UDim2.fromScale(1,1),
    BackgroundTransparency=1,
    Text="●",
    TextColor3=WHITE,
    Font=Enum.Font.GothamBold,
    TextScaled=true
})

local resultName=make("TextLabel",result,{
    Size=UDim2.fromScale(0.55,0.15),
    Position=UDim2.fromScale(0.23,0.23),
    BackgroundTransparency=1,
    Text="Waiting...",
    TextColor3=WHITE,
    Font=Enum.Font.GothamBold,
    TextScaled=true,
    TextXAlignment=Enum.TextXAlignment.Left
})

-- RANDOM COLOR PREDICTION DEMO

local randomGenerator=Random.new()

predict.MouseButton1Click:Connect(function()

    status.Text="●  PROCESSING"

    local randomIndex=randomGenerator:NextInteger(1,#colors)
    local chosen=colors[randomIndex]

    resultDot.TextColor3=chosen.color
    resultName.Text=chosen.name

    logCount=logCount+1
    logs.Text="Logs: "..logCount

    status.Text="●  IDLE"

end)

-- RIGHT PANEL

local right=make("Frame",main,{
    Size=UDim2.new(0.21,0,0.81,-10),
    Position=UDim2.new(0.775,0,0.16,0),
    BackgroundColor3=PANEL,
    BorderSizePixel=0
})
corner(right,20)
stroke(right)

label(right,"NAVIGATION",
    UDim2.fromScale(0.07,0.035),
    UDim2.fromScale(0.85,0.045))

local navButtons={}

for i,name in ipairs({"Predict","Stats","History"}) do

    local b=make("TextButton",right,{
        Size=UDim2.fromScale(0.86,0.085),
        Position=UDim2.fromScale(0.07,0.10+(i-1)*0.095),
        BackgroundColor3=i==1 and Color3.fromRGB(43,43,54) or BG,
        Text=name,
        TextColor3=WHITE,
        Font=Enum.Font.GothamBold,
        TextScaled=true
    })

    corner(b,13)
    stroke(b)
    navButtons[name]=b

    b.MouseButton1Click:Connect(function()

        for n,button in pairs(navButtons) do
            button.BackgroundColor3=
                n==name and Color3.fromRGB(43,43,54) or BG
        end

        if name=="Predict" then
            resultName.Text="Waiting..."
            resultDot.TextColor3=WHITE
        elseif name=="Stats" then
            resultName.Text="Stats selected"
        else
            resultName.Text="History selected"
        end
    end)
end

-- DRAG ANYWHERE SYSTEM (MOBILE + PC)

local UIS = game:GetService("UserInputService")

local dragging = false
local dragCandidate = false
local dragStart = nil
local startPosition = nil
local activeInput = nil
local dragThreshold = 7

local function insideMain(position)
    local p = main.AbsolutePosition
    local s = main.AbsoluteSize

    return position.X >= p.X
        and position.X <= p.X + s.X
        and position.Y >= p.Y
        and position.Y <= p.Y + s.Y
end

UIS.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then

        if insideMain(input.Position) then
            dragCandidate = true
            dragging = false
            dragStart = input.Position
            startPosition = main.Position
            activeInput = input
        end
    end
end)

UIS.InputChanged:Connect(function(input)

    if not dragCandidate then return end

    local isMovement =
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input == activeInput

    if not isMovement then return end

    local delta = input.Position - dragStart

    if not dragging then
        if delta.Magnitude >= dragThreshold then
            dragging = true
        end
    end

    if dragging then
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)

    if input == activeInput
    or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = false
        dragCandidate = false
        activeInput = nil
    end
end)

print("IRISH DICE PREDICTION GUI loaded!")
