modifier_wide_swipe_lua = class({})

--------------------------------------------------------------------------------

function modifier_wide_swipe_lua:IsHidden()
	return true
end

function modifier_wide_swipe_lua:IsDebuff()
	return false
end

function modifier_wide_swipe_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_wide_swipe_lua:OnCreated( kv )
	if IsServer() then
		-- get reference
		self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_pct")
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
	end
end

function modifier_wide_swipe_lua:OnRefresh( kv )
	if IsServer() then
		-- get reference
		self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_pct")
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
	end
end

--------------------------------------------------------------------------------


function modifier_wide_swipe_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_wide_swipe_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
	self.IsAttacking = false
		if self:GetAbility():IsCooldownReady() and (not self.IsAttacking ) and  (not self:GetParent():PassivesDisabled()) then
			self.IsAttacking = true
			self:GetAbility():StartCooldown( self:GetAbility():GetCooldown( self:GetAbility():GetLevel() )) 
			self:PlayEffects()
			local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), params.target:GetOrigin(), self:GetCaster(), self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
			if #enemies > 0 then
				for _,enemy in pairs(enemies) do
				print( enemy )
					if enemy ~= nil and ( not enemy:IsInvulnerable() ) then
						self:GetCaster():PerformAttack (
							enemy,
							true,
							true,
							true,
							false,
							true,
							false,
							true
						)
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------

function modifier_wide_swipe_lua:PlayEffects()
	-- get resources
	local particle_cast = "particles/ursa_wide_swipe.vpcf"

	-- play particles
	
	local nFXIndex = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	
	
end
