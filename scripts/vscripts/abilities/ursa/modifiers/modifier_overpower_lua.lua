modifier_overpower_lua = class({})
--------------------------------------------------------------------------------

function modifier_overpower_lua:IsDebuff()
	return false
end

--------------------------------------------------------------------------------
function modifier_overpower_lua:OnCreated( kv )
	self.attack_speed_bonus = self:GetAbility():GetSpecialValueFor( "attack_speed_bonus" )
	self.attack_time = self:GetAbility():GetSpecialValueFor( "attack_time" )
	self.max_attacks = self:GetAbility():GetSpecialValueFor( "max_attacks" )
	
	if IsServer() then
		self:SetStackCount( self.max_attacks )
		
		self:AddEffects()
	end


end

--------------------------------------------------------------------------------

function modifier_overpower_lua:OnRefresh( kv )
	self.attack_speed_bonus = self:GetAbility():GetSpecialValueFor( "attack_speed_bonus" )
	self.attack_time = self:GetAbility():GetSpecialValueFor( "attack_time" )
	self.max_attacks = self:GetAbility():GetSpecialValueFor( "max_attacks" )
	
	if IsServer() then
		self:SetStackCount( self.max_attacks )
	end

end

--------------------------------------------------------------------------------

function modifier_overpower_lua:OnDestroy( kv )
	if IsServer() then
		self:RemoveEffects()
	end
end

--------------------------------------------------------------------------------

function modifier_overpower_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_overpower_lua:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_bonus
end


function modifier_overpower_lua:GetModifierBaseAttackTimeConstant()
	return self.attack_time
end

function modifier_overpower_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if not self:GetCaster():HasModifier("modifier_wide_swipe_attack_lua") then
			-- decrement stack
			self:DecrementStackCount()

			-- destroy if reach zero
			if self:GetStackCount() < 1 then
				self:Destroy()
			end
		end
	end
end

--------------------------------------------------------------------------------

-- Graphics & Animations (Thx Spell Libary )
function modifier_overpower_lua:AddEffects()
	-- get resources
	local particle_buff = "particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf"

	-- Create particle
	self.effect_cast = ParticleManager:CreateParticle( particle_buff, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_head", self:GetParent():GetOrigin(), true)
	ParticleManager:SetParticleControlEnt( self.effect_cast, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true)
	
	-- Apply particle
	self:AddParticle(
		self.effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end

function modifier_overpower_lua:RemoveEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

--------------------------------------------------------------------------------