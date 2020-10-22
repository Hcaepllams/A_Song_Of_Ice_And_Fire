local frame = CreateFrame("Frame")
frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
frame:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("BAG_UPDATE")
frame:SetScript("OnEvent", function(self, event, ...)
	if (UnitClass("player") == "法师") then
		if (event == "ADDON_LOADED") then
			MakeEatFoodMacro()
			MakeBoltMacro()
		end
	
		if (event == "BAG_UPDATE") then
			MakeEatFoodMacro()
		end
	
		if (event == "CHARACTER_POINTS_CHANGED" or event == "ACTIONBAR_PAGE_CHANGED") then
			MakeBoltMacro()
		end
	end	
end)

function MakeBoltMacro()
	local macroName = "IOF"
	local n2, t2, p2, f2 = GetTalentTabInfo(2)
	local n3, t3, p3, f3 = GetTalentTabInfo(3)
--fire
	if (p2 > p3) then
		UpdateMacro("IOF", "spell_fire_firebolt", "火球术", "/cast ")
		UpdateMacro("IOF2", "spell_frost_frostbolt02", "寒冰箭", "/cast ")
--ice
	else
		UpdateMacro("IOF", "spell_frost_frostbolt02", "寒冰箭", "/cast ")
		UpdateMacro("IOF2", "spell_fire_firebolt", "火球术", "/cast ")
	end
end

function MakeEatFoodMacro()
	local water = GetItemCount(8079)
	local food = GetItemCount(8076)

	if (water == 0) then
		UpdateMacro("喝水", "inv_drink_18", "奥特兰克魔法点心", "/use ")
	else
		UpdateMacro("喝水", "inv_drink_18", "魔法晶水", "/use ")
	end

	if (food == 0) then
		UpdateMacro("面包", "inv_misc_food_33", "奥特兰克魔法点心", "/use ")
	else
		UpdateMacro("面包", "inv_misc_food_33", "魔法甜面包", "/use ")
	end
end

function UpdateMacro(name, icon, spell, cmd)
	local macroId = GetMacroIndexByName(name)
	if (macroId == 0) then
		CreateMacro(name, icon, cmd .. spell, false)
	else
		EditMacro(name, name, icon, cmd .. spell, false)
	end
end