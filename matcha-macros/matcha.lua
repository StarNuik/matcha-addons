-- Namespace
if not matcha then
	matcha = {}
end

-- mapi.Sub(mapi.wow_event.WOW_UNIT_CASTEVENT, function(caster_id, _, _, spell_id)
-- 	print(UnitName(caster_id), spell_id, SpellInfo(spell_id))
-- end)

-- Runtime
runtime = {
	is_dungeon = false,
	spam_guard = {},
}

-- Targeting
function matcha_EnableDungeon()
	runtime.is_dungeon = true
	print("Dungeon mode")
end

function matcha_DisableDungeon()
	runtime.is_dungeon = nil
	print("Roam mode")
end

function matcha.ToggleDungeon()
	runtime.is_dungeon = not runtime.is_dungeon
	if runtime.is_dungeon then
		print("Dungeon mode")
	else
		print("Roam mode")
	end
end

function matcha.IsValidTarget(unit_id)
	if not UnitExists(unit_id) or not UnitIsVisible(unit_id) then
		return false
	elseif UnitIsDead(unit_id) then
		return false 
	elseif not UnitCanAttack("player", unit_id) then
		return false
	elseif runtime.is_dungeon and not UnitAffectingCombat(unit_id) then
		return false
	end
	return true
end

function matcha.TargetRaid()
	local marks = {"mark8", "mark7", "mark4", "mark6"}
	local target = nil
	for _, val in ipairs(marks) do
		if matcha.IsValidTarget(val) then
			TargetUnit(val)
			return true
		end
	end

	return false
end

function matcha.OverwriteTarget()
	if matcha.TargetRaid() then
		return true
	end
	if matcha.IsValidTarget("pettarget") then
		TargetUnit("pettarget")
		return true
	end
	zTargetActiveEnemyThatGivesXPOnly()
	return matcha.IsValidTarget("target")
end

function matcha.Target()
	if matcha.IsValidTarget("target") then
		return true
	end
	return matcha.OverwriteTarget()
end

function matcha.TabTarget()
	if matcha.Target() then
		return true
	end
	zTargetNearestEnemy()
	return matcha.IsValidTarget("target")
end

function matcha.PetAttack()
	if matcha.IsValidTarget("pettarget") then
		return true
	end
	if matcha.IsValidTarget("target") then
		PetAttack("target")
		return true
	end
	return false
end

-- General
function matcha_CastShoot()
	matcha.TryTarget()
	castShoot()
	PetAttack(target)
end

function matcha_CastMelee()
	matcha.TryTarget()
	castAttack()
end

function matcha_InactiveEnemy()
	return not matcha_ActiveEnemy()
end

function matcha_ActiveEnemy()
	return Zorlen_isActiveEnemy()
end

function matcha_UseHealthPotion()
	local potions = {
		9421, 19012, 19013, -- Major Healthstone
		5510, 19010, 19011, -- Greater Healthstone
		5509, 19008, 19009, -- Healthstone
		5511, 19006, 19007, -- Lesser Healthstone
		5512, 19004, 19005, -- Minor Healthstone
		13446, -- Major Healing Potion
		3928, -- Superior Healing Potion
		1710, -- Greater Healing Potion
		929, -- Healing Potion
		858, -- Lesser Healing Potion
		118, -- Minor Healing Potion
	}
	for _, id in ipairs(potions) do
		if Zorlen_useContainerItemByItemID(id) then
			return true
		end
	end
	return false
end

-- Warlock keys
function matcha_SeqMacro(pre, ordered)
	for _, call in ipairs(pre) do
		call()
	end
	for _, call in ipairs(ordered) do
		if call() then
			return
		end
	end
end

function matcha_IfThen(cond, call)
	return function()
		if cond() then
			return call()
		end
		return false
	end
end

function matcha_IfNotThen(cond, call)
	return function()
		if not cond() then
			return call()
		end
		return false
	end
end

