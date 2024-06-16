-- [[
-- File: items.lua
-- Summary: This file contains the functions to add, remove, and retrieve items. Items are the messages that are posted in the chat, not actual items in the game lmao whoops I really didn't think this through
--]]
LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

-- These funny looking comments are called annotations. They're used to help the code editor understand the types of variables and functions. They do nothing at runtime, they just assist with the Dev Experience™.
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
		repostCount = 0, -- TODO: Implement reposting counting
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
