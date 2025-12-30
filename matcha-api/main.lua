local model = mapi.model

local function as_bool(value)
	if value then
		return true
	else
		return false
	end
end

function mapi.GetUnitGuid(unit_id)
	local _, guid = UnitExists(unit_id)
	return guid
end

function mapi.CanReadUnit(unit_id)
	return as_bool(
		UnitName(unit_id) ~= "Unknown"
	)
end

function mapi.IsTotem(unit_id)
	return as_bool(
		UnitCreatureType(unit_id) == "Totem"
	)
end

-- localization
-- l1234567890n
-- internationalization
-- i123456789012345678n

function mapi.MyTotems()
	local list = {}
	for guid in pairs(model.player_totems) do
		local name = UnitName(guid)
		append(list, name)
	end
	return list
end

-- function mapi.HasTotem(totem_name, unit_id)
-- 	local unit_id = unit_id or "player"

-- 	if UnitIsUnit(unit_id, "player") then
-- 		return mapi.HaveTotem(totem_name)
-- 	end

-- 	error("not implemented")
-- end

-- function mapi.HaveTotem(totem_name)
-- 	local unit_id = "player"

-- mapi.Sub(mapi.wow_event.WOW_RAW_COMBATLOG, function(arg1, arg2, arg3)
-- 	print("RAW_COMBATLOG", arg1, arg2, arg3)
-- end)

-- mapi.Sub(mapi.wow_event.WOW_UNIT_CASTEVENT, function(arg1, arg2, arg3, arg4, arg5, arg6)
-- 	-- print("UNIT_CASTEVENT", arg1, arg2, arg3, arg4, arg5, arg6)
-- 	local caster_guid = arg1
-- 	local caster = UnitName(caster_guid)
-- 	local target_guid = arg2
-- 	local target = UnitName(target_guid) or "none"
-- 	local spell_id = arg4
-- 	local spell = SpellInfo(spell_id)
-- 	local action = arg3
-- 	print(string.format("%s is %sing %s at %s", caster, action, spell, target))
-- end)
