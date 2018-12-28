modifier_status_resistance_lua = class({})
--------------------------------------------------------------------------------

function modifier_status_resistance_lua:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function modifier_status_resistance_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_status_resistance_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATUS_RESISTANCE
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_status_resistance_lua:GetModifierStatusResistance( params )
	return 50
end

--------------------------------------------------------------------------------