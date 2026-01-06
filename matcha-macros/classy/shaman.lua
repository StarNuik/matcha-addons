shaman = {}

function matcha_MobIsCaster()
	if not UnitExists("target") then
		return false
	end
	if not UnitIsEnemy("target") then
		return false
	end
	if not UnitIsPlayer("target") then
		return false
	end
	if UnitIsDead("target") then
		return false
	end
	if UnitManaMax("target") <= 0 then
		return false
	end
	return true
end

function shaman.CastTotem(totem_name)
	local key = totem_name .. "Totem"
	local spell_name = LOCALIZATION_ZORLEN[key]
	local no_range_check = true
	local enemy_target_not_needed = true
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name, nil, nil, nil, nil, enemy_target_not_needed, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, no_range_check)
end

function shaman.CastTotemFunc(totem_name)
	return function()
		shaman.CastTotem(totem_name)
	end
end

local totems = {
	"Searing",
	"FireNove",
	"Stoneclaw",
	"FireResistance",
	"FrostResistance",
	"Stoneskin",
	"StrengthOfEarth",
	"ManaSpring",
	"PoisonCleansing",
	"Tremor",
	"Grounding",
	"HealingStream",
}
local function build_cast_totem(idx)
	return function()
		shaman.CastTotem(totems[idx])
	end
end

local function install_totems()
	for idx, val in ipairs(totems) do
		local method = "Cast" .. val .. "Totem"
		shaman[method] = build_cast_totem(idx)
	end
end
install_totems()

function shaman.CastEarthShock()
	local spell_name = LOCALIZATION_ZORLEN["EarthShock"]
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name)
end

function shaman.CastFlameShock()
	local spell_name = LOCALIZATION_ZORLEN.FlameShock
	local debuff_name = spell_name
	local debuff_immune = Zorlen_FireSpellCastImmune
	local debuff_timer = true
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name, debuff_name, debuff_immune, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, debuff_timer)
end

function shaman.CastFrostShock()
	local spell_name = LOCALIZATION_ZORLEN.FrostShock
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name)
end

-- TODO: tauren
function shaman.CastWarStomp()
	local spell_name = LOCALIZATION_ZORLEN["WarStomp"]
	local no_range_check = true
	local enemy_target_not_needed = true
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name, nil, nil, nil, nil, enemy_target_not_needed, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, no_range_check)
end
--

function shaman.CastLightningShield()
	return shaman.CastShield(LOCALIZATION_ZORLEN.LightningShield)
end

function shaman.CastWaterShield()
	return shaman.CastShield("Water Shield")
end

function shaman.CastShield(shield_name)
	local no_range_check = true
	local enemy_target_not_needed = true
	return Zorlen_CastCommonRegisteredSpell(nil, shield_name, nil, nil, nil, nil, enemy_target_not_needed, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, no_range_check)
end

function shaman.CastEarthshakerSlam()
	local spell_name = LOCALIZATION_ZORLEN["EarthshakerSlam"]
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name)
end

function shaman.CastLightningStrike()
	local spell_name = "Lightning Strike"
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name, nil, nil, nil, nil, enemy_target_not_needed, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, no_range_check)
end

function shaman.CastStormstrike()
	local spell_name = "Stormstrike"
	return Zorlen_CastCommonRegisteredSpell(nil, spell_name, nil, nil, nil, nil, enemy_target_not_needed, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, no_range_check)
end

function shaman.HasStrengthOfEarth()
	local buff_name = "Strength of Earth"
	return Zorlen_checkBuff(nil, "player", nil, buff_name)
end

function shaman.HasGrounding()
	local buff_name = "Grounding Totem Effect"
	return Zorlen_checkBuff(nil, "player", nil, buff_name)
end

function shaman.HasHealingStream()
	local buff_name = "Healing Stream"
	return Zorlen_checkBuff(nil, "player", nil, buff_name)
end


function shaman.HasStoneskin(unit_id)
	local unit_id = unit_id or "player"

	local spell_name = "Stoneskin"
	local exists = Zorlen_checkBuffByName(spell_name, unit_id)

	return exists and true or false
