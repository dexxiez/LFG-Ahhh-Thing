--[[
-- File: main.lua
--  Summary: The main file for LFGAT. This file contains the initialization code for the addon. I consider this in my head to be the "entry point" for the addon.
--]]

LFGAT = LibStub("AceAddon-3.0"):NewAddon("LFGAT", "AceConsole-3.0", "AceEvent-3.0")

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
	elseif input:trim() == "dump" then
		self:ShowCopyTextDialog(self:TableToString(self:GetItems()))
	else
		self:Print("Unknown command: " .. input)
	end
end
