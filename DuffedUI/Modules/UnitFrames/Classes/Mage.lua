local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:AddMageFeatures()
	local ArcaneChargeBar = CreateFrame("Frame", nil, self)
	
	-- Arcane Charges
	ArcaneChargeBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	ArcaneChargeBar:Size(250, 8)
	ArcaneChargeBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	ArcaneChargeBar:SetBackdropColor(0, 0, 0)
	ArcaneChargeBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		ArcaneChargeBar[i] = CreateFrame("StatusBar", nil, ArcaneChargeBar)
		ArcaneChargeBar[i]:Height(8)
		ArcaneChargeBar[i]:SetStatusBarTexture(C.Media.Normal)
		ArcaneChargeBar[i].bg = ArcaneChargeBar[i]:CreateTexture(nil, 'ARTWORK')

		if i == 1 then
			ArcaneChargeBar[i]:Width((250 / 4) - 2)
			ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar, "LEFT", 0, 0)
		else
			ArcaneChargeBar[i]:Width((250 / 4 - 1))
			ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar[i-1], "RIGHT", 1, 0)
		end
	end
	
	-- Shadow Effect Updates
	ArcaneChargeBar:SetScript("OnShow", function(self) 
		TukuiUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	ArcaneChargeBar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)

	self.ArcaneChargeBar = ArcaneChargeBar
end