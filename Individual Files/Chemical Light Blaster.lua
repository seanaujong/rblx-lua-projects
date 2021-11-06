tool = script.Parent
handle = tool:WaitForChild("Handle")
ammo = tool:WaitForChild("Ammo")
holes = {}
ammogui = tool:WaitForChild("CLBAmmo")

function reweld()
	for i, v in pairs(handle:GetChildren()) do
		if v:IsA("Weld") then
			v:Destroy()
		end
	end
	for i, v in pairs(tool:GetChildren()) do
		if v:IsA("BasePart") and v ~= handle then
			local weld = Instance.new("Weld",handle)
			weld.Part0 = handle
			weld.Part1 = v
			weld.C0 = v.WeldC0.Value
			weld.Name = v.Name.."Weld"
		end
	end
end

for i, v in pairs(tool:GetChildren()) do
	if v.Name == "Hole" then
		table.insert(holes,v)
	end
end

reweld()

ammo.Changed:connect(function()
	ammogui.Ammo.AmmoText.Text = ammo.Value>0 and ammo.Value.."/"..#holes or "Reload"
	ammogui.Ammo.AmmoBar.Size = UDim2.new(1/8*ammo.Value,0,1,0)
end)

repeat wait() until game.Players.LocalPlayer

player = game.Players.LocalPlayer
character = player.Character
cam = Workspace.CurrentCamera
mousedown = false
reloading = false

tool.Equipped:connect(function(mouse)
	ammogui.Parent = player.PlayerGui
	reweld()
	
	mouse.Button1Down:connect(function()
		if not mousedown then
			mousedown = true
			while mousedown do
				if ammo.Value > 0 and not reloading then
					local bullet = Instance.new("Part",Workspace)
					local bulletforce = Instance.new("BodyForce",bullet)
					local bulletlight = Instance.new("PointLight",bullet)
					local color = BrickColor.Random()
					local hole = holes[math.random(#holes)]
					bullet.FormFactor = "Custom"
					bullet.Size = Vector3.new(0.2,0.2,2)
					bullet.BottomSurface = "Smooth"
					bullet.TopSurface = "Smooth"
					bullet.Friction = 1
					bullet.Material = "SmoothPlastic"
					bullet.BrickColor = color
					bullet.Reflectance = 0.1
					bullet.Name = "Bullet"
					bullet.Elasticity = 0
					bullet.Touched:connect(function()
						if bullet:FindFirstChild("BodyForce") then
							bullet.BodyForce:Destroy()
						end
					end)
					bullet.CFrame = hole.CFrame:toWorldSpace(CFrame.new(1.5,0,0))
					bullet.CFrame = CFrame.new(bullet.Position,mouse.Hit.p)
					bullet.Friction = 0.8
					bulletforce.force = (mouse.Hit.p-bullet.Position).unit*50
					bulletforce.force = Vector3.new(bulletforce.force.X,bulletforce.force.Y+196.2*bullet:GetMass(),bulletforce.force.Z)
					handle.Shot:Play()
					bulletlight.Color = color.Color
					bulletlight.Range = 10
					bulletlight.Shadows = true
					coroutine.wrap(function()
						wait(0.1)
						if bullet:FindFirstChild("BodyForce") then
							bulletforce.force = bulletforce.force-Vector3.new(0,196.2*bullet:GetMass(),0)
						end
						wait(2)
						if bullet:FindFirstChild("BodyForce") then
							bullet.BodyForce:Destroy()
						end
					end)()
					game:GetService("Debris"):AddItem(bullet,60)
					ammo.Value = ammo.Value-1
				elseif ammo.Value == 0 and not reloading then
					handle.Click:Play()
				end
				wait(0.4)
			end		
		end
	end)
	
	mouse.Button1Up:connect(function()
		if mousedown then
			wait(0.4)
			mousedown = false
		end
	end)
	
	mouse.KeyDown:connect(function(key)
		if not mousedown then
			if key == "r" and not reloading and ammo.Value ~= #holes then
				reloading = true
				handle.Reload:Play()
				wait(2)
				ammo.Value = #holes
				reloading = false
			end
		end
	end)
end)

tool.Unequipped:connect(function()
	reweld()
	ammogui.Parent = tool
	mousedown = false
end)