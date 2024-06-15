LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

function LFGAT:PLAYER_ENTERING_WORLD()
	-- Placeholder for whatever
end

-- Note: 3rd parameter is the sender with realm name included (e.g. "Sender-Realm")
function LFGAT:CHAT_MSG_CHANNEL(_, message, _, _, _, sender, _, channelId)
	if channelId == 2 or channelId == 26 then
		local category, key = LFGAT.LookupKeyword(message)
		if category then
			self:AddItem(category, sender, message)

			self:Debug("Category: " ..
				category .. (key and " - Key: " .. key or "") .. " From: " .. sender .. " - Message: " .. message)
		end
	end
end
