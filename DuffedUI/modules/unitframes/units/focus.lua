local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local _, Class = UnitClass("player")

function DuffedUIUnitFrames:Focus()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(17)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C["medias"].Normal)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(0.1, 0.1, 0.1)

	-- Border for Health
	local HealthBorder = CreateFrame("Frame", nil, Health)
	HealthBorder:SetPoint("TOPLEFT", Health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	HealthBorder:SetTemplate("Default")
	HealthBorder:CreateShadow("Default")
	HealthBorder:SetFrameLevel(2)

	Health:FontString("Value", C["medias"].Font, 12, "THINOUTLINE")
	Health.Value:Point("RIGHT", Health, "RIGHT", 0, 1)

	Health.frequentUpdates = true
	Health.colorDisconnected = true
	Health.colorTapping = true
	Health.colorClass = true
	Health.colorReaction = true

	Health.PostUpdate = DuffedUIUnitFrames.PostUpdateHealth

	if C["unitframes"].UniColor == true then
		Health.colorDisconnected = false
		Health.colorClass = false
		Health.colorReaction = false
		Health:SetStatusBarColor(unpack(C["unitframes"].HealthBarColor))
		Health.Background:SetVertexColor(unpack(C["unitframes"].HealthBGColor))
	else
		Health.colorDisconnected = true
		Health.colorClass = true
		Health.colorReaction = true
		Health.Background:SetTexture(.1, .1, .1)
	end
	if (C["unitframes"].Smooth) then Health.Smooth = true end

	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(3)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 85, 0)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", -9, -3)
	Power:SetStatusBarTexture(C["medias"].Normal)
	Power:SetFrameLevel(Health:GetFrameLevel() + 2)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(C["medias"].Normal)
	Power.Background.multiplier = 0.3

	-- Border for Power
	local PowerBorder = CreateFrame("Frame", nil, Power)
	PowerBorder:SetPoint("TOPLEFT", Power, "TOPLEFT", D.Scale(-2), D.Scale(2))
	PowerBorder:SetPoint("BOTTOMRIGHT", Power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	PowerBorder:SetTemplate("Default")
	PowerBorder:CreateShadow("Default")
	PowerBorder:SetFrameLevel(Health:GetFrameLevel() + 1)

	Power:FontString("Value", C["medias"].Font, 12, "THINOUTLINE")
	Power.Value:Point("RIGHT", Health, "RIGHT", -2, 0)
	Power.Value:Hide()

	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("LEFT", Health, "LEFT", 2, 1)
	Name:SetJustifyH("CENTER")
	Name:SetFont(C["medias"].Font, 12, "THINOUTLINE")
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(D.Mult, -D.Mult)
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong]")

	local CastBar = CreateFrame("StatusBar", nil, self)
	CastBar:SetPoint("LEFT", 2, 0)
	CastBar:SetPoint("RIGHT", -24, 0)
	CastBar:SetPoint("BOTTOM", 0, -22)
	CastBar:SetHeight(16)
	CastBar:SetStatusBarTexture(C["medias"].Normal)
	CastBar:SetFrameLevel(6)

	CastBar.Background = CreateFrame("Frame", nil, CastBar)
	CastBar.Background:SetTemplate("Default")
	CastBar.Background:SetBackdropBorderColor(C["medias"].BorderColor[1] * 0.7, C["medias"].BorderColor[2] * 0.7, C["medias"].BorderColor[3] * 0.7)
	CastBar.Background:Point("TOPLEFT", -2, 2)
	CastBar.Background:Point("BOTTOMRIGHT", 2, -2)
	CastBar.Background:SetFrameLevel(5)

	-- Border for CastBar
	local CastBarBorder = CreateFrame("Frame", nil, CastBar)
	CastBarBorder:SetPoint("TOPLEFT", CastBar, "TOPLEFT", D.Scale(-2), D.Scale(2))
	CastBarBorder:SetPoint("BOTTOMRIGHT", CastBar, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	CastBarBorder:SetTemplate("Default")
	CastBarBorder:CreateShadow("Default")
	CastBarBorder:SetFrameLevel(2)

	CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
	CastBar.Time:SetFont(C["medias"].Font, 12)
	CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
	CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
	CastBar.Time:SetJustifyH("RIGHT")

	CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
	CastBar.Text:SetFont(C["medias"].Font, 12)
	CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
	CastBar.Text:SetTextColor(0.84, 0.75, 0.65)

	CastBar.Button = CreateFrame("Frame", nil, CastBar)
	CastBar.Button:Size(20, 20)
	CastBar.Button:SetTemplate()
	CastBar.Button:SetPoint("LEFT", CastBar, "RIGHT", 4, 0)
	CastBar.Button:SetBackdropBorderColor(C["medias"].BorderColor[1] * 0.7, C["medias"].BorderColor[2] * 0.7, C["medias"].BorderColor[3] * 0.7)
	CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
	CastBar.Icon:SetInside()
	CastBar.Icon:SetTexCoord(unpack(D.IconCoord))

	CastBar.CustomTimeText = DuffedUIUnitFrames.CustomCastTimeText
	CastBar.CustomDelayText = DuffedUIUnitFrames.CustomCastDelayText
	CastBar.PostCastStart = DuffedUIUnitFrames.CheckCast
	CastBar.PostChannelStart = DuffedUIUnitFrames.CheckChannel

	self.Castbar = CastBar
	self.Castbar.Icon = CastBar.Icon
	self.CastBarBorder = CastBarBorder

	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Power = Power
	self.Power.bg = Power.Background
	self.PowerBorder = PowerBorder
	self.Name = Name
end