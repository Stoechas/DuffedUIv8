local D, C, L = unpack(select(2, ...)) 

local filter = {
	[6289]  = true, -- Raw Longjaw Mud Snapper
	[6291]  = true, -- Raw Brilliant Smallfish
	[6308]  = true, -- Raw Bristle Whisker Catfish
	[6309]  = true, -- 17 Pound Catfish
	[6310]  = true, -- 19 Pound Catfish
	[41808] = true, -- Bonescale Snapper
	[42336] = true, -- Bloodstone Band
	[42337] = true, -- Sun Rock Ring
	[43244] = true, -- Crystal Citrine Necklace
	[43571] = true, -- Sewer Carp
	[43572] = true, -- Magic Eater
}

local f = CreateFrame("Frame", "DuffedUIMerchant")
f:SetScript("OnEvent", function()
	if C["merchant"].sellgrays or C["merchant"].sellmisc then
		local c = 0
		for b = 0, 4 do
			for s = 1, GetContainerNumSlots(b) do
				local l,lid = GetContainerItemLink(b, s), GetContainerItemID(b, s)
				if l and lid then
					local p = 0
					local mult1, mult2 = select(11, GetItemInfo(l)), select(2, GetContainerItemInfo(b, s))
					if mult1 and mult2 then p = mult1 * mult2 end
					if C["merchant"].sellgrays and select(3, GetItemInfo(l)) == 0 and p > 0 then
						UseContainerItem(b, s)
						PickupMerchantItem()
						c = c + p
					end
					if C["merchant"].sellmisc and filter[lid] then
						UseContainerItem(b, s)
						PickupMerchantItem()
						c = c + p
					end
				end
			end
		end
		if c > 0 then
			local g, s, c = math.floor(c / 10000) or 0, math.floor((c%10000) / 100) or 0, c%100
			DEFAULT_CHAT_FRAME:AddMessage(L["loot"]["trash"] .. " |cffffffff" .. g .. "|cffffd700g|r" .. " |cffffffff" .. s .. "|cffc7c7cfs|r" .. " |cffffffff" .. c .. "|cffeda55fc|r" .. ".", 255, 255, 0)
		end
	end
	if CanMerchantRepair() and C["merchant"].autorepair then
		local Cost = GetRepairAllCost()
		local c = Cost%100
		local s = math.floor((Cost%10000) / 100)
		local g = math.floor(Cost / 10000)
		if GetGuildBankWithdrawMoney() >= Cost and C["merchant"].autoguildrepair then
			RepairAllItems(1)
			DEFAULT_CHAT_FRAME:AddMessage(L["loot"]["repaircost"] .. " (" .. GUILD .. ") |cffffffff" .. g .. "|cffffd700g|r" .. " |cffffffff" .. s .. "|cffc7c7cfs|r" .. " |cffffffff" .. c .. "|cffeda55fc|r" .. ".", 255, 255, 0)
		elseif GetMoney() >= Cost then
			RepairAllItems()
			DEFAULT_CHAT_FRAME:AddMessage(L["loot"]["repaircost"] .. " |cffffffff" .. g .. "|cffffd700g|r" .. " |cffffffff" .. s .. "|cffc7c7cfs|r" .. " |cffffffff" .. c .. "|cffeda55fc|r" .. ".", 255, 255, 0)
		else
			DEFAULT_CHAT_FRAME:AddMessage(L["loot"]["repairmoney"], 255, 0, 0)
		end
	end
end)
f:RegisterEvent("MERCHANT_SHOW")

local savedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
function MerchantItemButton_OnModifiedClick(self, ...)
	if IsAltKeyDown() then
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))
		if maxStack and maxStack > 1 then BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID())) end
	end
	savedMerchantItemButton_OnModifiedClick(self, ...)
end