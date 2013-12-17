local D, C, L = select(2, ...):unpack()

if (not C.ActionBars.Enable) then
	return
end

local DuffedUIActionBars = T["ActionBars"]
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local PetSize = C.ActionBars.PetButtonSize
local Spacing = C.ActionBars.ButtonSpacing
local PetActionBarFrame = PetActionBarFrame
local PetActionBar_UpdateCooldowns = PetActionBar_UpdateCooldowns

function DuffedUIActionBars:CreatePetBar()
	local Bar = D.Panels.PetActionBar
	
	Bar:RegisterEvent("PLAYER_LOGIN")
	Bar:RegisterEvent("PLAYER_CONTROL_LOST")
	Bar:RegisterEvent("PLAYER_CONTROL_GAINED")
	Bar:RegisterEvent("PLAYER_ENTERING_WORLD")
	Bar:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
	Bar:RegisterEvent("PET_BAR_UPDATE")
	Bar:RegisterEvent("PET_BAR_UPDATE_USABLE")
	Bar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
	Bar:RegisterEvent("PET_BAR_HIDE")
	Bar:RegisterEvent("UNIT_PET")
	Bar:RegisterEvent("UNIT_FLAGS")
	Bar:RegisterEvent("UNIT_AURA")
	Bar:SetScript("OnEvent", function(self, event, arg1)
		if (event == "PLAYER_LOGIN") then
			PetActionBarFrame:UnregisterEvent("PET_BAR_SHOWGRID")
			PetActionBarFrame:UnregisterEvent("PET_BAR_HIDEGRID")
			PetActionBarFrame.showgrid = 1
					
			for i = 1, NUM_PET_ACTION_SLOTS do
				local Button = _G["PetActionButton"..i]
				Button:ClearAllPoints()
				Button:SetParent(self)
				Button:Size(PetSize)
				Button:Show()
				
				if (i == 1) then
					Button:SetPoint("TOPLEFT", Spacing, -Spacing)
				else
					Button:SetPoint("TOP", _G["PetActionButton"..(i - 1)], "BOTTOM", 0, -Spacing)
				end

				self:SetAttribute("addchild", Button)
				self["Button"..i] = Button
			end
			
			hooksecurefunc("PetActionBar_Update", DuffedUIActionBars.UpdatePetBar)
			
			RegisterStateDriver(self, "visibility", "[pet,nopetbattle,novehicleui,nooverridebar,nobonusbar:5] show; hide")
		elseif (event == "PET_BAR_UPDATE")
			or (event == "UNIT_PET" and arg1 == "player")
			or (event == "PLAYER_CONTROL_LOST")
			or (event == "PLAYER_CONTROL_GAINED")
			or (event == "PLAYER_FARSIGHT_FOCUS_CHANGED")
			or (event == "UNIT_FLAGS")
			or (arg1 == "pet" and (event == "UNIT_AURA")) then
				DuffedUIActionBars.UpdatePetBar()
		elseif event == "PET_BAR_UPDATE_COOLDOWN" then
			PetActionBar_UpdateCooldowns()
		else
			DuffedUIActionBars:SkinPetButtons()
		end
	end)
end