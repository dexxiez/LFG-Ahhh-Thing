-- [[
--  File: options.lua
--  Summary: This file contains the code for the options menu. Not only is it the options menu, it also contains the code to save the options to the database.
-- ]]

LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

local defaults = {
	profile = {
		debugEnabled = false,
		debugMessageDestination = "CHAT",
		removeOldDuplicates = true,
	},
}

function LFGAT:InitOptions()
	self.db = LibStub("AceDB-3.0"):New("LFGATDB", defaults, true)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("LFGAT", self:GetOptions())
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LFGAT", "LFGAT")
end

function LFGAT:GetOptions()
	return {
		name = "General Options",
		handler = LFGAT,
		type = "group",
		args = {
			debug = {
				name = "Debug",
				desc = "Enable debug mode",
				type = "toggle",
				get = function(info)
					return LFGAT.db.profile.debugEnabled
				end,
				set = function(info, value)
					LFGAT.db.profile.debugEnabled = value
				end,
			},
			debugMessageDestination = {
				type = "select",
				name = "Send Debug Messages To",
				desc = "Select where to send debug messages",
				values = {
					["CHAT"] = "Chat",
					["GUILD"] = "Guild",
					["IGGY"] = "Iggy",
				},
				get = function(info)
					return self.db.profile.debugMessageDestination
				end,
				set = function(info, value)
					self.db.profile.debugMessageDestination = value
				end,
			},
			removeOldDuplicates = {
				name = "Remove Old Duplicates",
				desc = "Remove old duplicates of the same message",
				type = "toggle",
				get = function(info)
					return LFGAT.db.profile.removeOldDuplicates
				end,
				set = function(info, value)
					LFGAT.db.profile.removeOldDuplicates = value
				end,
			},
		},
	}
end
