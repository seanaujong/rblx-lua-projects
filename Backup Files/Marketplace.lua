--[[
	Evolvedpikachu's Shop Script (For Parts and Models only)
	
	This Script will make any Part/Model in Workspace allow players to purchase a certain item by clicking on it.
	This Script will break if you do not follow the instructions correctly (Leaving an object's Value empty, for example), do EVERYTHING it
	says correctly.
	
	To give Parts this effect, please do the following:
		-Insert a NumberValue into the desired object(1)
		-Name the NumberValue "ItemID"
		-Insert the numbers in the ID of the Catalog item you are selling(2) into the "Value" property
		If you want to specify a certain type of currency it will be purchased in, please do the following:
		-Insert a StringValue into the desired object(1)
		-Name the StringValue "CurrencyType
		-Insert "Default" for default currency, "Robux" for robux, and "Tix" for tix
		If you are selling a gear and want to give it to the player immeadiately, please do the following:
		-Insert a BoolValue into the desired object(1)
		-Name the BoolValue "EquipGear"
		-Check the "Value" property if you want to give it immeadiately, uncheck if you don't
		
	How the Script works:
		First, at the start of the game, it will go through all the objects in Workspace.
		If the object is a BasePart (Part, CornerWedgePart, etc.) and has an object called "ItemID" in it, it will add a ClickDetector
		and upon being clicked, it will prompt the clicker to purchase the specified item.
		If the object is a Model, and has an object called "ItemID" in it, it will add a ClickDetector and upon being clicked, it will
		prompt the clicker to purchase the specified item.
		If the object is a Model, and does NOT have an object called "ItemID" in it, it will go through all its objects and do the
		instructions over again.
	Notes:
	(1) You can insert a Value in two ways:
		1. Run Instance.new("SPECIFIEDValue",Workspace), replace SPECIFIEDValue with the correct Value Object, and drag it into correct
		 object.
		2. Open the Advanced Objects window (Insert > Advanced Objects), then in Workspace, click on the correct object, then on
		 Advanced Objects, click the correct Value Object.
	(2) To get the numbers of the Catalog item's ID, go to the Catalog item's page on ROBLOX, then copy the numbers at the end of its link.
--]]

function MakeBuyables(parent)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") and v:FindFirstChild("ItemID") then
			local clickdetector = Instance.new("ClickDetector",v)
			clickdetector.MouseClick:connect(function(player)
				game:GetService("MarketplaceService"):PromptPurchase(
					player,
					v.ItemID.Value, -- Item's assetId
					v:FindFirstChild("EquipGear") and v.EquipGear.Value or false, --If gear, whether it will be given immediately or not
					v:FindFirstChild("CurrencyType") and v.CurrencyType.Value or "Default" --If specified, then sets currency that will be used
				)
			end)
		elseif v:IsA("Model") then
			if v.ItemID then
				local clickdetector = Instance.new("ClickDetector",v)
				clickdetector.MouseClick:connect(function(player)
					game:GetService("MarketplaceService"):PromptPurchase(
						player,
						v.ItemID.Value, -- Item's assetId
						v:FindFirstChild("EquipGear") and v.EquipGear.Value or false, --If gear, whether it will be given immediately or not
						v:FindFirstChild("CurrencyType") and v.CurrencyType.Value or "Default" --If specified, then sets currency that will be used
					)
				end)
			else
				MakeBuyables(v)
			end
		end
	end
end

MakeBuyables(Workspace)