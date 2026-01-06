paladin = {}

function paladin.HasBlessingOfMight(unit_id)
	return matcha.HasBuff(matcha.Spell.BlessingOfMight, unit_id)
end


function paladin.Spam()
	local seal_right = matcha.Spell.SealOfRighteousness

	return matcha_SeqMacro({
		matcha.Target,
	}, {
		matcha_IfNotThen(
			matcha.HasBuffFunc(seal_right),
			matcha.CastSpellFunc(seal_right)
		),
		matcha_IfThen(
			matcha.HasBuffFunc(seal_right),
			matcha.CastSpellFunc(matcha.Spell.Judgement)
		),
		matcha.SpamGuard(castAttack, "attack", 1),
	})
end