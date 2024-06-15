LFGAT = LibStub("AceAddon-3.0"):NewAddon("LFGAT", "AceConsole-3.0", "AceEvent-3.0")

function LFGAT:OnInitialize()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("CHAT_MSG_CHANNEL")
end
