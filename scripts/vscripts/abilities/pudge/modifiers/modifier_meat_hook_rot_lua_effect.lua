modifier_meat_hook_rot_lua_effect = class({})
--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua_effect:IsDebuff()
	return true
end


--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua_effect:OnCreated( kv )
	self.rot_radius = self:GetCaster():FindAbilityByName("pudge_rot_lua"):GetSpecialValueFor( "rot_radius" )
	self.rot_slow = self:GetCaster():FindAbilityByName("pudge_rot_lua"):GetSpecialValueFor( "rot_slow" )
	self.rot_damage = self:GetCaster():FindAbilityByName("pudge_rot_lua"):GetSpecialValueFor( "rot_damage" )
	self.rot_tick = self:GetCaster():FindAbilityByName("pudge_rot_lua"):GetSpecialValueFor( "rot_tick" )

	if IsServer() then

		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_rot_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		self:AddParticle( nFXIndex, false, false, -1, false, false )

		self:StartIntervalThink( self.rot_tick )
	end
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua_effect:GetModifierMoveSpeedBonus_Percentage( params )
	return self.rot_slow
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua_effect:OnIntervalThink()
	if IsServer() then
		local flDamagePerTick = self.rot_tick * self.rot_damage

		if self:GetParent():IsAlive() then
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = flDamagePerTick,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility()
			}

			ApplyDamage( damage )
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------