modifier_phantom_assassin_shapened_blade_lua = class({})
-----------------------------------------------------------

function modifier_phantom_assassin_shapened_blade_lua:IsHidden()
	return true
end
function modifier_phantom_assassin_shapened_blade_lua:IsDebuff()
	return false
end
function modifier_phantom_assassin_shapened_blade_lua:IsPurgable()
	return false
end

--------------------------------------------------------------

function modifier_phantom_assassin_shapened_blade_lua( kv )
	if IsServer() then
		--get reference
		self.percent_chance = self:GetAbility():GetSpecialValueFor("percent_chance")
		self.duration = self:GetAbility():GetSpecialValueFor("duration")
	end
end

function modifier_phantom_assassin_shapened_blade_lua:OnRefresh( kv )
	if IsServer() then
		self.percent_chance = self:GetAbility():GetSpecialValueFor("percent_chance")
		self.duration = self:GetAbility():GetSpecialValueFor("duration")
	end
end
------------------------------------------------------------------

function modifier_phantom_assassin_shapened_blade_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_phantom_assassin_shapened_blade_lua:GetModifierProcAttack_Feedback( params )
	if IsSever() then
		local random_chance = math.random(1 , 100)
		local target = params.target
		
		if random_chance <= self.percent_chance then
			if not self:GetParent():PassiveDisable() and not target:IsBuilding() then
					modifier = target:AddNewModifier(self:GetAbility:GetCaster(), self:GetAbility(), "modifier_phantom_assassin_shapened_blade_debuff_lua", (duration = self.duration))
			end
		end

	end
end

-----------------------------------------------



