terrorblade_zeal_lua = class({})
LinkLuaModifier( "modifier_terrorblade_zeal_lua", "abilities/terrorblade/modifiers/modifier_terrorblade_zeal_lua.lua", LUA_MODIFIER_MOTION_NONE )

------------------------------------------------------------------------------------------------------------------
-- Passive Modifier
function terrorblade_zeal_lua:GetIntrinsicModifierName()
	return "modifier_terrorblade_zeal_lua"
end
