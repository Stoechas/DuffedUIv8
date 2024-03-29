local D, C, L = unpack(select(2, ...))
--	Void Storage skin (written by shestak)

local function LoadSkin()
	local StripAllTextures = {
		"VoidStorageBorderFrame",
		"VoidStorageDepositFrame",
		"VoidStorageWithdrawFrame",
		"VoidStorageCostFrame",
		"VoidStorageStorageFrame",
		"VoidStoragePurchaseFrame",
		"VoidItemSearchBox",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local page = {
		"Page1",
		"Page2",
	}

	for _, v in pairs(page) do
		VoidStorageFrame[v]:StripTextures()
		VoidStorageFrame[v]:SetTemplate()
		VoidStorageFrame[v]:StyleButton()
		VoidStorageFrame[v]:Point("LEFT", VoidStorageFrame, "RIGHT", 3, 150)
	end
	VoidStorageFrame.Page1.texture = VoidStorageFrame.Page1:CreateTexture(nil, "OVERLAY")
	VoidStorageFrame.Page1.texture:SetTexture([[Interface\Icons\INV_Enchant_EssenceCosmicGreater]])
	VoidStorageFrame.Page1.texture:SetTexCoord(unpack(D.IconCoord))
	VoidStorageFrame.Page1.texture:SetInside()
	VoidStorageFrame.Page2.texture = VoidStorageFrame.Page2:CreateTexture(nil, "OVERLAY")
	VoidStorageFrame.Page2.texture:SetTexture([[Interface\Icons\INV_Enchant_EssenceArcaneLarge]])
	VoidStorageFrame.Page2.texture:SetTexCoord(unpack(D.IconCoord))
	VoidStorageFrame.Page2.texture:SetInside()

	VoidStorageFrame:SetTemplate("Transparent")
	VoidStoragePurchaseFrame:SetTemplate("Transparent")
	VoidStorageFrameMarbleBg:Kill()
	VoidStorageFrameLines:Kill()
	select(2, VoidStorageFrame:GetRegions()):Kill()

	VoidStoragePurchaseButton:SkinButton()
	VoidStorageHelpBoxButton:SkinButton()
	VoidStorageTransferButton:SkinButton()

	VoidStorageBorderFrame.CloseButton:SkinCloseButton()
	VoidItemSearchBox:CreateBackdrop("Overlay")
	VoidItemSearchBox.backdrop:Point("TOPLEFT", 10, -1)
	VoidItemSearchBox.backdrop:Point("BOTTOMRIGHT", 4, 1)

	for i = 1, 9 do
		local button_d = _G["VoidStorageDepositButton" .. i]
		local button_w = _G["VoidStorageWithdrawButton" .. i]
		local icon_d = _G["VoidStorageDepositButton" .. i .. "IconTexture"]
		local icon_w = _G["VoidStorageWithdrawButton" .. i .. "IconTexture"]

		_G["VoidStorageDepositButton" .. i .. "Bg"]:Hide()
		_G["VoidStorageWithdrawButton" .. i .. "Bg"]:Hide()

		button_d:StyleButton()
		button_d:SetTemplate()

		button_w:StyleButton()
		button_w:SetTemplate()

		icon_d:SetTexCoord(.1, .9, .1, .9)
		icon_d:ClearAllPoints()
		icon_d:Point("TOPLEFT", 2, -2)
		icon_d:Point("BOTTOMRIGHT", -2, 2)

		icon_w:SetTexCoord(.1, .9, .1, .9)
		icon_w:ClearAllPoints()
		icon_w:Point("TOPLEFT", 2, -2)
		icon_w:Point("BOTTOMRIGHT", -2, 2)
	end

	for i = 1, 80 do
		local button = _G["VoidStorageStorageButton" .. i]
		local icon = _G["VoidStorageStorageButton" .. i .. "IconTexture"]

		_G["VoidStorageStorageButton"..i.."Bg"]:Hide()

		button:StyleButton()
		button:SetTemplate()

		icon:SetTexCoord(.1, .9, .1, .9)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)
	end

	-- dress
	SideDressUpFrame:StripTextures(true)
	SideDressUpFrame:CreateBackdrop()

	SideDressUpModelResetButton:SkinButton()
	SideDressUpModelCloseButton:StripTextures()
	SideDressUpModelCloseButton:SkinCloseButton()
end

D.SkinFuncs["Blizzard_VoidStorageUI"] = LoadSkin