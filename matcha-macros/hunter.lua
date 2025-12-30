hunter = {}

function hunter.cast_steady_shot()
	local spell_name = "Steady Shot"
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name)
end

function hunter.Shoot()
	return matcha_SeqMacro({
		matcha.Target,
		matcha.PetAttack,
		-- hunter.PetBite,
	}, {
		-- castHawk,
		-- castMark,
		-- matcha_IfNotThen(function() return UnitAffectingCombat("target") end, castAimed),
		castAutoShot,
		castCon,
		castSerpent,
		castArcane,
		-- hunter.cast_steady_shot,
	})
end

function hunter.Mark()
	return matcha_SeqMacro({
		matcha.Target,
		-- matcha.PetAttack,
		-- hunter.PetBite,
	}, {
		castHawk,
		castMark,
		-- castAimed,
	})
end

function hunter.pet_energy()
	return UnitMana("pet")
end

function hunter.PetBite()
	local energy_reserve = 20
	local bite_cost = 35

	local energy_left = hunter.pet_energy() - bite_cost
	if energy_left < energy_reserve then
		return false
	end
	return zBite()
end

function hunter.cast_wolf()
	local SpellName = "Aspect of the Wolf"
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName)
end

function hunter.tame_beast()
	local SpellName = "Tame Beast"
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName)
end

function hunter.Hit()
	return matcha_SeqMacro({
		matcha.Target,
		matcha.PetAttack,
	}, {
		castAttack,
		hunter.cast_wolf,
		castRaptor,
	})
end

function hunter.Feed()
	return matcha_SeqMacro({}, {
		needPet,
		function() CastSpellByName("Feed Pet") end,
	})
end