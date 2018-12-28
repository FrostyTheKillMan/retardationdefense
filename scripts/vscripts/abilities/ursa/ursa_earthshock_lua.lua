ursa_earthshock_lua = class({})
LinkLuaModifier( "modifier_earthshock_lua", "abilities/ursa/modifiers/modifier_earthshock_lua.lua" ,LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function ursa_earthshock_lua:GetConceptRecipientType()
	return DOTA_SPEECH_USER_ALL
end

--------------------------------------------------------------------------------

function ursa_earthshock_lua:SpeakTrigger()
	return DOTA_ABILITY_SPEAK_CAST
end

--------------------------------------------------------------------------------

function ursa_earthshock_lua:OnSpellStart()
	self.shock_radius = self:GetSpecialValueFor( "shock_radius" )
	self.shock_damage = self:GetSpecialValueFor( "shock_damage" )
	self.slow_duration = self:GetSpecialValueFor( "slow_duration" )
	
	if IsServer() then
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), self:GetCaster(), self.shock_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then

					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = self.shock_damage,
						damage_type = DAMAGE_TYPE_MAGICAL,
						ability = self
					}

					ApplyDamage( damage )
					enemy:AddNewModifier( self:GetCaster(), self, "modifier_earthshock_lua", { duration = self.slow_duration } )
				end
			end
		end
	end
	
	self:PlayEffects()

end

function ursa_earthshock_lua:PlayEffects()
	-- get resources
	local sound_cast = "Hero_Ursa.Earthshock"
	local particle_cast = "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf"

	-- get data
	local slow_radius = self:GetSpecialValueFor("shock_radius")

	-- play particles
	local nFXIndex = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( nFXIndex, 0, self:GetCaster():GetForwardVector() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector(slow_radius/2, slow_radius/2, slow_radius/2) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	-- play sounds
	EmitSoundOn( sound_cast, self:GetCaster() )
end

