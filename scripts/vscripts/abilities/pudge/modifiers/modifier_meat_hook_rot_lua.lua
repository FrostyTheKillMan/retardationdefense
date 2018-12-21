modifier_meat_hook_rot_lua = class({})
--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:IsAura()
	return true
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:GetModifierAura()
	return "modifier_meat_hook_rot_lua_effect"
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:GetAuraRadius()
	return self.rot_radius
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:OnCreated( kv )
	self.rot_radius = self:GetCaster():FindAbilityByName("pudge_rot_lua"):GetSpecialValueFor( "rot_radius" )
	self.rot_slow = self:GetCaster():FindAbilityByName("pudge_rot_lua"):GetSpecialValueFor( "rot_slow" )
	self.rot_damage = self:GetCaster():FindAbilityByName("pudge_rot_lua"):GetSpecialValueFor( "rot_damage" )
	self.rot_tick = self:GetCaster():FindAbilityByName("pudge_rot_lua"):GetSpecialValueFor( "rot_tick" )

	if IsServer() then

		EmitSoundOn( "Hero_Pudge.Rot", self:GetParent() )
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_rot.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( self.rot_radius, 1, self.rot_radius ) )
		self:AddParticle( nFXIndex, false, false, -1, false, false )

		self:StartIntervalThink( self.rot_tick )
	end
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:OnDestroy()
	if IsServer() then
		StopSoundOn( "Hero_Pudge.Rot", self:GetParent() )
	end
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:GetModifierMoveSpeedBonus_Percentage( params )
	return self.rot_slow
end

--------------------------------------------------------------------------------

function modifier_meat_hook_rot_lua:OnIntervalThink()
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