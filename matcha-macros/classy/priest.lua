local priest = {} 

function priest_OverHeal()
	return castOverPriestHeal()
end

function priest_PanicSelfHeal()
	if matcha_UseHealthPotion() then
		return true
	end
	CastSpellByName("Desperate Prayer")
	return true
end

function priest_Heal()
	return castUnderPriestHeal()
end

function priest_ShouldMindblast()
	if not UnitCanAttack("player", "target") then
		return false
	end
	if UnitAffectingCombat("target") and not UnitIsUnit("player", "targettarget") then
		return false
	end
	return true
end

function priest_ShouldHolyFire()
	if not UnitCanAttack("player", "target") then
		return false
	end
end

function priest_Damage()
	return matcha_SeqMacro({
		matcha.TryTarget,
	}, {
		Zorlen_isCastingOrChanneling,
		-- matcha_IfThen(priest_ShouldMindblast, castMindBlast),
		castHolyFire,
		castShadowWordPain,
		-- matcha_IfThen(isHolyFire, castHolyFire),
		-- matcha_IfThen(isShadowWordPain, castShadowWordPain),
		-- castShadowWordPain,
		castSmite,
	})
end