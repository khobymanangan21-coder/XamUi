local Library = loadstring(game:HttpGet("YOUR_LINK_HERE"))()

local Window = Library:CreateWindow("Khoby Hub")

Window:Button("Print Hello", function()
    print("Hello World")
end)

Window:Toggle("Auto Farm", function(state)
    if state then
        print("Auto Farm Enabled")
    else
        print("Auto Farm Disabled")
    end
end)

Window:Slider("Speed", 10, 50, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
