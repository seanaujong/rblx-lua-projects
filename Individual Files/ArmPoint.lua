repeat wait() until game.Players.LocalPlayer
print("Delay FPS by 3 seconds")
wait(3)

database = require(Workspace:WaitForChild("Database"))
functions = database.Functions

player = game.Players.LocalPlayer
character = player.Character
cam = Workspace.CurrentCamera
mouse = player:GetMouse()
humanoid = character.Humanoid
mouse = player:GetMouse()

frarm = character["Right Arm"]:Clone()
frarmweld = Instance.new("Weld",character["Right Arm"])

tool = false

for i,v in pairs(character:GetChildren()) do
	if v:IsA("Tool") then
		tool = true
		v.Equipped:connect(function()
			tool = true
		end)
		v.Unequipped:connect(function()
			tool = false
		end)
	elseif v:IsA("HopperBin") then
		tool = true
		v.Selected:connect(function()
			tool = true
		end)
		v.Deselected:connect(function()
			tool = false
		end)
	end
end

for i,v in pairs(player.Backpack:GetChildren()) do
	if v:IsA("Tool") then
		v.Equipped:connect(function()
			tool = true
		end)
		v.Unequipped:connect(function()
			tool = false
		end)
	elseif v:IsA("HopperBin") then
		v.Selected:connect(function()
			tool = true
		end)
		v.Deselected:connect(function()
			tool = false
		end)
	end
end

function camfocusat(what)
	local camlookingat,camfocusat = Workspace:FindPartOnRay(Ray.new(cam.CoordinateFrame.p,(cam.Focus.p-cam.CoordinateFrame.p).unit*999),character)
	if what == "Part" or what == 1 then
		return camlookingat
	elseif what == "Position" or what == 2 then
		return camfocusat
	elseif what == "Both" or what == 3 then
		return camlookingat,camfocusat
	else
		print("function camfocusat received an incorrect argument: "..what)
	end
end

frarm.Parent = cam

frarmweld.Part0 = frarmweld.Parent
frarmweld.Part1 = frarm
frarmweld.C0 = CFrame.new(0,0,0)

game:GetService("RunService").RenderStepped:connect(function()
	if tool then
		local Omega = (camfocusat("Position")+(cam.Focus.p-cam.CoordinateFrame.p).unit*999 - player.Character.Torso.Position).unit
		local Omega_c = Vector3.new(Omega.X, Omega.Y,0)
		local Theta = functions.AngleBetween(Vector3.new(0,-1,0), Omega_c)
		frarm.Transparency = 0
		character.Torso["Right Shoulder"].C0 = (database.Humanoid["Right Shoulder"].C0*CFrame.Angles(0,0,Theta-math.rad(not character.Animate.Disabled and 90 or 0)))
	elseif not tool then
		frarm.Transparency = 1
		character.Torso["Right Shoulder"].C0 = database.Humanoid["Right Shoulder"].C0
	end
end)