modifier_earthshock_lua = class({})
--------------------------------------------------------------------------------

function modifier_earthshock_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_earthshock_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_earthshock_lua:GetModifierMoveSpeedBonus_Percentage( params )
	
	return self:GetAbility():GetSpecialValueFor( "movement_slow" )
end

--------------------------------------------------------------------------------