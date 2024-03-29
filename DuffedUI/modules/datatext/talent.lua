﻿local D, C, L = unpack(select(2, ...))

if C["datatext"].talent and C["datatext"].talent > 0 then
	local Stat = CreateFrame("Frame", "DuffedUIStatTalent")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.talent
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))
 
	local font = D.Font(C["font"].datatext)
	local Text = Stat:CreateFontString("DuffedUIStatTalentText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C.datatext.talent, Text)
 
	local function Update(self)
		if not GetSpecialization() then
			Text:SetText(L["dt"]["talent"]) 
		else
			local tree = GetSpecialization()
			local spec = select(2,GetSpecializationInfo(tree)) or ""
			Text:SetText(Stat.Color1.."S:|r "..Stat.Color2..spec.."|r")
		end
		self:SetAllPoints(Text)
	end
 
	Stat:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	Stat:RegisterEvent("CONFIRM_TALENT_WIPE")
	Stat:RegisterEvent("PLAYER_TALENT_UPDATE")
	Stat:SetScript("OnEvent", Update)
	Stat:SetScript("OnMouseDown", function()
		local c = GetActiveSpecGroup(false,false)
		SetActiveSpecGroup(c == 1 and 2 or 1)
	end)
end