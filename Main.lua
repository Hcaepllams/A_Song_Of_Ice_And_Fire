local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)
	if (UnitClass("player") == "法师") then
		if (event == "ADDON_LOADED") then
			MakeGemMacro()
			MakeBoltMacro()
		end
	
		if (event == "BAG_UPDATE") then
			MakeGemMacro()
		end
	
		if (event == "CHARACTER_POINTS_CHANGED") then
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
		UpdateMacro(macroName, "spell_fire_firebolt02", "火球术")
--ice
	else
		UpdateMacro(macroName, "spell_frost_frostbolt02", "寒冰箭")
	end
end

function MakeGemMacro()
	local macroName = "GEM"
	local r = GetItemCount(8008)
	local c = GetItemCount(8007)
	local j = GetItemCount(5513)
--ruby
	if (r == 0) then
		UpdateMacro(macroName, "inv_misc_gem_ruby_01", "制造魔法红宝石")
--citrine
	elseif (c == 0) then
		UpdateMacro(macroName, "inv_misc_gem_opal_01", "制造魔法黄水晶")
--jade
	elseif (j == 0) then
		UpdateMacro(macroName, "inv_misc_gem_emerald_02", "制造魔法翡翠")
	end
end

function UpdateMacro(name, icon, spell)
	local macroId = GetMacroIndexByName(name)
	if (macroId == 0) then
		CreateMacro(name, icon, "/cast " .. spell, true)
	else
		EditMacro(name, name, icon, "/cast " .. spell, true)
	end
end