LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

---@alias MessageType '"lfg"' | '"lfm"' | '"trade"'

---@class Message
---@field id number
---@field timestamp number
---@field messageType MessageType
---@field sender string
---@field message string

---@type Message[]
LFGAT.Items = {}

function LFGAT:AddItem(messageType, sender, message)
    table.insert(self.Items, {
        id = #self.Items + 1,
        timestamp = time(),
        messageType = messageType,
        sender = sender,
        message = message,
    })
end

function LFGAT:ClearItems()
    self.Items = {}
end

function LFGAT:RemoveItem(id)
    table.remove(self.Items, id)
end

---@return Message[]
function LFGAT:GetItems()
    return self.Items
end
