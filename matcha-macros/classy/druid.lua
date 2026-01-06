druid = {}

function druid.Damage()
	matcha_SeqMacro({
		matcha_ChooseTarget,
	}, {
		matcha_IfThen(matcha_InactiveEnemy, castWrath),
		matcha_IfThen(matcha_ActiveEnemy, castMoonfire),
		castWrath,
	})
end

function druid.Melee()
	matcha_SeqMacro({
		matcha_ChooseTarget,
	}, {
		castAttack,
		castMoonfire,
	})
end