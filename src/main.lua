LFGAT = LibStub("AceAddon-3.0"):NewAddon("LFGAT", "AceConsole-3.0", "AceEvent-3.0")


LFGAT.Log = {}

function LFGAT:OnInitialize()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("CHAT_MSG_CHANNEL")
	self:InitOptions()
	self:RegisterChatCommand("lfgat", "ChatCommand")
end

function LFGAT:ChatCommand(input)
	if input:trim() == "" then
		self:ShowUI()
	elseif input:trim() == "settings" then
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	else
		self:Print("Unknown command: " .. input)
	end
end
