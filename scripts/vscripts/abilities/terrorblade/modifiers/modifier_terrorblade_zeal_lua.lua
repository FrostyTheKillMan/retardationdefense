modifier_terrorblade_zeal_lua = class({})
------------------------------------------

function modifier_terrorblade_zeal_lua:IsHidden()
	return true
end

function modifier_terrorblade_zeal_lua:IsDebuff()
	return false
end

function modifier_terrorblade_zeal_lua:IsPurgable()
	return false
end

-------------------------------------------

function modifier_terrorblade_zeal_lua:OnCreate( kv )
	self.health_regen = self:GetAbility():GetSpecialValueFor("health_regen")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")
end

function modifier_terrorblade_zeal_lua:OnRefresh( kv )
	self.health_regen = self:GetAbility():GetSpecialValueFor("health_regen")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")
end

-------------------------------------------

function modifier_terrorblade_zeal_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	
	return funcs
end

function modifier_terrorblade_zeal_lua:GetModifierConstantHealthRegen()
	return self.health_regen
end 

function modifier_terrorblade_zeal_lua:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end 

