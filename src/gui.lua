--[[
-- File: gui.lua
-- Summary: GUI functions for LFGAT. This file contains the functions to create the GUI frames and widgets.
--]]

LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

local AceGUI = LibStub("AceGUI-3.0")
local uiOpen = false
local copyDialogOpen = false

function LFGAT:ShowUI()
	if uiOpen then
		return
	end

	uiOpen = true

	local frame = AceGUI:Create("Frame")
	frame:SetWidth(1200)
	frame:SetHeight(650)
	frame:SetTitle("Test")
	frame:SetStatusText("Ready to do fuck all")

	-- Close if ESC key is pressed
	_G["LFGAT_GUI"] = frame.frame
	tinsert(UISpecialFrames, "LFGAT_GUI")

	frame:SetCallback("OnClose", function(widget)
		AceGUI:Release(widget)
		uiOpen = false

		_G["LFGAT_GUI"] = nil
		for i, v in ipairs(UISpecialFrames) do
			if v == "LFGAT_GUI" then
				table.remove(UISpecialFrames, i)
				break
			end
		end
	end)

	-- Create top container for LFG and LFM
	local topContainer = AceGUI:Create("SimpleGroup")
	topContainer:SetFullWidth(true)
	topContainer:SetHeight(300)
	topContainer:SetLayout("Flow")
	frame:AddChild(topContainer)

	-- Create LFG scroll container
	local lfgContainer = AceGUI:Create("InlineGroup")
	lfgContainer:SetTitle("LFG")
	lfgContainer:SetLayout("Fill")
	topContainer:AddChild(lfgContainer)

	local lfgScroll = AceGUI:Create("ScrollFrame")
	lfgScroll:SetLayout("List")
	lfgContainer:AddChild(lfgScroll)

	-- Create LFM scroll container
	local lfmContainer = AceGUI:Create("InlineGroup")
	lfmContainer:SetTitle("LFM")
	lfmContainer:SetLayout("Fill")
	topContainer:AddChild(lfmContainer)

	local lfmScroll = AceGUI:Create("ScrollFrame")
	lfmScroll:SetLayout("List")
	lfmContainer:AddChild(lfmScroll)

	-- Create bottom container for Trade
	local tradeContainer = AceGUI:Create("InlineGroup")
	tradeContainer:SetTitle("Trade")
	tradeContainer:SetFullWidth(true)
	tradeContainer:SetFullHeight(true)
	tradeContainer:SetLayout("Fill")
	frame:AddChild(tradeContainer)

	local tradeScroll = AceGUI:Create("ScrollFrame")
	tradeScroll:SetLayout("List")
	tradeContainer:AddChild(tradeScroll)

	-- Function to dynamically set the width of the LFG and LFM containers
	local function UpdateContainerWidths()
		local frameWidth = topContainer.frame:GetWidth()
		if frameWidth < 800 then
			-- Stack vertically
			lfgContainer:SetWidth(frameWidth - 20) -- Adjust for padding/margin
			lfmContainer:SetWidth(frameWidth - 20) -- Adjust for padding/margin
			lfmContainer:SetPoint("TOPLEFT", lfgContainer.frame, "BOTTOMLEFT", 0, -10) -- Add vertical spacing
		else
			-- Place side by side
			local containerWidth = (frameWidth - 30) / 2 -- Subtracting for padding between containers
			lfgContainer:SetWidth(containerWidth)
			lfmContainer:SetWidth(containerWidth)
			lfmContainer:SetPoint("TOPLEFT", lfgContainer.frame, "TOPRIGHT", 10, 0) -- Reset to side by side
		end
	end

	-- FIX: tried to fix the height of the containers when the layout changes but it doesn't work yet
	local function UpdateContainerHeights()
		local frameHeight = frame.frame:GetHeight()
		local evenHeights = frameHeight / 2 - 10
		lfgContainer:SetHeight(evenHeights)
		lfmContainer:SetHeight(evenHeights)
		tradeContainer:SetHeight(evenHeights)
	end

	local function UpdateContainerSizes()
		UpdateContainerWidths()
		UpdateContainerHeights()
	end

	-- Function to update items
	local function UpdateItems()
		lfgScroll:ReleaseChildren()
		lfmScroll:ReleaseChildren()
		tradeScroll:ReleaseChildren()

		for _, item in ipairs(self:GetItems()) do
			local itemWidget = AceGUI:Create("Label")
			itemWidget:SetText(item.message)
			itemWidget:SetFullWidth(true)

			if item.messageType == "lfg" then
				lfgScroll:AddChild(itemWidget)
			elseif item.messageType == "lfm" then
				lfmScroll:AddChild(itemWidget)
			elseif item.messageType == "trade" then
				tradeScroll:AddChild(itemWidget)
			end
		end
	end

	-- Set initial sizes
	UpdateContainerSizes()

	-- Initial population of items
	UpdateItems()

	-- Timer to refresh items every second
	C_Timer.NewTicker(1, UpdateItems)

	-- Set the OnSizeChanged callback to adjust the width of the LFG and LFM containers
	topContainer.frame:SetScript("OnSizeChanged", UpdateContainerSizes)
	frame.frame:SetScript("OnSizeChanged", UpdateContainerSizes)
end

function LFGAT:ShowCopyTextDialog(text)
	if copyDialogOpen then
		return
	end

	local frame = AceGUI:Create("Frame")
	frame:SetTitle("Copy Text")
	frame:SetWidth(400)
	frame:SetHeight(400)
	frame:SetLayout("Flow")
	frame:SetCallback("OnClose", function(widget)
		AceGUI:Release(widget)
		copyDialogOpen = false
	end)

	local editBox = AceGUI:Create("MultiLineEditBox")
	editBox:SetLabel("Text")
	editBox:SetNumLines(10)
	editBox:SetFullWidth(true)
	editBox:SetText(text)
	editBox:DisableButton(true)

	frame:AddChild(editBox)

	local selectAllButton = AceGUI:Create("Button")
	selectAllButton:SetText("Select All")
	selectAllButton:SetWidth(100)
	selectAllButton:SetCallback("OnClick", function()
		editBox:HighlightText()
		editBox:SetFocus()
	end)
	frame:AddChild(selectAllButton)

	local regenerateButton = AceGUI:Create("Button")
	regenerateButton:SetText("Regenerate")
	regenerateButton:SetWidth(100)
	regenerateButton:SetCallback("OnClick", function()
		editBox:SetText(self:TableToString(self:GetItems()))
	end)
	frame:AddChild(regenerateButton)

	copyDialogOpen = true
end
