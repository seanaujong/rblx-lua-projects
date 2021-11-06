local player = game.Players.LocalPlayer

repeat wait() until player
repeat wait() until player.Character

local mouse = player:GetMouse()
local character = player.Character

local root = character:WaitForChild("HumanoidRootPart")

local rootgyro = Instance.new("BodyGyro",root)

rootgyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
rootgyro.P = 10000

character.Humanoid.AutoRotate = false

game:GetService("RunService"):BindToRenderStep(
	"UpdateRootGyro",
	Enum.RenderPriority.Character.Value,
	function()
		rootgyro.CFrame =
		CFrame.Angles(
			0,
			math.atan2(
				root.CFrame.X-mouse.Hit.X,
				root.CFrame.Z-mouse.Hit.Z
			),
			0
		)
end)

game:GetService("RunService"):BindToRenderStep(
	"UpdateNeckC1",
	Enum.RenderPriority.Character.Value,
	function()
		character.Torso.Neck.C1 =
		CFrame.new(0,-0.5,0,-1,0,0,0,0,1,0,1,-0)
		*CFrame.Angles(
			-math.atan2(
				character.Head.CFrame.Y-mouse.Hit.Y,
				math.sqrt((character.Head.CFrame.X-mouse.Hit.X)^2+(character.Head.CFrame.Z-mouse.Hit.Z)^2) --Distance formula
			),
			0,
			0
		)
end)