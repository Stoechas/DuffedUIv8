local D, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Transmogrify skin (written by shestak)
----------------------------------------------------------------------------------------

local function LoadSkin()
	TransmogrifyArtFrame:StripTextures()
	TransmogrifyArtFrame:SetTemplate("Transparent")
	TransmogrifyModelFrame:SetFrameLevel(TransmogrifyArtFrame:GetFrameLevel() + 2)

	local KillTextures = {
		"TransmogrifyModelFrameLines",
		"TransmogrifyModelFrameMarbleBg",
		"TransmogrifyFrameButtonFrameButtonBorder",
		"TransmogrifyFrameButtonFrameButtonBottomBorder",
		"TransmogrifyFrameButtonFrameMoneyLeft",
		"TransmogrifyFrameButtonFrameMoneyRight",
		"TransmogrifyFrameButtonFrameMoneyMiddle",
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	select(2, TransmogrifyModelFrame:GetRegions()):Kill()
	TransmogrifyFrameButtonFrame:GetRegions():Kill()

	TransmogrifyApplyButton:SkinButton(true)
	TransmogrifyApplyButton:Point("BOTTOMRIGHT", TransmogrifyFrame, "BOTTOMRIGHT", -4, 4)
	TransmogrifyArtFrameCloseButton:SkinCloseButton()

	local slots = {"Head", "Shoulder", "Chest", "Waist", "Legs", "Feet",
	"Wrist", "Hands", "Back", "MainHand", "SecondaryHand", "Ranged"}

	for _, slot in pairs(slots) do
		local icon = _G["TransmogrifyFrame"..slot.."SlotIconTexture"]
		local slot = _G["TransmogrifyFrame"..slot.."Slot"]
		
		if slot then
			slot:StripTextures()
			slot:StyleButton(false)
			slot:SetFrameLevel(slot:GetFrameLevel() + 2)
			slot:CreateBackdrop("Default")
			slot.backdrop:SetAllPoints()

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:Point("TOPLEFT", 2, -2)
			icon:Point("BOTTOMRIGHT", -2, 2)
		end
	end
	
	TransmogrifyConfirmationPopup:StripTextures()
	TransmogrifyConfirmationPopup:SetTemplate("Transparent")
	TransmogrifyConfirmationPopup.Button1:SkinButton()
	TransmogrifyConfirmationPopup.Button2:SkinButton()
end

D.SkinFuncs["Blizzard_ItemAlterationUI"] = LoadSkin