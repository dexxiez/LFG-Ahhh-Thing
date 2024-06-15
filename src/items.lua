LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")



---@alias MessageType '"lfg"' | '"lfm"' | '"trade"' | '"misc"'

---@class Message
---@field id number
---@field timestamp number
---@field messageType MessageType
---@field sender string
---@field message string
---@field zone string|nil
---@field linkedItem string|nil
---@field miscCategory string|nil
---@field repostCount number

---@type Message[]
LFGAT.Items = {}

---@param messageType MessageType
---@param sender string
---@param message string
---@param zone string|nil
---@param linkedItem string|nil
function LFGAT:AddItem(messageType, sender, message, zone, linkedItem, miscCategory)
    table.insert(self.Items, {
        id = #self.Items + 1,
        timestamp = time(),
        messageType = messageType,
        sender = sender,
        message = message,
        zone = zone,
        linkedItem = linkedItem,
        miscCategory = miscCategory,
        repostCount = 0 -- TODO: Implement reposting counting
    })
end

function LFGAT:ClearItems()
    self.Items = {}
end

function LFGAT:RemoveItem(id)
    table.remove(self.Items, id)
end

function LFGAT:FindAndRemove(sender, message)
    for i, item in ipairs(self.Items) do
        if item.sender == sender and item.message == message then
            self:RemoveItem(i)
            return
        end
    end
end

---@return Message[]
function LFGAT:GetItems()
    return self.Items
end
