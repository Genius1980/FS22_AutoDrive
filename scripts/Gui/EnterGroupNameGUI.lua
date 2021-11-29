--
-- AutoDrive Enter Group Name GUI
-- V1.1.0.0
--
-- @author Stephan Schlosser
-- @date 09/06/2019

ADEnterGroupNameGui = {}
ADEnterGroupNameGui.CONTROLS = {"textInputElement"}

local ADEnterGroupNameGui_mt = Class(ADEnterGroupNameGui, ScreenElement)

function ADEnterGroupNameGui:new(target)
    local element = ScreenElement.new(target, ADEnterGroupNameGui_mt)
    element.returnScreenName = ""
    element.textInputElement = nil
    element:registerControls(ADEnterGroupNameGui.CONTROLS)
    return element
end

function ADEnterGroupNameGui:onOpen()
    ADEnterGroupNameGui:superClass().onOpen(self)
    self.textInputElement.blockTime = 0
    self.textInputElement:onFocusActivate()
    self.textInputElement:setText("")
end

function ADEnterGroupNameGui:onClickOk()
    ADEnterGroupNameGui:superClass().onClickOk(self)

    if  self.textInputElement.text ~= ADGraphManager.debugGroupName then
        -- do not allow user to create debug group
        ADGraphManager:addGroup(self.textInputElement.text)
    end
    
    self:onClickBack()
end

function ADEnterGroupNameGui:onClickBack()
    ADEnterGroupNameGui:superClass().onClickBack(self)
end

function ADEnterGroupNameGui:onEnterPressed(_, isClick)
    if not isClick then
        self:onClickOk()
    end
end

function ADEnterGroupNameGui:onEscPressed()
    self:onClickBack()
end

function ADEnterGroupNameGui:onCreateAutoDriveHeaderText(box)
    if self.storedHeaderKey == nil then
        self.storedHeaderKey = box.text
    end
    if self.storedHeaderKey ~= nil then

        local hasText = self.storedHeaderKey ~= nil and self.storedHeaderKey ~= ""
        if hasText then
            local text = self.storedHeaderKey
            if text:sub(1,6) == "$l10n_" then
                text = text:sub(7)
            end
            text = g_i18n:getText(text)
            box:setTextInternal(text, false, true)
        end
    end
end

function ADEnterGroupNameGui:onCreateAutoDriveText1(box)
    if self.storedKey1 == nil then
        self.storedKey1 = box.text
    end
    if self.storedKey1 ~= nil then

        local hasText = self.storedKey1 ~= nil and self.storedKey1 ~= ""
        if hasText then
            local text = self.storedKey1
            if text:sub(1,6) == "$l10n_" then
                text = text:sub(7)
            end
            text = g_i18n:getText(text)
            box:setTextInternal(text, false, true)
        end
    end
end

function ADEnterGroupNameGui:copyAttributes(src)
	ADEnterGroupNameGui:superClass().copyAttributes(self, src)
    self.storedHeaderKey = src.storedHeaderKey
    self.storedKey1 = src.storedKey1
end