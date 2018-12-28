modifier_flesh_heap_lua = class({})
--------------------------------------------------------------------------------

function modifier_flesh_heap_lua:OnCreated( kv )
	self.flesh_heap_health_regen = self:GetAbility():GetSpecialValueFor( "flesh_heap_health_regen" )
	self.flesh_heap_strength_buff_amount = self:GetAbility():GetSpecialValueFor( "flesh_heap_strength_buff_amount" )
	self.flesh_heap_armor = self:GetAbility():GetSpecialValueFor( "flesh_heap_armor" )
	self.flesh_heap_magic_resistance = self:GetAbility():GetSpecialValueFor( "flesh_heap_magic_resistance" )
			
	if IsServer() then
		self:SetStackCount( self:GetAbility():GetFleshHeapKills() )
		self:GetParent():CalculateStatBonus()
	end
end

--------------------------------------------------------------------------------

function modifier_flesh_heap_lua:OnRefresh( kv )
	self.flesh_heap_health_regen = self:GetAbility():GetSpecialValueFor( "flesh_heap_health_regen" )
	self.flesh_heap_strength_buff_amount = self:GetAbility():GetSpecialValueFor( "flesh_heap_strength_buff_amount" )
	self.flesh_heap_armor = self:GetAbility():GetSpecialValueFor( "flesh_heap_armor" )
	self.flesh_heap_resistance = self:GetAbility():GetSpecialValueFor( "flesh_heap_magic_resistance" )

	if IsServer() then
		self:GetParent():CalculateStatBonus()
	end
end

--------------------------------------------------------------------------------

function modifier_flesh_heap_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_flesh_heap_lua:GetModifierConstantHealthRegen( params )
	return self.flesh_heap_health_regen
end

--------------------------------------------------------------------------------

function modifier_flesh_heap_lua:GetModifierBonusStats_Strength( params )
	return self:GetStackCount() * self.flesh_heap_strength_buff_amount
end

--------------------------------------------------------------------------------

function modifier_flesh_heap_lua:GetModifierPhysicalArmorBonus( params )

	return self:GetStackCount() * self.flesh_heap_armor

end

--------------------------------------------------------------------------------

function modifier_flesh_heap_lua:GetModifierMagicalResistanceBonus( params )

	return self:GetStackCount() * self.flesh_heap_magic_resistance

end

--------------------------------------------------------------------------------