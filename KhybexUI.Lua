local Library = {}
local UIS = game:GetService("UserInputService")

function Library:CreateWindow(title)

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "KhobyUI_V2"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0,550,0,400)
main.Position = UDim2.new(0.5,-275,0.5,-200)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Parent = gui

local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1,0,0,40)
titleBar.Text = title
titleBar.TextColor3 = Color3.new(1,1,1)
titleBar.BackgroundColor3 = Color3.fromRGB(35,35,35)
titleBar.Parent = main

-- Dragging
local dragging = false
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = main.Position
end
end)

titleBar.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
local delta = input.Position - dragStart
main.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)

local tabButtons = Instance.new("Frame")
tabButtons.Size = UDim2.new(0,140,1,-40)
tabButtons.Position = UDim2.new(0,0,0,40)
tabButtons.BackgroundColor3 = Color3.fromRGB(30,30,30)
tabButtons.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabButtons

local container = Instance.new("Frame")
container.Size = UDim2.new(1,-140,1,-40)
container.Position = UDim2.new(0,140,0,40)
container.BackgroundTransparency = 1
container.Parent = main

local window = {}

function window:CreateTab(name)

local tabBtn = Instance.new("TextButton")
tabBtn.Size = UDim2.new(1,0,0,35)
tabBtn.Text = name
tabBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
tabBtn.TextColor3 = Color3.new(1,1,1)
tabBtn.Parent = tabButtons

local tabFrame = Instance.new("ScrollingFrame")
tabFrame.Size = UDim2.new(1,0,1,0)
tabFrame.Visible = false
tabFrame.CanvasSize = UDim2.new(0,0,0,0)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = container

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,6)
layout.Parent = tabFrame

tabBtn.MouseButton1Click:Connect(function()
for _,v in pairs(container:GetChildren()) do
if v:IsA("ScrollingFrame") then
v.Visible = false
end
end
tabFrame.Visible = true
end)

local tab = {}

function tab:CreateSection(name)

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
