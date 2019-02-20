creep_power_range_lua = class({})
LinkLuaModifier( "modifier_creep_power_range_lua", "abilities/creep/modifiers/modifier_creep_power_range_lua.lua", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------
-- Passive Modifier
function creep_power_range_lua:GetIntrinsicModifierName()
	return "modifier_creep_power_range_lua"
end