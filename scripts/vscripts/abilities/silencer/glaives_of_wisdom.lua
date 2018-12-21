
function IntToDamage( keys )

	local ability = keys.ability
	local caster = keys.caster
	local target = keys.target
	local int_caster = caster:GetIntellect()
	local int_damage = ability:GetLevelSpecialValueFor("intellect_damage_pct", (ability:GetLevel())) 
	local radius = ability:GetLevelSpecialValueFor("radius", (ability:GetLevel())) 
	local talent = caster:FindAbilityByName("special_bonus_unique_silencer_8"):GetLevel()
	if IsServer() then
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
				
					local damage = {	
						victim = enemy,
						attacker = caster,
						damage = int_caster * int_damage / 100,
						damage_type = DAMAGE_TYPE_PURE,
						ability = ability
					}

					ApplyDamage(damage)
					
					if talent == 1 then
						ability:ApplyDataDrivenModifier( caster, target, "modifier_silence", {duration = 0.75})	
					end
				end
			end
		end
	end
end
