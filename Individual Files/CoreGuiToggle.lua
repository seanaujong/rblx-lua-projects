--This portion of the code is server-side

usepermissions = false -- Change to true if you want only certain people to get the GUI, false if everyone gets it.
permissions = {"evolvedpikachu"} -- Add names to the table

function haspermission(player)
	local haspermission = false
	for i, v in pairs(permissions) do
		if v == player.Name then
			haspermission = true
			end
	end
	return haspermission
end

game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		if usepermissions == false then
		script.CoreGuiSettings:Clone().Parent = player.PlayerGui
		script.AutoSettings:Clone().Parent = player.PlayerGui
		elseif usepermissions == true and haspermission(player) == true then
			script.CoreGuiSettings:Clone().Parent = player.PlayerGui
			script.AutoSettings:Clone().Parent = player.PlayerGui
		elseif usepermissions == true and haspermission(player) == false then
			script.AutoSettings:Clone().Parent = player.PlayerGui
		end
end)
end)

--This portion of the code is client-side

CoreGuiSettings = {
Chat = true; -- Chat CoreGUI
Backpack = true; -- Backpack CoreGUI
Health = true; -- Health GUI
PlayerList = true -- Leaderboard/PlayerList CoreGUI
}

function correctsettings()
	for i, v in pairs(CoreGuiSettings) do
		if game.StarterGui:GetCoreGuiEnabled(i) == false then
			return false
		end
	end
	return true
end

repeat
for i,v in pairs(CoreGuiSettings) do
	game.StarterGui:SetCoreGuiEnabled(tostring(i),v)
end
wait()
until correctsettings()