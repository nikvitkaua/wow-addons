--[[
Copyright 2008, 2009, 2010 João Cardoso
Scrap is distributed under the terms of the GNU General Public License (or the Lesser GPL).
This file is part of Scrap.

Scrap is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Scrap is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Scrap. If not, see <http://www.gnu.org/licenses/>.
--]]

local Scrap = CreateFrame('Button', 'Scrap')
local List


--[[ Events ]]--

function Scrap:Startup()
	self:SetScript('OnReceiveDrag', function() self:OnReceiveDrag() end) -- for the plugins to hook
	self:SetScript('OnEvent', function() self[event](self) end)
	self:RegisterEvent('VARIABLES_LOADED')
	self:RegisterEvent('MERCHANT_SHOW')
end

function Scrap:VARIABLES_LOADED()
	Scrap_List = Scrap_List or {}
	List = Scrap_List
end

function Scrap:MERCHANT_SHOW()
	if not LoadAddOn('Scrap_Merchant') then
		self:UnregisterEvent('MERCHANT_SHOW')
	else
		self:MERCHANT_SHOW()
	end
end


--[[ Item API ]]--

function Scrap:IsJunk(itemID)
	if itemID then
		local hasValue = select(3, GetItemInfo(itemID)) ~= ITEM_QUALITY_POOR or self:GetItemValue(itemID) == 0
		return hasValue and List[itemID] or not hasValue and not List[itemID]
	end
end

function Scrap:IsLocked(bag, slot)
	return select(3, GetContainerItemInfo(bag, slot))
end

function Scrap:IterateJunk()
	local bagNumSlots, bag, slot = GetContainerNumSlots(BACKPACK_CONTAINER), BACKPACK_CONTAINER, 0
	local match, itemID
	
	return function()
		match = nil
		
		while not match do
			if slot < bagNumSlots then
				slot = slot + 1
			elseif bag < NUM_BAG_FRAMES then
				bag = bag + 1
				bagNumSlots = GetContainerNumSlots(bag)
				slot = 1
			else
				bag, slot = nil
				break
			end
			
			itemID = GetContainerItemID(bag, slot)
			match = self:IsJunk(itemID) and not self:IsLocked(bag, slot)
		end
		
		return bag, slot, itemID
	end
end


--[[ Item Value API ]]--

function Scrap:GetJunkValue()
    local value = 0
    for bag, slot, id in self:IterateJunk() do
    	local itemValue = self:GetItemValue(id)
    	local stack = select(2, GetContainerItemInfo(bag, slot))
    	
		value = value + itemValue * stack
	end
	return value
end

function Scrap:GetItemValue(itemID)
    return select(11, GetItemInfo(itemID))
end


--[[ Call Addon ]]--

Scrap:Startup()