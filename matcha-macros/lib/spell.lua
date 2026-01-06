local spell_metadata = matcha.SpellMetadata

local function cast_spell_wrapper(spell_name, meta)
	-- local debuff_name = meta.debuff_name or nil
	-- local debuff_immune = meta.debuff_immune or nil
	-- local debuff_timer = meta.use_debuff_timer or false
	local no_range_check = meta.no_range_check or false
	local enemy_target_not_needed = meta.friendly_target or false
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name, debuff_name, debuff_immune, nil, nil, enemy_target_not_needed, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, no_range_check, nil, debuff_timer)
end

function matcha.CastSpell(spell_id, unit_id)
	local unit_id = unit_id or "player"
	local spell_name, _, _, _, _ = SpellInfo(spell_id)
	return cast_spell_wrapper(spell_name, spell_metadata[spell_id])
end

function matcha.CastSpellFunc(...)
	return function()
		return matcha.CastSpell(unpack(arg))
	end
end