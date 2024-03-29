local D, C, L = unpack(select(2, ...)) 

SlashCmdList.RCSLASH = DoReadyCheck
SLASH_RCSLASH1 = "/rc"

local function DisbandRaidGroup()
	if InCombatLockdown() then return end

	if UnitInRaid("player") then
		SendChatMessage(ERR_GROUP_DISBANDED, "RAID")
		for i = 1, GetNumGroupMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= D.MyName then UninviteUnit(name) end
		end
	else
		SendChatMessage(ERR_GROUP_DISBANDED, "PARTY")
		for i = MAX_PARTY_MEMBERS, 1, -1 do
			if GetNumGroupMembers(i) then UninviteUnit(UnitName("party"..i)) end
		end
	end
	LeaveParty()
end

D.CreatePopup["DUFFEDUIDISBAND_RAID"] = {
	question = L["group"]["disband"],
	answer1 = ACCEPT,
	answer2 = CANCEL,
	function1 = DisbandRaidGroup,
}

SlashCmdList["GROUPDISBAND"] = function()
	local instanceType = select(2, IsInInstance())

	if instanceType == "pvp" or instanceType == "arena" then return end
	if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then D.ShowPopup("DUFFEDUIDISBAND_RAID") end
end
SLASH_GROUPDISBAND1 = '/gd'
SLASH_GROUPDISBAND2 = '/rd'

-- Leave party chat command
SlashCmdList["LEAVEPARTY"] = function() LeaveParty() end
SLASH_LEAVEPARTY1 = '/leaveparty'