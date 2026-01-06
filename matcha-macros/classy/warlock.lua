local warlock = {
	MAX_SHARD_STACKS_ROAM = 15,
	MAX_SHARD_STACKS_DUNGEON = 15,
}

local function bind(self, method)
	method(self)
end

function warlock_QuickDamage()
	matcha_SeqMacro({
		warlock_DropShards,
		matcha.TryTarget,
		matcha_PetAttack,
	}, {
		matcha_IfThen(isNightfallActive, castShadowBolt),
		warlock_DrainNow,
		castSearingPain,
--		castShoot,
	})
end

function warlock_HealthTap()
	matcha_SeqMacro({
		warlock_DropShards,
		matcha.TryTarget,
		matcha_PetAttack,
	}, {
		Zorlen_isCastingOrChanneling,
		matcha_IfThen(isNightfallActive, castShadowBolt),
		matcha_IfThen(warlock_SiphonNow, castSiphonLife),
		castDrainLife,
	})
end

function warlock_SiphonNow()
	if not UnitExists("target") then
		return false
	end
	local health = UnitHealth("target")
	local maxHealth = UnitHealthMax("target")
	local ratio = health / maxHealth
	if ratio < 0.33 then
		return false
	end
	return true
end

function warlock_All()
	matcha_SeqMacro({
		warlock_DropShards,
		matcha.TryTarget,
		matcha_PetAttack,
	}, {
		-- Do nothing if already casting
		Zorlen_isCastingOrChanneling,

		-- Nightfall
		matcha_IfThen(isNightfallActive, castShadowBolt),

		-- Drain if low hp
		warlock_DrainIf,

		-- Dot spam
		castCorruption,
		castCotE,
		matcha_IfNotThen(isCurseOfAgony, castCoA),
		-- castSiphonLife,
		castImmolate,

		-- Damage spells
		castSoulFire,
		warlock_DrainNow,
		castSearingPain,

--		castShadowBolt,
--		castShoot,
	})
end

function warlock_Seduce()
	if not isHumanoid() then
		return false
	end
	return zSeduction()
end

function warlock_DrainIf()	
  if Zorlen_DrainSoulNow(999) then
		return warlock_DrainNow()
  end
	return false
end

function warlock_DrainNow()	
	CastSpellByName("Drain Soul")
	return true
end

function warlock_DropShards()
	local maxStacks = warlock.MAX_SHARD_STACKS_ROAM
	if runtime.is_dungeon then
		maxStacks = warlock.MAX_SHARD_STACKS_DUNGEON
	end
	local n=0; for i=0, 4 do for j=1, GetContainerNumSlots(i) do local x=GetContainerItemLink(i, j); if x and string.find(x, "item:6265:") then if n>=maxStacks then PickupContainerItem(i, j); DeleteCursorItem() else n=n+1 end end end end
end