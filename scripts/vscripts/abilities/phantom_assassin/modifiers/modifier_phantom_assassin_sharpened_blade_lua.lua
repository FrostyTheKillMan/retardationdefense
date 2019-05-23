modifier_phantom_assassin_sharpened_blade_lua = class({})
-----------------------------------------------------------

function modifier_phantom_assassin_sharpened_blade_lua:IsHidden()
	return false
end
function modifier_phantom_assassin_sharpened_blade_lua:IsDebuff()
	return false
end
function modifier_phantom_assassin_sharpened_blade_lua:IsPurgable()
	return false
end

--------------------------------------------------------------

function modifier_phantom_assassin_sharpened_blade_lua( kv )
		--get reference
	self.percent_chance = self:GetAbility():GetSpecialValueFor("percent_chance")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_phantom_assassin_sharpened_blade_lua:OnRefresh( kv )
	self.percent_chance = self:GetAbility():GetSpecialValueFor("percent_chance")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")

end
------------------------------------------------------------------

function modifier_phantom_assassin_sharpened_blade_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_phantom_assassin_sharpened_blade_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsSever() then
		local target = params.target
		
		if self:RollChance( self.percent_chance ) then
			if not self:GetParent():PassiveDisable() and not target:IsBuilding() then
					target:AddNewModifier(self:GetAbility:GetCaster(), self:GetAbility(), "modifier_phantom_assassin_sharpened_blade_debuff_lua", (duration = self.duration))
			end
		end
		
		return 0
	end
end

-----------------------------------------------



