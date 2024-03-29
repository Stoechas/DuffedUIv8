local D, C, L = unpack(select(2, ...)) 
if not C["actionbar"].enable == true then return end

local bar = DuffedUIBar3
MultiBarBottomRight:SetParent(bar)

for i = 1, 12 do
	local b = _G["MultiBarBottomRightButton" .. i]
	local b2 = _G["MultiBarBottomRightButton" .. i - 1]
	b:SetSize((D.buttonsize - 4), (D.buttonsize - 4))
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)

	if i == 1 then
		b:SetPoint("TOPLEFT", bar, D.buttonspacing, -D.buttonspacing)
	elseif i == 7 then
		b:SetPoint("TOPRIGHT", bar, -D.buttonspacing, -D.buttonspacing)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -D.buttonspacing)
	end
end
RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")

if C["actionbar"].sidebars then
	function LeftSideBar(alpha)
		DuffedUIBar3:SetAlpha(alpha)
		MultiBarBottomRight:SetAlpha(alpha)
	end

	local function mouseover(f)
		f:EnableMouse(true)
		f:SetAlpha(0)
		f:HookScript("OnEnter", function() LeftSideBar(1) end)
		f:HookScript("OnLeave", function() LeftSideBar(0) end)
	end
	mouseover(DuffedUIBar3)

	for i = 1, 12 do
		_G["MultiBarBottomRightButton" .. i]:EnableMouse(true)
		_G["MultiBarBottomRightButton" .. i]:HookScript("OnEnter", function() LeftSideBar(1) end)
		_G["MultiBarBottomRightButton" .. i]:HookScript("OnLeave", function() LeftSideBar(0) end)
	end
end