end

function shaman.HasManaSpring(unit_id)
	local unit_id = unit_id or "player"

	local spell_name = "Mana Spring"
	local exists = Zorlen_checkBuffByName(spell_name, unit_id)

	return exists and true or false
end

function shaman.HasLightningShield()
	return Zorlen_checkBuff(nil, "player", nil, "Lightning Shield")
end

function shaman.GetActiveShield()
	local shields = {
		"Lightning Shield",
		"Water Shield",
		"Earth Shield",
	}
	for _, spell_name in ipairs(shields) do
		if Zorlen_checkBuff(nil, "player", nil, spell_name) then
			return spell_name
		end
	end
	return nil
end

function shaman.HasFlameShock(unit_id)
	local unit_id = unit_id or "target"

	local spell_name = LOCALIZATION_ZORLEN.FlameShock
	local exists = Zorlen_checkDebuffByName(spell_name, unit_id)
	
	return exists and true or false
end

function shaman.HasGhostWolf(unit_id)
	local unit_id = unit_id or "player"

	local spell_name = LOCALIZATION_ZORLEN.GhostWolf
	local exists = Zorlen_checkBuffByName(spell_name, unit_id)
	
	return exists and true or false
end

function shaman.HasClearcasting(unit_id)
	local unit_id = unit_id or "player"

	local spell_name = "Clearcasting"
	local exists = Zorlen_checkBuffByName(spell_name, unit_id)
	
	return exists and true or false
end

function shaman.InCombat()
	if UnitAffectingCombat("player") then
		return true
	else
		return false
	end
end

function shaman.TargetHasMana()
	if not UnitExists("target") then
		return false
	end
	if UnitManaMax("target") == 0 then
		return false
	end
	return true
end

function shaman.ExitWolf()
	if not shaman.HasGhostWolf() then
		return false
	end

	CastSpellByName("Ghost Wolf")
	return true
end

function shaman.Interrupt()
	return matcha_SeqMacro({}, {
		shaman.CastEarthShock,
		shaman.CastWarStomp,
	})
end

function shaman.TotemSpam()
	return matcha_SeqMacro({
		-- matcha.Target,
	}, {
		shaman.ExitWolf,
		-- matcha.SpamGuard(shaman.CastTotemFunc("Searing"), "fire_totem", 1),
		matcha_IfNotThen(
			shaman.HasHealingStream,
			matcha.SpamGuard(
				shaman.CastTotemFunc("HealingStream"),
				"water_totem",
				1
			)
		),
		matcha_IfNotThen(shaman.HasStrengthOfEarth,
			matcha.SpamGuard(
				shaman.CastTotemFunc("StrengthOfEarth"),
				"earth_totem",
				1
			)
		),
		matcha_IfNotThen(shaman.HasGrounding,
			matcha.SpamGuard(
				shaman.CastTotemFunc("Grounding"),
				"air_totem",
				1
			)
		),
	})
end

local last_shield = "Lightning Shield"
function shaman.CastLastShield()
	local shield = shaman.GetActiveShield()
	if not shield then
		return shaman.CastShield(last_shield)
	end
	
	last_shield = shield
	return false
end


function shaman.CastBisShock()
	return matcha_SeqMacro({}, {
		shaman.CastFrostShock,
		shaman.CastEarthShock,
		shaman.CastFlameShock,
	})
	-- return shaman.CastFrostShock()
end

function shaman.Spam()
	return matcha_SeqMacro({
		matcha.Target,
	}, {
		shaman.ExitWolf,
		matcha.SpamGuard(castAttack, "attack", 1),
		matcha.SpamGuard(shaman.CastLastShield, "shield", 1),
		shaman.CastStormstrike,
		shaman.CastLightningStrike,
	})
end

function shaman.Ooc()
	return matcha_SeqMacro({}, {
		matcha_IfNotThen(shaman.HasLightningShield, shaman.CastLightningShield),
		matcha.Attack,
	})
end
