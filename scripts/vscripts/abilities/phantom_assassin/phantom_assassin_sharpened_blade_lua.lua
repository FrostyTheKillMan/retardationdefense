phantom_assassin_sharpened_blade_lua = class({})
LinkLuaModifier("modifier_phantom_assassin_sharpened_blade_lua", "abilities/phantom_assassin/modifiers/modifier_phantom_assassin_sharpened_blade_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_sharpened_blade_debuff_lua", "abilities/phantom_assassin/modifiers/modifier_phantom_assassin_sharpened_blade_debuff_lua.lua", LUA_MODIFIER_MOTION_NONE)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Passive Modifier
function phantom_assassin_sharpened_blade_lua:GetIntrinsicModifierName()
	return "modifier_phantom_assassin_shapened_blade_lua"
end