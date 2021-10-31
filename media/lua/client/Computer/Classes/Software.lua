require("ISBaseObject")
require("Computer/ComputerUtils")

local Software = ISBaseObject:derive("Software")

function Software:createDiscItem(inventory)
    if inventory then
        local item = inventory:AddItem("Computer.Disc_Software")
        item:setName(item:getDisplayName() .. ": " .. self.title)
        item:getModData().softwareId = self.id
        return item
    end
end

function Software:createFloppyItem(inventory)
    if inventory then
        local item = inventory:AddItem("Computer.Floppy_Software")
        item:setName(item:getDisplayName() .. ": " .. self.title)
        item:getModData().softwareId = self.id
        return item
    end
end

function Software:new(...)
    local o = ISBaseObject:new()
    setmetatable(o, self)
    self.__index = self

    local args = ...
    if type(...) ~= "table" then args = {...}; end

    local paramCheck = {
        {name = "id",               type = "string",  value = type(args[1])},
        {name = "title",            type = "string",  value = type(args[2])},
        {name = "year",             type = "string",  value = type(args[3])},
        {name = "publisher",        type = "string",  value = type(args[4])},
        {name = "audioName",        type = "string",  value = type(args[5])},
        {name = "coverTexture",     type = "string",  value = type(args[6])},
        {name = "size",             type = "number",  value = type(args[7])},
        {name = "type",             type = "string",  value = type(args[8])}, values = ComputerMod.GetAllSoftwareTypes(),
    }

    for i = 1, #args do
        if type(args[i]) ~= paramCheck[i].type then
            error("Error calling Software:new - Argument["..i.."] ("..paramCheck[i].name..") expected to be of type "..paramCheck[i].type.." but was "..paramCheck[i].value..".", 2);
        elseif paramCheck[i].values and not ComputerUtils.tableContains(paramCheck[i].values, paramCheck[i].value) then
            error("Error calling Software:new - Argument["..i.."] ("..paramCheck[i].name..") expected to be of type "..paramCheck[i].type.." but was "..paramCheck[i].value..".", 2);
        else
            o[paramCheck[i].name] = args[i]
        end
    end

    return o
end

return Software
