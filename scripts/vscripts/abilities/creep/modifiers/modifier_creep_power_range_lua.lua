modifier_creep_power_range_lua = class({})

--------------------------------------------------------------------------------

function modifier_creep_power_range_lua:IsHidden()
	return true
end

function modifier_creep_power_range_lua:IsDebuff()
	return false
end

function modifier_creep_power_range_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_creep_power_range_lua:OnCreated( kv )
	if IsServer() then
		-- get reference
		self.mana_pct_base = self:GetAbility():GetSpecialValueFor("mana_pct_base")
		self.mana_pct_bonus = self:GetAbility():GetSpecialValueFor("mana_pct_bonus")
		
	end
end

function modifier_creep_power_range_lua:OnRefresh( kv )
	if IsServer() then
		-- get reference
		self.mana_pct_base = self:GetAbility():GetSpecialValueFor("mana_pct_base")
		self.mana_pct_bonus = self:GetAbility():GetSpecialValueFor("mana_pct_bonus") * (GameRules:GetGameTime() / 60 )
		self.mana_damage_bonus = self.mana_pct_base + self.mana_pct_bonus
	end
end
--------------------------------------------------------------------------------

function modifier_creep_power_range_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICIAL,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_creep_power_range_lua:GetModifierProcAttack_BonusDamage_Magical( params )
	if IsServer() then
		return self:GetParent():GetMana() * (self.mana_damage_bonus / 100)
	end
end