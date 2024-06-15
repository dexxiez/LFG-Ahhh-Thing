LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")


function LFGAT:Debug(message)
    if self.db.profile.debugEnabled then
        local destination = self.db.profile.debugMessageDestination
        if destination == "CHAT" then
            self:Print(message)
        elseif destination == "GUILD" then
            SendChatMessage(message, "GUILD")
        elseif destination == "IGGY" then
            SendChatMessage(message, "WHISPER", nil, "Iggyorc")
        end
    end
end

function LFGAT:GetChannels()
    local channels = {}
    local chanList = { GetChannelList() }
    for i = 1, #chanList, 3 do
        if chanList[i + 2] then -- Check if the channel is joined and not disabled
            table.insert(channels, {
                id = chanList[i],
                name = chanList[i + 1],
            })
        end
    end
    return channels
end

function LFGAT:ContainsWord(str, words)
    local lowerStr = string.lower(str)
    for _, word in ipairs(words) do
        local pattern = "%f[%a]" .. word .. "%f[%A]"
        if string.find(lowerStr, pattern) then
            return true
        end
    end
    return false
end

function LFGAT.LookupKeyword(message)
    if not LFGAT.keywords then
        print("No keyword file loaded")
        return nil
    end

    for category, keywords in pairs(LFGAT.keywords) do
        for key, keyword in pairs(keywords) do
            if type(keyword) == "table" then
                for _, subkeyword in ipairs(keyword) do
                    if string.find(message:lower(), subkeyword) then
                        return category, key
                    end
                end
            else
                if string.find(message:lower(), keyword) then
                    return category
                end
            end
        end
    end
    return nil
end
