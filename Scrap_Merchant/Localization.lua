Scrap_Locals = {}
local L = Scrap_Locals
local Language = GetLocale()

-- Russian --
if Language == 'ruRU' then
	L["Add"] = "Добавить в список хлама"
	L["Added"] = "Добавлено в список хлама: %s"
	L["Remove"] = "Удалить из списка хлама"
	L["Removed"] = "Удалено из списка хлама: %s"
	L["SellJunk"] = "Продать хлам"
	L["SoldJunk"] = "Вы продали хлама на %s"
	
-- German --
elseif Language == 'deDE' then
	L["Add"] = "Zur Junkliste hinzufügen"
	L["Added"] = "Zur Junkliste hinzugefügt: %s"
	L["Remove"] = "Von der Junkliste entfernen"
	L["Removed"] = "Von der Junkliste entfernt: %s"
	L["SellJunk"] = "Müll verkaufen"
	L["SoldJunk"] = "Du hast deinen Müll für %s verkauft"
	
-- English --
else
	L.Add = 'Add to Junk List'
	L.Added = 'Added to junk list: %s'
	L.Remove = 'Remove from Junk List'
	L.Removed = 'Removed from junk list: %s'
	L.SellJunk = 'Sell Junk'
	L.SoldJunk = 'You sold your junk for %s'
end