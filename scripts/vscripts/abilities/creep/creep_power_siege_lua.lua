ursa_fury_swipes_lua = class({})
LinkLuaModifier( "modifier_fury_swipes_lua", "abilities/ursa/modifiers/modifier_fury_swipes_lua.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fury_swipes_debuff_lua", "abilities/ursa/modifiers/modifier_fury_swipes_debuff_lua.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function ursa_fury_swipes_lua:GetIntrinsicModifierName()
	return "modifier_fury_swipes_lua"
end