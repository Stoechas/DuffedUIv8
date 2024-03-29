local D, C, L = unpack(select(2, ...))

-- Modified Script from Tukui T16
-- Credits got to Tukz & Hydra
local ObjectiveTracker = CreateFrame("Frame", "ObjectiveTracker", UIParent)
local lST = "Wowhead"
local lQ = "http://www.wowhead.com/quest=%d"
local lA = "http://www.wowhead.com/achievement=%d"

local DuffedUIWatchFrameAnchor = CreateFrame("Button", "DuffedUIWatchFrameAnchor", UIParent)
DuffedUIWatchFrameAnchor:SetFrameStrata("HIGH")
DuffedUIWatchFrameAnchor:SetFrameLevel(20)
DuffedUIWatchFrameAnchor:SetSize(ObjectiveTrackerFrame:GetWidth(), 20)
DuffedUIWatchFrameAnchor:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -D.ScreenHeight / 5, -D.ScreenHeight / 4)
DuffedUIWatchFrameAnchor:SetClampedToScreen(true)
DuffedUIWatchFrameAnchor:SetMovable(true)
DuffedUIWatchFrameAnchor:EnableMouse(false)
DuffedUIWatchFrameAnchor:SetTemplate("Default")
DuffedUIWatchFrameAnchor:SetBackdropBorderColor(1, 0, 0)
DuffedUIWatchFrameAnchor:SetAlpha(0)
DuffedUIWatchFrameAnchor.text = D.SetFontString(DuffedUIWatchFrameAnchor, C["media"].font, 11)
DuffedUIWatchFrameAnchor.text:SetPoint("CENTER")
DuffedUIWatchFrameAnchor.text:SetText(L["move"]["watchframe"])
DuffedUIWatchFrameAnchor.text:Hide()
tinsert(D.AllowFrameMoving, DuffedUIWatchFrameAnchor)

_G.StaticPopupDialogs["WATCHFRAME_URL"] = {
	text = lST .. " link",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 350,
	OnShow = function(self, ...) self.editBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

function ObjectiveTracker:SetQuestItemButton(block)
	local Button = block.itemButton

	if (Button and not Button.IsSkinned) then
		local Icon = Button.icon

		Button:SkinButton()
		Button:StyleButton()
		Icon:SetTexCoord(.1,.9,.1,.9)
		Icon:SetInside()
		Button.isSkinned = true
	end
end

function ObjectiveTracker:UpdatePopup()
	for i = 1, GetNumAutoQuestPopUps() do
		local questID, popUpType = GetAutoQuestPopUp(i)
		local questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, _ = GetQuestLogTitle(GetQuestLogIndexByID(questID))

		if (questTitle and questTitle ~= "") then
			local Block = AUTO_QUEST_POPUP_TRACKER_MODULE:GetBlock(questID)
			local ScrollChild = Block.ScrollChild

			if not ScrollChild.IsSkinned then
				ScrollChild:StripTextures()
				ScrollChild:CreateBackdrop("Transparent")
				ScrollChild.backdrop:Point("TOPLEFT", ScrollChild, "TOPLEFT", 48, -2)
				ScrollChild.backdrop:Point("BOTTOMRIGHT", ScrollChild, "BOTTOMRIGHT", -1, 2)
				ScrollChild.FlashFrame.IconFlash:Kill()
				ScrollChild.IsSkinned = true
			end
		end
	end
end

function ObjectiveTracker:AddHooks()
	hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", self.SetQuestItemButton)
	hooksecurefunc(AUTO_QUEST_POPUP_TRACKER_MODULE, "Update", self.UpdatePopup)
end

function ObjectiveTracker:WOWHead_Quest()
	hooksecurefunc("QuestObjectiveTracker_OnOpenDropDown", function(self)
		local _, b, i, info, questID
		b = self.activeFrame
		i = b.questLogIndex
		_, _, _, _, _, _, _, questID = GetQuestLogTitle(i)
		info = UIDropDownMenu_CreateInfo()
		info.text = lST .. "-Link"
		info.func = function(id)
			local inputBox = StaticPopup_Show("WATCHFRAME_URL")
			inputBox.editBox:SetText(lQ:format(questID))
			inputBox.editBox:HighlightText()
		end
		info.arg1 = questID
		info.noClickSound = 1
		info.checked = false
		UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
	end)
end

function ObjectiveTracker:WOWHead_Achievement()
	hooksecurefunc("AchievementObjectiveTracker_OnOpenDropDown", function(self)
		local _, b, i, info
		b = self.activeFrame
		i = b.id
		info = UIDropDownMenu_CreateInfo()
		info.text = lST .. "-Link"
		info.func = function(_, i)
			local inputBox = StaticPopup_Show("WATCHFRAME_URL")
			inputBox.editBox:SetText(lA:format(i))
			inputBox.editBox:HighlightText()
		end
		info.arg1 = i
		info.noClickSound = 1
		info.checked = false
		UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
	end)
end

function ObjectiveTracker:Enable()
	local Frame = ObjectiveTrackerFrame
	local Header = ObjectiveTrackerFrame.BlocksFrame.QuestHeader
	local Minimize = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
	local ScenarioStageBlock = ScenarioStageBlock

	ObjectiveTracker:Size(Frame:GetWidth(), 23)
	ObjectiveTracker:SetAllPoints(DuffedUIWatchFrameAnchor)
	Frame:SetParent(ObjectiveTracker)
	Frame:SetPoint("TOPRIGHT")
	Frame.ClearAllPoints = D.Dummy
	Frame.SetPoint = D.Dummy

	for i = 1, 5 do
		local Module = ObjectiveTrackerFrame.MODULES[i]
		if Module then
			local Header = Module.Header
			Header:StripTextures()
			Header:Show()
		end
	end
	ScenarioStageBlock:StripTextures()
	ScenarioStageBlock:SetHeight(50)
	Minimize:SkinCloseButton()
	ObjectiveTracker:AddHooks()
end

ObjectiveTracker:RegisterEvent("PLAYER_ENTERING_WORLD")
ObjectiveTracker:SetScript("OnEvent", function(self, event, ...)
	D.Delay(1, function()
		ObjectiveTracker:Enable()
		ObjectiveTracker:UnregisterEvent("PLAYER_ENTERING_WORLD")
		ObjectiveTracker:WOWHead_Quest()
		ObjectiveTracker:WOWHead_Achievement()
	end)
end)