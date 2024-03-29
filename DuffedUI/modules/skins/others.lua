local D, C, L = unpack(select(2, ...))

local function LoadSkin()
	local skins = {
		"StaticPopup1",
		"StaticPopup2",
		"StaticPopup3",
		"StaticPopup4",
		"GameMenuFrame",
		"InterfaceOptionsFrame",
		"VideoOptionsFrame",
		"AudioOptionsFrame",
		"LFDDungeonReadyStatus",
		"TicketStatusFrameButton",
		"LFDSearchStatus",
		"AutoCompleteBox",
		"ConsolidatedBuffsTooltip",
		"ReadyCheckFrame",
		"StackSplitFrame",
		"CharacterFrame",
		"VoiceChatTalkers"
	}

	for i = 1, getn(skins) do
		if _G[skins[i]] then _G[skins[i]]:SetTemplate("Transparent") end
	end

	LFDRoleCheckPopup:StripTextures()
	LFDRoleCheckPopup:SetTemplate("Transparent")
	LFDRoleCheckPopupAcceptButton:SkinButton()
	LFDRoleCheckPopupDeclineButton:SkinButton()
	LFDRoleCheckPopupRoleButtonTank:GetChildren():SkinCheckBox()
	LFDRoleCheckPopupRoleButtonDPS:GetChildren():SkinCheckBox()
	LFDRoleCheckPopupRoleButtonHealer:GetChildren():SkinCheckBox()
	LFDRoleCheckPopupRoleButtonTank:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonTank:GetChildren():GetFrameLevel() + 1)
	LFDRoleCheckPopupRoleButtonDPS:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonDPS:GetChildren():GetFrameLevel() + 1)
	LFDRoleCheckPopupRoleButtonHealer:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonHealer:GetChildren():GetFrameLevel() + 1)

	CinematicFrameCloseDialog:SetTemplate("Transparent")
	CinematicFrameCloseDialog:SetScale(C["general"].uiscale)
	CinematicFrameCloseDialogConfirmButton:SkinButton()
	CinematicFrameCloseDialogResumeButton:SkinButton()

	ReportCheatingDialog:StripTextures()
	ReportCheatingDialog:SetTemplate("Transparent")
	ReportCheatingDialogReportButton:SkinButton()
	ReportCheatingDialogCancelButton:SkinButton()
	ReportCheatingDialogCommentFrame:StripTextures()
	ReportCheatingDialogCommentFrameEditBox:SkinEditBox()

	ReportPlayerNameDialog:StripTextures()
	ReportPlayerNameDialog:SetTemplate("Transparent")
	ReportPlayerNameDialogReportButton:SkinButton()
	ReportPlayerNameDialogCancelButton:SkinButton()
	ReportPlayerNameDialogCommentFrame:StripTextures()
	ReportPlayerNameDialogCommentFrameEditBox:SkinEditBox()

	for i = 1, 4 do
		for j = 1, 3 do
			_G["StaticPopup" .. i .. "Button" .. j]:SkinButton()
			_G["StaticPopup" .. i .. "EditBox"]:SkinEditBox()
			_G["StaticPopup" .. i .. "MoneyInputFrameGold"]:SkinEditBox()
			_G["StaticPopup" .. i .. "MoneyInputFrameSilver"]:SkinEditBox()
			_G["StaticPopup" .. i .. "MoneyInputFrameCopper"]:SkinEditBox()
			_G["StaticPopup" .. i .. "EditBox"].backdrop:Point("TOPLEFT", -2, -4)
			_G["StaticPopup" .. i .. "EditBox"].backdrop:Point("BOTTOMRIGHT", 2, 4)
			_G["StaticPopup" .. i .. "ItemFrameNameFrame"]:Kill()
			_G["StaticPopup" .. i .. "ItemFrame"]:GetNormalTexture():Kill()
			_G["StaticPopup" .. i .. "ItemFrame"]:SetTemplate("Default")
			_G["StaticPopup" .. i .. "ItemFrame"]:StyleButton()
			_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:SetTexCoord(.08, .92, .08, .92)
			_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:ClearAllPoints()
			_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:Point("TOPLEFT", 2, -2)
			_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:Point("BOTTOMRIGHT", -2, 2)
		end
	end

	local BlizzardMenuButtons = {
		"Options", 
		"SoundOptions", 
		"UIOptions", 
		"Keybindings", 
		"Macros",
		"Ratings",
		"AddOns", 
		"Logout", 
		"Quit", 
		"Continue", 
		"MacOptions",
		"Store",
		"Help",
		"WhatsNew",
		"Addons"
	}

	for i = 1, getn(BlizzardMenuButtons) do
		local button = _G["GameMenuButton"..BlizzardMenuButtons[i]]
		if button then button:SkinButton() end
	end

	if IsAddOnLoaded("OptionHouse") then GameMenuButtonOptionHouse:SkinButton() end

	local BlizzardHeader = {
		"GameMenuFrame", 
		"InterfaceOptionsFrame", 
		"AudioOptionsFrame", 
		"VideoOptionsFrame",
	}

	for i = 1, getn(BlizzardHeader) do
		local title = _G[BlizzardHeader[i].."Header"]
		if title then
			title:SetTexture("")
			title:ClearAllPoints()
			if title == _G["GameMenuFrameHeader"] then title:SetPoint("TOP", GameMenuFrame, 0, 7) else title:SetPoint("TOP", BlizzardHeader[i], 0, 0) end
		end
	end

	if GameMenuFrame_UpdateVisibleButtons then
		hooksecurefunc("GameMenuFrame_UpdateVisibleButtons", function()
			GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + GameMenuButtonStore:GetHeight())
			if IsAddOnLoaded("Enhanced_Config") then GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + GameMenuButtonStore:GetHeight()) end
		end)
	end

	local BlizzardButtons = {
		"VideoOptionsFrameOkay", 
		"VideoOptionsFrameCancel", 
		"VideoOptionsFrameDefaults", 
		"VideoOptionsFrameApply", 
		"AudioOptionsFrameOkay", 
		"AudioOptionsFrameCancel", 
		"AudioOptionsFrameDefaults", 
		"InterfaceOptionsFrameDefaults", 
		"InterfaceOptionsFrameOkay", 
		"InterfaceOptionsFrameCancel",
		"ReadyCheckFrameYesButton",
		"ReadyCheckFrameNoButton",
		"StackSplitOkayButton",
		"StackSplitCancelButton",
		"RolePollPopupAcceptButton",
		"InterfaceOptionsHelpPanelResetTutorials",
		"CompactUnitFrameProfilesGeneralOptionsFrameResetPositionButton",
	}

	for i = 1, getn(BlizzardButtons) do
		local Buttons = _G[BlizzardButtons[i]]
		if Buttons then Buttons:SkinButton() end
	end

	_G["VideoOptionsFrameCancel"]:ClearAllPoints()
	_G["VideoOptionsFrameCancel"]:SetPoint("RIGHT",_G["VideoOptionsFrameApply"],"LEFT",-4,0)
	_G["VideoOptionsFrameOkay"]:ClearAllPoints()
	_G["VideoOptionsFrameOkay"]:SetPoint("RIGHT",_G["VideoOptionsFrameCancel"],"LEFT",-4,0)	
	_G["AudioOptionsFrameOkay"]:ClearAllPoints()
	_G["AudioOptionsFrameOkay"]:SetPoint("RIGHT",_G["AudioOptionsFrameCancel"],"LEFT",-4,0)
	_G["InterfaceOptionsFrameOkay"]:ClearAllPoints()
	_G["InterfaceOptionsFrameOkay"]:SetPoint("RIGHT",_G["InterfaceOptionsFrameCancel"],"LEFT", -4,0)
	_G["ReadyCheckFrameYesButton"]:SetParent(_G["ReadyCheckFrame"])
	_G["ReadyCheckFrameNoButton"]:SetParent(_G["ReadyCheckFrame"])
	_G["ReadyCheckFrameYesButton"]:ClearAllPoints()
	_G["ReadyCheckFrameNoButton"]:ClearAllPoints()
	_G["ReadyCheckFrameYesButton"]:SetPoint("RIGHT", _G["ReadyCheckFrame"], "CENTER", -2, -20)
	_G["ReadyCheckFrameNoButton"]:SetPoint("LEFT", _G["ReadyCheckFrameYesButton"], "RIGHT", 3, 0)
	_G["ReadyCheckFrameText"]:SetParent(_G["ReadyCheckFrame"])	
	_G["ReadyCheckFrameText"]:ClearAllPoints()
	_G["ReadyCheckFrameText"]:SetPoint("TOP", 0, -12)

	_G["ReadyCheckListenerFrame"]:SetAlpha(0)
	_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end)
	_G["StackSplitFrame"]:GetRegions():Hide()
	_G["GeneralDockManagerOverflowButtonList"]:SetTemplate()

	RolePollPopup:SetTemplate("Default")
	RolePollPopupCloseButton:SkinCloseButton()

	BasicScriptErrors:StripTextures()
	BasicScriptErrors:SetTemplate()
	BasicScriptErrorsButton:SkinButton()
	BasicScriptErrors:SetScale(C["general"].uiscale)

	for i = 1, 4 do
		local button = _G["StaticPopup" .. i .. "CloseButton"]
		button:SetNormalTexture("")
		button.SetNormalTexture = D.Dummy
		button:SetPushedTexture("")
		button.SetPushedTexture = D.Dummy
		button:SkinCloseButton()
	end
    
	local frames = {
		"VideoOptionsFrameCategoryFrame",
		"VideoOptionsFramePanelContainer",
		"Display_",
		"Graphics_",
		"RaidGraphics_",
		"InterfaceOptionsFrameCategories",
		"InterfaceOptionsFramePanelContainer",
		"InterfaceOptionsFrameAddOns",
		"AudioOptionsSoundPanelPlayback",
		"AudioOptionsSoundPanelVolume",
		"AudioOptionsSoundPanelHardware",
		"AudioOptionsVoicePanelTalking",
		"AudioOptionsVoicePanelBinding",
		"AudioOptionsVoicePanelListening",
	}

	for i = 1, getn(frames) do
		local SkinFrames = _G[frames[i]]
		if SkinFrames then
			SkinFrames:StripTextures()
			SkinFrames:CreateBackdrop("Transparent")
			if SkinFrames ~= _G["VideoOptionsFramePanelContainer"] and SkinFrames ~= _G["InterfaceOptionsFramePanelContainer"] then
				SkinFrames.backdrop:Point("TOPLEFT",-1,0)
				SkinFrames.backdrop:Point("BOTTOMRIGHT",0,1)
			else
				SkinFrames.backdrop:Point("TOPLEFT", 0, 0)
				SkinFrames.backdrop:Point("BOTTOMRIGHT", 0, 0)
			end
		end
	end

	local interfacetab = {
		"InterfaceOptionsFrameTab1",
		"InterfaceOptionsFrameTab2",
	}

	for i = 1, getn(interfacetab) do
		local itab = _G[interfacetab[i]]
		if itab then
			itab:StripTextures()
			itab:SkinTab()
		end
	end
	InterfaceOptionsFrameTab1:ClearAllPoints()
	InterfaceOptionsFrameTab1:SetPoint("BOTTOMLEFT",InterfaceOptionsFrameCategories,"TOPLEFT",-11,-2)

	VideoOptionsFrameDefaults:ClearAllPoints()
	InterfaceOptionsFrameDefaults:ClearAllPoints()
	InterfaceOptionsFrameCancel:ClearAllPoints()
	VideoOptionsFrameDefaults:SetPoint("TOPLEFT",VideoOptionsFrameCategoryFrame,"BOTTOMLEFT",-1,-5)
	InterfaceOptionsFrameDefaults:SetPoint("TOPLEFT",InterfaceOptionsFrameCategories,"BOTTOMLEFT",-1,-5)
	InterfaceOptionsFrameCancel:SetPoint("TOPRIGHT",InterfaceOptionsFramePanelContainer,"BOTTOMRIGHT",0,-6)

	local interfacecheckbox = {
		-- Controls
		"ControlsPanelStickyTargeting",
		"ControlsPanelAutoDismount",
		"ControlsPanelAutoClearAFK",
		"ControlsPanelBlockTrades",
		"ControlsPanelBlockGuildInvites",
		"ControlsPanelBlockChatChannelInvites",
		"ControlsPanelLootAtMouse",
		"ControlsPanelAutoLootCorpse",
		"ControlsPanelAutoOpenLootHistory",
		"ControlsPanelInteractOnLeftClick",
		"ControlsPanelReverseCleanUpBags",
		"ControlsPanelReverseNewLoot",
		-- Combat
		"CombatPanelAttackOnAssist",
		"CombatPanelStopAutoAttack",
		"CombatPanelNameplateClassColors",
		"CombatPanelTargetOfTarget",
		"CombatPanelShowSpellAlerts",
		"CombatPanelReducedLagTolerance",
		"CombatPanelActionButtonUseKeyDown",
		"CombatPanelLossOfControl",
		"CombatPanelEnemyCastBarsOnPortrait",
		"CombatPanelEnemyCastBarsOnNameplates",
		"CombatPanelEnemyCastBarsOnOnlyTargetNameplates",
		"CombatPanelEnemyCastBarsNameplateSpellNames",
		"CombatPanelAutoSelfCast",
		-- Display
		"DisplayPanelShowCloak",
		"DisplayPanelShowHelm",
		"DisplayPanelShowAggroPercentage",
		"DisplayPanelPlayAggroSounds",
		"DisplayPanelDetailedLootInfo",
		"DisplayPanelShowSpellPointsAvg",
		"DisplayPanelemphasizeMySpellEffects",
		"DisplayPanelShowFreeBagSpace",
		"DisplayPanelCinematicSubtitles",
		"DisplayPanelRotateMinimap",
		"DisplayPanelScreenEdgeFlash",
		--Objectives
		"ObjectivesPanelAutoQuestTracking",
		"ObjectivesPanelMapFade",
		-- Social
		"SocialPanelProfanityFilter",
		"SocialPanelSpamFilter",
		"SocialPanelChatBubbles",
		"SocialPanelPartyChat",
		"SocialPanelChatHoverDelay",
		"SocialPanelGuildMemberAlert",
		"SocialPanelChatMouseScroll",
		"SocialPanelWholeChatWindowClickable",
		-- Action bars
		"ActionBarsPanelBottomLeft",
		"ActionBarsPanelBottomRight",
		"ActionBarsPanelRight",
		"ActionBarsPanelRightTwo",
		"ActionBarsPanelLockActionBars",
		"ActionBarsPanelAlwaysShowActionBars",
		"ActionBarsPanelSecureAbilityToggle",
		"ActionBarsPanelCountdownCooldowns",
		-- Names
		"NamesPanelMyName",
		"NamesPanelMinus",
		"NamesPanelFriendlyPlayerNames",
		"NamesPanelFriendlyPets",
		"NamesPanelFriendlyGuardians",
		"NamesPanelFriendlyTotems",
		"NamesPanelUnitNameplatesFriends",
		"NamesPanelUnitNameplatesFriendlyGuardians",
		"NamesPanelUnitNameplatesFriendlyPets",
		"NamesPanelUnitNameplatesFriendlyTotems",
		"NamesPanelGuilds",
		"NamesPanelGuildTitles",
		"NamesPanelTitles",
		"NamesPanelNonCombatCreature",
		"NamesPanelEnemyPlayerNames",
		"NamesPanelEnemyPets",
		"NamesPanelEnemyGuardians",
		"NamesPanelEnemyTotems",
		"NamesPanelUnitNameplatesEnemyPets",
		"NamesPanelUnitNameplatesEnemies",
		"NamesPanelUnitNameplatesEnemyGuardians",
		"NamesPanelUnitNameplatesEnemyTotems",
		"NamesPanelUnitNameplatesEnemyMinus",
		-- Combat Text
		"CombatTextPanelTargetDamage",
		"CombatTextPanelPeriodicDamage",
		"CombatTextPanelPetDamage",
		"CombatTextPanelHealing",
		"CombatTextPanelTargetEffects",
		"CombatTextPanelOtherTargetEffects",
		"CombatTextPanelEnableFCT",
		"CombatTextPanelDodgeParryMiss",
		"CombatTextPanelDamageReduction",
		"CombatTextPanelRepChanges",
		"CombatTextPanelReactiveAbilities",
		"CombatTextPanelFriendlyHealerNames",
		"CombatTextPanelCombatState",
		"CombatTextPanelComboPoints",
		"CombatTextPanelLowManaHealth",
		"CombatTextPanelEnergyGains",
		"CombatTextPanelPeriodicEnergyGains",
		"CombatTextPanelHonorGains",
		"CombatTextPanelAuras",
		"CombatTextPanelAutoSelfCast",
		-- Status Text
		"StatusTextPanelPlayer",
		"StatusTextPanelPet",
		"StatusTextPanelParty",
		"StatusTextPanelTarget",
		"StatusTextPanelAlternateResource",
		"StatusTextPanelPercentages",
		"StatusTextPanelXP",
		-- Unit Frames
		"UnitFramePanelPartyPets",
		"UnitFramePanelArenaEnemyFrames",
		"UnitFramePanelArenaEnemyCastBar",
		"UnitFramePanelArenaEnemyPets",
		"UnitFramePanelFullSizeFocusFrame",
		-- Buffs & Debuffs
		"BuffsPanelBuffDurations",
		"BuffsPanelDispellableDebuffs",
		"BuffsPanelCastableBuffs",
		"BuffsPanelConsolidateBuffs",
		"BuffsPanelShowAllEnemyDebuffs",
		--Battle net
		"BattlenetPanelOnlineFriends",
		"BattlenetPanelOfflineFriends",
		"BattlenetPanelBroadcasts",
		"BattlenetPanelFriendRequests",
		"BattlenetPanelConversations",
		"BattlenetPanelShowToastWindow",
		-- Camera
		"CameraPanelFollowTerrain",
		"CameraPanelHeadBob",
		"CameraPanelWaterCollision",
		"CameraPanelSmartPivot",
		-- Mouse
		"MousePanelInvertMouse",
		"MousePanelClickToMove",
		"MousePanelWoWMouse",
		"MousePanelEnableMouseSpeed",
		-- Help
		"HelpPanelShowTutorials",
		"HelpPanelLoadingScreenTips",
		"HelpPanelEnhancedTooltips",
		"HelpPanelBeginnerTooltips",
		"HelpPanelShowLuaErrors",
		"HelpPanelColorblindMode",
		"HelpPanelMovePad",
		"DisplayPanelShowAccountAchievments",
	}

	for i = 1, getn(interfacecheckbox) do
		local icheckbox = _G["InterfaceOptions"..interfacecheckbox[i]]
		if icheckbox then icheckbox:SkinCheckBox() end
	end

	local interfacedropdown ={
		-- Controls
		"ControlsPanelAutoLootKeyDropDown",
		-- Combat
		"CombatPanelTOTDropDown",
		"CombatPanelFocusCastKeyDropDown",
		"CombatPanelSelfCastKeyDropDown",
		"CombatPanelLossOfControlFullDropDown",
		"CombatPanelLossOfControlSilenceDropDown",
		"CombatPanelLossOfControlInterruptDropDown",
		"CombatPanelLossOfControlDisarmDropDown",
		"CombatPanelLossOfControlRootDropDown",
		-- Display
		"DisplayPanelAggroWarningDisplay",
		"DisplayPanelWorldPVPObjectiveDisplay",
		"DisplayPanelOutlineDropDown",
		-- Objectives
		"ObjectivesPanelQuestSorting",
		-- Social
		"SocialPanelChatStyle",
		"SocialPanelWhisperMode",
		"SocialPanelTimestamps",
		"SocialPanelBnWhisperMode",
		"SocialPanelConversationMode",
		-- Action bars
		"ActionBarsPanelPickupActionKeyDropDown",
		-- Names
		"NamesPanelNPCNamesDropDown",
		"NamesPanelUnitNameplatesMotionDropDown",
		-- Combat Text
		"CombatTextPanelFCTDropDown",
		"CombatTextPanelTargetModeDropDown",
		-- Camera
		"CameraPanelStyleDropDown",
		-- Mouse
		"MousePanelClickMoveStyleDropDown",
		"LanguagesPanelLocaleDropDown",
		"LanguagesPanelAudioLocaleDropDown",
	}

	for i = 1, getn(interfacedropdown) do
		local idropdown = _G["InterfaceOptions"..interfacedropdown[i]]
		if idropdown then
			idropdown:SkinDropDownBox()
			DropDownList1:SetTemplate("Transparent")
		end
	end
	InterfaceOptionsHelpPanelResetTutorials:SkinButton()

	local optioncheckbox = {
		-- Graphics
		"Display_RaidSettingsEnabledCheckBox",
		-- Advanced
		"Advanced_MaxFPSCheckBox",
		"Advanced_MaxFPSBKCheckBox",
		"Advanced_DesktopGamma",
		-- Audio
		"AudioOptionsSoundPanelEnableSound",
		"AudioOptionsSoundPanelSoundEffects",
		"AudioOptionsSoundPanelErrorSpeech",
		"AudioOptionsSoundPanelEmoteSounds",
		"AudioOptionsSoundPanelPetSounds",
		"AudioOptionsSoundPanelMusic",
		"AudioOptionsSoundPanelLoopMusic",
		"AudioOptionsSoundPanelPetBattleMusic",
		"AudioOptionsSoundPanelAmbientSounds",
		"AudioOptionsSoundPanelSoundInBG",
		"AudioOptionsSoundPanelReverb",
		"AudioOptionsSoundPanelHRTF",
		"AudioOptionsSoundPanelEnableDSPs",
		"AudioOptionsSoundPanelUseHardware",
		"AudioOptionsVoicePanelEnableVoice",
		"AudioOptionsVoicePanelEnableMicrophone",
		"AudioOptionsVoicePanelPushToTalkSound",
		-- Network
		"NetworkOptionsPanelOptimizeSpeed",
		"NetworkOptionsPanelUseIPv6",
		"NetworkOptionsPanelAdvancedCombatLogging",
	}

	for i = 1, getn(optioncheckbox) do
		local ocheckbox = _G[optioncheckbox[i]]
		if ocheckbox then ocheckbox:SkinCheckBox() end
	end

	local optiondropdown = {
		-- Graphics
		"Display_DisplayModeDropDown",
		"Display_ResolutionDropDown",
		"Display_RefreshDropDown",
		"Display_PrimaryMonitorDropDown",
		"Display_AntiAliasingDropDown",
		"Display_MultiSampleDropDown",
		"Display_VerticalSyncDropDown",
		"Graphics_TextureResolutionDropDown",
		"Graphics_FilteringDropDown",
		"Graphics_ProjectedTexturesDropDown",
		"Graphics_ViewDistanceDropDown",
		"Graphics_EnvironmentalDetailDropDown",
		"Graphics_GroundClutterDropDown",
		"Graphics_ShadowsDropDown",
		"Graphics_LiquidDetailDropDown",
		"Graphics_SunshaftsDropDown",
		"Graphics_ParticleDensityDropDown",
		"Graphics_SSAODropDown",
		"Graphics_RefractionDropDown",
		"RaidGraphics_TextureResolutionDropDown",
		"RaidGraphics_FilteringDropDown",
		"RaidGraphics_ProjectedTexturesDropDown",
		"RaidGraphics_ViewDistanceDropDown",
		"RaidGraphics_EnvironmentalDetailDropDown",
		"RaidGraphics_GroundClutterDropDown",
		"RaidGraphics_ShadowsDropDown",
		"RaidGraphics_LiquidDetailDropDown",
		"RaidGraphics_SunshaftsDropDown",
		"RaidGraphics_ParticleDensityDropDown",
		"RaidGraphics_SSAODropDown",
		"RaidGraphics_RefractionDropDown",
		-- Advanced
		"Advanced_BufferingDropDown",
		"Advanced_LagDropDown",
		"Advanced_HardwareCursorDropDown",
		"Advanced_GraphicsAPIDropDown",
		-- Audio
		"AudioOptionsSoundPanelHardwareDropDown",
		"AudioOptionsSoundPanelSoundChannelsDropDown",
		"AudioOptionsVoicePanelInputDeviceDropDown",
		"AudioOptionsVoicePanelChatModeDropDown",
		"AudioOptionsVoicePanelOutputDeviceDropDown",
	}

	for i = 1, getn(optiondropdown) do
		local odropdown = _G[optiondropdown[i]]
		if odropdown then
			odropdown:SkinDropDownBox(165)
			DropDownList1:SetTemplate("Transparent")
		end
	end

	local buttons = {
		"RecordLoopbackSoundButton",
		"PlayLoopbackSoundButton",
		"AudioOptionsVoicePanelChatMode1KeyBindingButton",
	}

	for _, button in pairs(buttons) do _G[button]:SkinButton() end
	InterfaceOptionsFrameAddOnsListScrollBar:SkinScrollBar()
	AudioOptionsVoicePanelChatMode1KeyBindingButton:ClearAllPoints()
	AudioOptionsVoicePanelChatMode1KeyBindingButton:Point("CENTER", AudioOptionsVoicePanelBinding, "CENTER", 0, -10)

	-- sliders
	local slides = {
		"InterfaceOptionsCombatPanelSpellAlertOpacitySlider",
		"InterfaceOptionsCombatPanelMaxSpellStartRecoveryOffset",
		"InterfaceOptionsBattlenetPanelToastDurationSlider",
		"InterfaceOptionsCameraPanelMaxDistanceSlider",
		"InterfaceOptionsCameraPanelFollowSpeedSlider",
		"InterfaceOptionsMousePanelMouseSensitivitySlider",
		"InterfaceOptionsMousePanelMouseLookSpeedSlider",
		"Advanced_MaxFPSSlider",
		"Advanced_MaxFPSBKSlider",
		"Advanced_GammaSlider",
		"AudioOptionsSoundPanelSoundQuality",
		"AudioOptionsSoundPanelMasterVolume",
		"AudioOptionsSoundPanelSoundVolume",
		"AudioOptionsSoundPanelMusicVolume",
		"AudioOptionsSoundPanelAmbienceVolume",
		"AudioOptionsSoundPanelDialogVolume",
		"AudioOptionsVoicePanelMicrophoneVolume",
		"AudioOptionsVoicePanelSpeakerVolume",
		"AudioOptionsVoicePanelSoundFade",
		"AudioOptionsVoicePanelMusicFade",
		"AudioOptionsVoicePanelAmbienceFade",
	}

	for i = 1, getn(slides) do
		if _G[slides[i]] then
			if _G[slides[i]] ~= AudioOptionsSoundPanelSoundVolume then _G[slides[i]]:SkinSlideBar(8, true) else _G[slides[i]]:SkinSlideBar(8) end
		end
	end

	GraphicsButton:StripTextures()
	GraphicsButton:SkinButton()
	Graphics_Quality:SetScript("OnUpdate", function(self) Graphics_Quality:SkinSlideBar(11) end)
	Graphics_RightQuality:SetAlpha(0)

	Graphics_QualityLow2:Point("BOTTOM", 0, -20)
	Graphics_QualityFair:Point("BOTTOM", 0, -20)
	Graphics_RightQualityLabel:Point("TOP", 0, 16)
	Graphics_QualityMed:Point("BOTTOM", 0, -20)
	Graphics_QualityHigh2:Point("BOTTOM", 0, -20)
	Graphics_QualityUltra:Point("BOTTOM", 0, -20)

	RaidButton:StripTextures()
	RaidButton:SkinButton()
	RaidGraphics_Quality:SetScript("OnUpdate", function(self) RaidGraphics_Quality:SkinSlideBar(11) end)
	RaidGraphics_RightQuality:SetAlpha(0)

	RaidGraphics_QualityLow2:Point("BOTTOM", 0, -20)
	RaidGraphics_QualityFair:Point("BOTTOM", 0, -20)
	RaidGraphics_RightQualityLabel:Point("TOP", 0, 16)
	RaidGraphics_QualityMed:Point("BOTTOM", 0, -20)
	RaidGraphics_QualityHigh2:Point("BOTTOM", 0, -20)
	RaidGraphics_QualityUltra:Point("BOTTOM", 0, -20)

	MacOptionsFrame:StripTextures()
	MacOptionsFrame:SetTemplate()
	MacOptionsButtonCompress:SkinButton()
	MacOptionsButtonKeybindings:SkinButton()
	MacOptionsFrameDefaults:SkinButton()
	MacOptionsFrameOkay:SkinButton()
	MacOptionsFrameCancel:SkinButton()
	MacOptionsFrameMovieRecording:StripTextures()
	MacOptionsITunesRemote:StripTextures()
	MacOptionsFrameMisc:StripTextures()

	MacOptionsFrameResolutionDropDown:SkinDropDownBox()
	MacOptionsFrameFramerateDropDown:SkinDropDownBox()
	MacOptionsFrameCodecDropDown:SkinDropDownBox()
	MacOptionsFrameQualitySlider:SkinSlideBar(10)

	for i = 1, 11 do
		local b = _G["MacOptionsFrameCheckButton"..i]
		b:SkinCheckBox()
	end

	MacOptionsButtonKeybindings:ClearAllPoints()
	MacOptionsButtonKeybindings:SetPoint("LEFT", MacOptionsFrameDefaults, "RIGHT", 2, 0)
	MacOptionsFrameOkay:ClearAllPoints()
	MacOptionsFrameOkay:SetPoint("LEFT", MacOptionsButtonKeybindings, "RIGHT", 2, 0)
	MacOptionsFrameCancel:ClearAllPoints()
	MacOptionsFrameCancel:SetPoint("LEFT", MacOptionsFrameOkay, "RIGHT", 2, 0)
	MacOptionsFrameCancel:SetWidth(MacOptionsFrameCancel:GetWidth() - 6)
end

tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)