function matcha_PetAttack()
	if Zorlen_isEnemy() then
  		PetAttack(target)
	end
end

function matcha.MountOrFish(mount_name)
	local slot = GetInventorySlotInfo("MainHandSlot")
	local item = GetInventoryItemTexture("player", slot)
	if item and string.find(item,"INV_Fishingpole") then
		CastSpellByName("Fishing")
	else
		CastSpellByName(mount_name)
	end
end

function matcha_PrintNpc()
	local exists, guid = UnitExists("target")
	if not exists then
		return
	end
	local hex_id = string.sub(guid, 9, 12)
	local id = tonumber(hex_id, 16)
	print(id)
end

function matcha.Hack()
	-- local backdrop = {
	-- 	bgFile = "Interface\\Buttons\\WHITE8X8",
	-- 	edgeFile = "Interface\\Buttons\\WHITE8X8",
	-- 	edgeSize = 1,
	-- 	insets = { left = 1, right = 1, top = 1, bottom = 1, },
	-- }
	local f = CreateFrame("Cooldown", "Meow", UIParent)
	-- f:SetHeight(100)
	-- f:SetWidth(100)
	-- f:SetBackdrop(backdrop)
	f:SetPoint("CENTER", 0, 0)

end

function matcha.SpamGuard(action, key, delay_sec)
	return function()
		local curr_time = GetTime()
		local last_action = runtime.spam_guard[key]
		if not last_action then
			last_action = 0
		end

		if curr_time - last_action >= delay_sec then
			local success = action()
			if success then
				runtime.spam_guard[key] = curr_time
				return true
			end
		end
		return false
	end
end

function matcha.PrintUnit(unit_id)
	local exists, guid = UnitExists(unit_id)
	if not exists then
		print("nil unit")
		return
	end

	print(guid)
	print("UnitAffectingCombat", UnitAffectingCombat(guid))
	print("UnitArmor", UnitArmor(guid))
	print("UnitAttackBothHands", UnitAttackBothHands(guid))
	print("UnitAttackPower", UnitAttackPower(guid))
	print("UnitAttackSpeed", UnitAttackSpeed(guid))
	print("UnitClass", UnitClass(guid))
	print("UnitClassification", UnitClassification(guid))
	print("UnitCreatureFamily", UnitCreatureFamily(guid))
	print("UnitCreatureType", UnitCreatureType(guid))
	print("UnitDamage", UnitDamage(guid))
	print("UnitDefense", UnitDefense(guid))
	print("UnitFactionGroup", UnitFactionGroup(guid))
	print("UnitIsCharmed", UnitIsCharmed(guid))
	print("UnitIsCivilian", UnitIsCivilian(guid))
	print("UnitIsConnected", UnitIsConnected(guid))
	print("UnitIsCorpse", UnitIsCorpse(guid))
	print("UnitIsDead", UnitIsDead(guid))
	print("UnitIsPlayer", UnitIsPlayer(guid))
	print("UnitIsPlusMob", UnitIsPlusMob(guid))
	print("UnitIsTrivial", UnitIsTrivial(guid))
	print("UnitIsVisible", UnitIsVisible(guid))
	print("UnitLevel", UnitLevel(guid))
	print("UnitName", UnitName(guid))
	print("UnitPlayerControlled", UnitPlayerControlled(guid))
	print("UnitPlayerOrPetInParty", UnitPlayerOrPetInParty(guid))
	print("UnitPowerType", UnitPowerType(guid))
	print("UnitRace", UnitRace(guid))
	print("UnitSex", UnitSex(guid))
end

function matcha.IsInCombat(unit_id)
	return UnitAffectingCombat(unit_id)
end

function matcha.AmInCombat()
	return matcha.IsInCombat("player")
end

function matcha.Sub()
	local f = CreateFrame("Frame")

	f:RegisterEvent("COMBAT_LOG_EVENT")

	f:SetScript("OnEvent", function()
		print(arg1, arg2)
	end)
end
