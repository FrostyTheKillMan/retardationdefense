modifier_phantom_assassin_sharpened_blade_debuff_lua = class ({})
---------------------------------------------------------------------
function modifier_phantom_assassin_sharpened_blade_debuff_lua:IsDebuff()
	return true
end

function modifier_phantom_assassin_sharpened_blade_debuff_lua:IsPurgable()
	return true
end	

-------------------------------------------------------------------------

function modifier_phantom_assassin_sharpened_blade_debuff_lua:OnCreated( kv )
	if IsServer() then
		self.armor_reduction = self:GetParent():GetAbility():GetSpecialValueFor("armor_reduction")
	end
end

---------------------------------------------------------------------------

function modifier_phantom_assassin_sharpened_blade_debuff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE
	}
	return funcs
end

----------------------------------------------------------------------------------------

function modifier_phantom_assassin_sharpened_blade_debuff_lua:GetModifierPhysicalArmorBonusUnique()
	return self.armor_reduction * -1
end