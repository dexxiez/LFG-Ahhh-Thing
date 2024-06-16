-- [[
--  File: keywords.lua
--  Summary: This file contains the keywords that the addon uses to determine what type of message it is. For example, if a message contains the word "LFM" it is considered a "LFM" message.
--           All keywords are in lowercase and the addon is case-insensitive.
-- ]]

LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

-- English only because it's the correct language and the only one that matters
LFGAT.keywords = {
	trade = {
		"wts",
		"wtb",
		"wtt",
		"w2s",
		"w2b",
		"w2t",
	},
	lfg = {
		"lfg",
	},
	lfm = {
		"lfm",
		"lf*m", -- TODO: Add support for wildcard characters
	},
	zones = {
		BH = { "bh", "bh10", "bh25" },
		TBOT = { "bot", "bot10", "bot25" },
		COCK = { "coc", "crucible" },
	},
	misc = {
		RECRUITMENT = { "looking for", "recruiting", "exceptional" },
	},
}
