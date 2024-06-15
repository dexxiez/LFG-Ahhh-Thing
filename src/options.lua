LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

local defaults = {
    profile = {
        debugEnabled = false,
        debugMessageDestination = "CHAT",
    }
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
                get = function(info) return LFGAT.db.profile.debugEnabled end,
                set = function(info, value) LFGAT.db.profile.debugEnabled = value end,
            },
            debugMessageDestination = {
                type = 'select',
                name = "Send Debug Messages To",
                desc = "Select where to send debug messages",
                values = {
                    ["CHAT"] = "Chat",
                    ["GUILD"] = "Guild",
                    ["IGGY"] = "Iggy",
                },
                get = function(info) return self.db.profile.debugMessageDestination end,
                set = function(info, value) self.db.profile.debugMessageDestination = value end,
            },
        },
    }
end
