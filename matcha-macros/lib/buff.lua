local MAX_BUFF = 9999

function matcha.HasBuff(spell_id, unit_id)
	local unit_id = unit_id or "player"
	for idx = 1, MAX_BUFF do
		local _, _, id = UnitBuff(unit_id, idx)
		if id == nil then
			break
		end
		if id == spell_id then
			return true
		end
	end
	return false
end

function matcha.HasBuffFunc(...)
	return function()
		return matcha.HasBuff(unpack(arg))
	end
end
