LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

function LFGAT:PLAYER_ENTERING_WORLD()
	-- Placeholder for whatever
end

function LFGAT:CHAT_MSG_CHANNEL(self, message, sender, _, _, target, _, channelId)
	if channelId == 2 or channelId == 26 then
		local category, key = LFGAT.LookupKeyword(message)
		if category then
			print("Category: " .. category .. (key and " - Key: " .. key or ""))
		end
	end
end
