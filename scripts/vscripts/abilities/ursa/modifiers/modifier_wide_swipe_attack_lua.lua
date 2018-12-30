modifier_wide_swipe_attack_lua = class({})

--------------------------------------------------------------------------------

function modifier_wide_swipe_attack_lua:IsHidden()
	return true
end

function modifier_wide_swipe_attack_lua:IsDebuff()
	return false
end

function modifier_wide_swipe_attack_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_wide_swipe_attack_lua:OnCreated( kv )
	if IsServer() then
		-- get reference
		self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_pct") 
		self.damage_base = self:GetCaster():GetAttackDamage()
	end
end

function modifier_wide_swipe_attack_lua:OnRefresh( kv )
	if IsServer() then
		-- get reference
		self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_pct")
		self.damage_base = self:GetCaster():GetAttackDamage()
	end
end

--------------------------------------------------------------------------------


function modifier_wide_swipe_attack_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_wide_swipe_attack_lua:GetModifierDamageOutgoing_Percentage( params )
	if IsServer() then
		return self.damage_pct / 100
	end
end

function modifier_wide_swipe_attack_lua:GetModifierPreAttack_BonusDamage( params )
	if IsServer() then
		return 0
	end
end

--------------------------------------------------------------------------------


