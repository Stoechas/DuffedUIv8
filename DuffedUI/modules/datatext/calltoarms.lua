local D, C, L = unpack(select(2, ...))

--------------------------------------------------------------------
 -- Call To Arms -- Elv22
--------------------------------------------------------------------

if C["datatext"].calltoarms and C["datatext"].calltoarms > 0 then
	local Stat = CreateFrame("Frame", "DuffedUIStatCallToArms")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("MEDIUM")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].calltoarms
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatCallToArmsText", "OVERLAY")
	Text:SetFontObject(font)
	Text:SetShadowOffset(D.mult, -D.mult)
	Text:SetShadowColor(0, 0, 0, 0.4)
	D.DataTextPosition(C["datatext"].calltoarms, Text)
	Stat:SetParent(Text:GetParent())
	
	local TANK_STRING = TANK
	local HEALER_STRING = HEALER
	local DPS_STING = DAMAGE
	local result = " %s %s %s"
	
	local function MakeString(tank, healer, damage, letter)
		local strtank = ""
		local strheal = ""
		local strdps = ""
		
		if tank then
			if letter then
				strtank = "T"
			else
				strtank = TANK_STRING
			end
		end
		if healer then
			if letter then
				strheal = "H"
			else
				strheal = HEALER_STRING
			end
		end
		if damage then
			if letter then
				strdps = "D"
			else
				strdps = DPS_STRING
			end
		end	
		
		return string.format(result, strtank, strheal, strdps)
	end

	local function OnEvent(self, event, ...)
		local tankReward = false
		local healerReward = false
		local dpsReward = false
		local unavailable = true		
		for i=1, GetNumRandomDungeons() do
			local id, name = GetLFGRandomDungeonInfo(i)
			for x = 1,LFG_ROLE_NUM_SHORTAGE_TYPES do
				local eligible, forTank, forHealer, forDamage, itemCount = GetLFGRoleShortageRewards(id, x)
				if eligible then unavailable = false end
				if eligible and forTank and itemCount > 0 then tankReward = true end
				if eligible and forHealer and itemCount > 0 then healerReward = true end
				if eligible and forDamage and itemCount > 0 then dpsReward = true end				
			end
		end	
		
		if unavailable then
			Text:SetText(Stat.Color1..QUEUE_TIME_UNAVAILABLE.."|r")
		else
			if tankReward or healerReward or dpsReward then
				Text:SetText(Stat.Color1..BATTLEGROUND_HOLIDAY..":|r"..Stat.Color2..MakeString(tankReward, healerReward, dpsReward, true).."|r")
			else
				Text:SetText(Stat.Color1..LOOKING_FOR_DUNGEON.."|r")
			end
		end
		
		self:SetAllPoints(Text)
	end

	local function OnEnter(self)
		local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(BATTLEGROUND_HOLIDAY)
		GameTooltip:AddLine(' ')
		
		local allUnavailable = true
		local numCTA = 0
		for i=1, GetNumRandomDungeons() do
			local id, name = GetLFGRandomDungeonInfo(i)
			local tankReward = false
			local healerReward = false
			local dpsReward = false
			local unavailable = true
			for x=1, LFG_ROLE_NUM_SHORTAGE_TYPES do
				local eligible, forTank, forHealer, forDamage, itemCount = GetLFGRoleShortageRewards(id, x)
				if eligible then unavailable = false end
				if eligible and forTank and itemCount > 0 then tankReward = true end
				if eligible and forHealer and itemCount > 0 then healerReward = true end
				if eligible and forDamage and itemCount > 0 then dpsReward = true end
			end
			if not unavailable then
				allUnavailable = false
				local rolesString = MakeString(tankReward, healerReward, dpsReward)
				if rolesString ~= "   "  then 
					GameTooltip:AddDoubleLine(name..":", rolesString, 1, 1, 1)
				end
				if tankReward or healerReward or dpsReward then numCTA = numCTA + 1 end
			end
		end
		
		if allUnavailable then 
			GameTooltip:AddLine(L["dt"]["cta_allunavailable"])
		elseif numCTA == 0 then 
			GameTooltip:AddLine(L["dt"]["cta_nodungeons"]) 
		end
		GameTooltip:Show()	
	end
    
	Stat:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() PVEFrame_ToggleFrame() end)
	Stat:SetScript("OnEnter", OnEnter)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end