local player = game.Players.LocalPlayer

repeat wait() until player

repeat wait() until player.Character

local mouse = player:GetMouse()
local character = player.Character

local function HasTool()
	for _, child in pairs(character:GetChildren()) do
		if child:IsA("Tool") then
			return true
		end
	end
	return false
end

mouse.Button1Down:connect(function()
	if not HasTool() then
		local path = game:GetService("PathfindingService"):ComputeSmoothPathAsync(
			character.HumanoidRootPart.Position,
			mouse.Hit.p,
			500
		)
		if not string.find(path.Status.Name,"Fail") then
			for _, pos in pairs(path:GetPointCoordinates()) do
				character.Humanoid:MoveTo(pos)
				character.Humanoid.MoveToFinished:wait()
			end
		end
	end
end)