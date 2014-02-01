local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PALADIN") then
	return
end

function DuffedUIUnitFrames:AddPaladinFeatures()
	local HPBar = CreateFrame("Frame", nil, self)
	local Shadow = self.Shadow
	
	-- Holy Power
	HPBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	HPBar:Size(250, 8)
	HPBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	HPBar:SetBackdropColor(0, 0, 0)
	HPBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		HPBar[i] = CreateFrame("StatusBar", nil, HPBar)
		HPBar[i]:Height(8)
		HPBar[i]:SetStatusBarTexture(C["medias"].Normal)
		HPBar[i]:SetStatusBarColor(0.89, 0.88, 0.06)

		if i == 1 then
			HPBar[i]:Width(50)
			HPBar[i]:Point("LEFT", HPBar, "LEFT", 0, 0)
		else
			HPBar[i]:Width(49)
			HPBar[i]:Point("LEFT", HPBar[i-1], "RIGHT", 1, 0)
		end
	end
	
	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)
	
	HPBar:SetScript("OnShow", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	HPBar:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)
	
	-- Register
	self.HolyPower = HPBar
end