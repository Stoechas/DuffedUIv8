local D, C, L = unpack(select(2, ...)) 

--------------------------------------------------------------------
-- player power (attackpower or power depending on what you have more of)
--------------------------------------------------------------------

if C["datatext"].power and C["datatext"].power > 0 then
	local Stat = CreateFrame("Frame", "DuffedUIStatPower")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].power
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatPowerText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].power, Text)

	local int = 1
	local function Update(self, t)
		int = int - t
		if int < 0 then
			local base, posBuff, negBuff = UnitAttackPower("player")
			local effective = base + posBuff + negBuff
			local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player")
			local Reffective = Rbase + RposBuff + RnegBuff
			local currentSpec = GetSpecialization()
			local role = "None"
			local specname = "Unknown"
			local pwr = "---"
			local tp_pwr = ""

			if currentSpec then
				role = select(6, GetSpecializationInfo(currentSpec))
				specname = select(2, GetSpecializationInfo(currentSpec))
			end

			local healpwr = GetSpellBonusHealing()
			local Rattackpwr = Reffective
			local spellpwr2 = GetSpellBonusDamage(7)
			local attackpwr = effective

		if healpwr > spellpwr2 then
				spellpwr = healpwr
			else
				spellpwr = spellpwr2
			end

			if role ~= "None" then
				if (select(2, UnitClass("Player")) == "DRUID" and specname == "Balance") or (select(2, UnitClass("Player")) == "SHAMAN" and specname == "Elemental") then
					pwr = spellpwr
					tp_pwr = L["dt"]["sp"]
				elseif select(2, UnitClass("Player")) == "HUNTER" then
					pwr = Reffective
					tp_pwr = L["dt"]["ap"]
				elseif role == "HEALER" then
					pwr = spellpwr
					tp_pwr = L["dt"]["sp"]
				elseif spellpwr >= attackpwr then
					pwr = spellpwr
					tp_pwr = L["dt"]["sp"]
				else
					pwr = attackpwr
					tp_pwr = L["dt"]["ap"]
				end
			end
			Text:SetText(Stat.Color2..pwr.." |r".. Stat.Color1..tp_pwr.."|r")      
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end