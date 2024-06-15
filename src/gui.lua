LFGAT = LibStub("AceAddon-3.0"):GetAddon("LFGAT")

local AceGUI = LibStub("AceGUI-3.0")
local uiOpen = false


function LFGAT:ShowUI()
    if uiOpen then
        return
    end

    uiOpen = true

    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Test")
    frame:SetStatusText("Ready to do fuck all")

    -- Close if ESC key is pressed
    _G["LFGAT_GUI"] = frame.frame
    tinsert(UISpecialFrames, "LFGAT_GUI")


    frame:SetCallback("OnClose",
        function(widget)
            AceGUI:Release(widget)
            uiOpen = false

            _G["LFGAT_GUI"] = nil
            for i, v in ipairs(UISpecialFrames) do
                if v == "LFGAT_GUI" then
                    table.remove(UISpecialFrames, i)
                    break
                end
            end
        end
    )

    frame:SetLayout("Fill")

    -- Create a scroll container
    local scrollcontainer = AceGUI:Create("SimpleGroup")
    scrollcontainer:SetFullWidth(true)
    scrollcontainer:SetFullHeight(true)
    scrollcontainer:SetLayout("Fill")
    frame:AddChild(scrollcontainer)

    -- Create a scroll frame
    local scrollframe = AceGUI:Create("ScrollFrame")
    scrollframe:SetLayout("List")
    scrollcontainer:AddChild(scrollframe)


    local function UpdateItems()
        scrollframe:ReleaseChildren()
        local items = self:GetItems()
        for _, item in ipairs(items) do
            local itemFrame = AceGUI:Create("InlineGroup")
            itemFrame:SetTitle(item.sender)
            itemFrame:SetFullWidth(true)
            itemFrame:SetLayout("Flow")

            local message = AceGUI:Create("Label")
            message:SetText(item.message)
            message:SetFullWidth(true)
            itemFrame:AddChild(message)

            local removeButton = AceGUI:Create("Button")
            removeButton:SetText("Remove")
            removeButton:SetCallback("OnClick",
                function()
                    self:RemoveItem(item.id)
                    UpdateItems()
                end
            )
            itemFrame:AddChild(removeButton)

            scrollframe:AddChild(itemFrame)
        end
    end

    -- Initial population of items then start a timer to update every second
    UpdateItems()
    C_Timer.NewTicker(1, UpdateItems)
end
