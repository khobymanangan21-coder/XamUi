-- KhobyUI Library
local KhobyUI = {}
KhobyUI.__index = KhobyUI

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

function KhobyUI:CreateWindow(title)

    local player = Players.LocalPlayer

    local gui = Instance.new("ScreenGui")
    gui.Name = "KhobyUI"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0,500,0,350)
    main.Position = UDim2.new(0.5,-250,0.5,-175)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.Parent = gui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1,0,0,40)
    titleLabel.Text = title or "Khoby UI"
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 22
    titleLabel.Parent = main

    -- DRAG SYSTEM
    local dragging = false
    local dragInput, dragStart, startPos

    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)

    main.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1,-20,1,-60)
    container.Position = UDim2.new(0,10,0,50)
    container.BackgroundTransparency = 1
    container.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,6)
    layout.Parent = container

    local Window = {}

    function Window:Button(text,callback)

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,0,0,35)
        btn.Text = text
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 16
        btn.Parent = container

        btn.MouseButton1Click:Connect(function()
            callback()
        end)

    end

    function Window:Toggle(text,callback)

        local toggled = false

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,0,0,35)
        btn.Text = text.." : OFF"
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Parent = container

        btn.MouseButton1Click:Connect(function()

            toggled = not toggled

            if toggled then
                btn.Text = text.." : ON"
            else
                btn.Text = text.." : OFF"
            end

            callback(toggled)

        end)

    end

    function Window:Slider(text,min,max,callback)

        local slider = Instance.new("TextButton")
        slider.Size = UDim2.new(1,0,0,35)
        slider.BackgroundColor3 = Color3.fromRGB(40,40,40)
        slider.TextColor3 = Color3.new(1,1,1)
        slider.Text = text.." : "..min
        slider.Parent = container

        local value = min

        slider.MouseButton1Click:Connect(function()

            value = value + 1
            if value > max then value = min end

            slider.Text = text.." : "..value

            callback(value)

        end)

    end

    return Window

end

return KhobyUI)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,-10,0,30)
label.Text = name
label.TextColor3 = Color3.fromRGB(200,200,200)
label.BackgroundTransparency = 1
label.Parent = tabFrame

end

function tab:CreateButton(text,callback)

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1,-10,0,35)
btn.Text = text
btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
btn.TextColor3 = Color3.new(1,1,1)
btn.Parent = tabFrame

btn.MouseButton1Click:Connect(callback)

end

function tab:CreateToggle(text,callback)

local state = false

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1,-10,0,35)
toggle.Text = text.." : OFF"
toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Parent = tabFrame

toggle.MouseButton1Click:Connect(function()

state = not state

toggle.Text = text.." : "..(state and "ON" or "OFF")

callback(state)

end)

end

function tab:CreateSlider(text,min,max,callback)

local value = min

local slider = Instance.new("TextButton")
slider.Size = UDim2.new(1,-10,0,35)
slider.Text = text.." : "..value
slider.BackgroundColor3 = Color3.fromRGB(50,50,50)
slider.TextColor3 = Color3.new(1,1,1)
slider.Parent = tabFrame

slider.MouseButton1Click:Connect(function()

value += 1
if value > max then
value = min
end

slider.Text = text.." : "..value

callback(value)

end)

end

function tab:CreateDropdown(text,list,callback)

local index = 1

local drop = Instance.new("TextButton")
drop.Size = UDim2.new(1,-10,0,35)
drop.Text = text.." : "..list[index]
drop.BackgroundColor3 = Color3.fromRGB(50,50,50)
drop.TextColor3 = Color3.new(1,1,1)
drop.Parent = tabFrame

drop.MouseButton1Click:Connect(function()

index += 1
if index > #list then
index = 1
end

drop.Text = text.." : "..list[index]

callback(list[index])

end)

end

function tab:CreateKeybind(key,callback)

UIS.InputBegan:Connect(function(input)

if input.KeyCode == key then
callback()
end

end)

end

return tab
end

function Library:Notify(text)

local notif = Instance.new("TextLabel")
notif.Size = UDim2.new(0,260,0,40)
notif.Position = UDim2.new(1,-270,1,-60)
notif.BackgroundColor3 = Color3.fromRGB(40,40,40)
notif.TextColor3 = Color3.new(1,1,1)
notif.Text = text
notif.Parent = gui

task.wait(3)

notif:Destroy()

end

return window
end

return Library
