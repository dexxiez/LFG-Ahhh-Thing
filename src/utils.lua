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

function LFGAT:FormatTimeSince(time)
    local seconds = time
    local minutes = math.floor(seconds / 60)
    seconds = seconds % 60
    local hours = math.floor(minutes / 60)
    minutes = minutes % 60
    local days = math.floor(hours / 24)
    hours = hours % 24

    local timeString = ""
    if days > 0 then
        timeString = timeString .. days .. "d "
    end
    if hours > 0 then
        timeString = timeString .. hours .. "h "
    end
    if minutes > 0 then
        timeString = timeString .. minutes .. "m "
    end
    if seconds > 0 then
        timeString = timeString .. seconds .. "s"
    end

    return timeString
end

function LFGAT:TableToString(tbl)
    local function serialize(tbl)
        local result = {}
        for k, v in pairs(tbl) do
            local key = type(k) == "string" and string.format("%q", k) or k
            local value = type(v)
            if value == "table" then
                table.insert(result, string.format("[%s]=%s", key, serialize(v)))
            elseif value == "string" then
                table.insert(result, string.format("[%s]=%q", key, v))
            else
                table.insert(result, string.format("[%s]=%s", key, tostring(v)))
            end
        end
        return "{" .. table.concat(result, ",") .. "}"
    end

    return serialize(tbl)
end
