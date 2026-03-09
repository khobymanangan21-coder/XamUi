-- KhobyUI (Simple Working Version)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "KhobyUI"
gui.ResetOnSpawn = false
pcall(function()
	gui.Parent = game.CoreGui
end)

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0,400,0,300)
main.Position = UDim2.new(0.5,-200,0.5,-150)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Text = "Khoby UI"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Parent = main

-- Container
local container = Instance.new("Frame")
container.Size = UDim2.new(1,-20,1,-50)
container.Position = UDim2.new(0,10,0,45)
container.BackgroundTransparency = 1
container.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,6)
layout.Parent = container

-- Dragging
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

-- BUTTON
local button = Instance.new("TextButton")
button.Size = UDim2.new(1,0,0,35)
button.Text = "Print Hello"
button.BackgroundColor3 = Color3.fromRGB(40,40,40)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = container

button.MouseButton1Click:Connect(function()
	print("Hello from KhobyUI")
end)

-- TOGGLE
local toggleState = false

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1,0,0,35)
toggle.Text = "Toggle : OFF"
toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Parent = container

toggle.MouseButton1Click:Connect(function()

	toggleState = not toggleState

	if toggleState then
		toggle.Text = "Toggle : ON"
	else
		toggle.Text = "Toggle : OFF"
	end

	print("Toggle State:",toggleState)

end)

-- SLIDER
local value = 10

local slider = Instance.new("TextButton")
slider.Size = UDim2.new(1,0,0,35)
slider.Text = "Speed : "..value
slider.BackgroundColor3 = Color3.fromRGB(40,40,40)
slider.TextColor3 = Color3.new(1,1,1)
slider.Parent = container

slider.MouseButton1Click:Connect(function()

	value = value + 5
	if value > 50 then
		value = 10
	end

	slider.Text = "Speed : "..value

	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = value
	end

end)
