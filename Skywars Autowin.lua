local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")


local screenGui = Instance.new("ScreenGui")
screenGui.parent = game:WaitForChild("CoreGui")


local Mainframe = Instance.new("Frame")
Mainframe.Size = UDim2.new(0, 190, 0, 170)
Mainframe.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15) 
Mainframe.Position = UDim2.new(0, 0, 0, 0)
Mainframe.BorderSizePixel = 0
Mainframe.Parent = screenGui


local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = Mainframe

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "NovaWare"
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.Parent = Mainframe

local FrameToggle = Instance.new("TextButton")
FrameToggle.Size = UDim2.new(0, 60, 0, 30)
FrameToggle.Position = UDim2.new(1, -70, 0, 2)
FrameToggle.Text = "+"
FrameToggle.TextColor3 = Color3.new(1, 1, 1)
FrameToggle.TextSize = 19
FrameToggle.BackgroundTransparency = 1 
FrameToggle.Parent = Mainframe

local isOpen = false
local originalSize = Mainframe.Size


local autoWinToggle = Instance.new("TextButton")
autoWinToggle.Size = UDim2.new(0, 120, 0, 30)
autoWinToggle.Position = UDim2.new(0.5, -60, 0, 50)
autoWinToggle.Text = "AutoWin"
autoWinToggle.TextColor3 = Color3.new(1, 1, 1)
autoWinToggle.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
autoWinToggle.Parent = Mainframe

local toggleUICorner = Instance.new("UICorner")
toggleUICorner.CornerRadius = UDim.new(0, 8)
toggleUICorner.Parent = autoWinToggle


local AutoWinEnabled = false

autoWinToggle.MouseButton1Click:Connect(function()

AutoWinEnabled = not AutoWinEnabled
--Not a actual autowin, but better then nothing
local function TpToPlayers()
    if not AutoWinEnabled then
        return
    end
    
    local localPlayer = Players.LocalPlayer
    local otherPlayers = Players:GetPlayers()

    if #otherPlayers > 1 then
        local randomPlayer = otherPlayers[math.random(1, #otherPlayers)]
        local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            local startTime = tick()
            local duration = 2

            RunService.RenderStepped:Connect(function()
                local elapsedTime = tick() - startTime

                if elapsedTime < duration then
                    local targetPosition = randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") and randomPlayer.Character.HumanoidRootPart.Position
                    if targetPosition then
                        localPlayer.Character:MoveTo(targetPosition)
                    end
                else
                    RunService.RenderStepped:Disconnect()  
                end
            end)
        end
    end
end

while task.wait(1.5) do
    TpToPlayers()
end


end)

local Enabled = false
FrameToggle.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    Enabled = not Enabled
    Mainframe:TweenSize(isOpen and UDim2.new(0, 190, 0, 40) or originalSize, "Out", "Quad", 0.5, true)
    FrameToggle.Text = isOpen and "-" or "+"
    autoWinToggle.Visible = not Enabled
end)


