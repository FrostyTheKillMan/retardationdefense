function GlobalSilence( keys )
	local ability = keys.ability
	local caster = keys.caster
	local target = keys.target
	local duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel()))
	local duration_disarm = ability:GetLevelSpecialValueFor("duration_disarm", (ability:GetLevel()))
	local talentDisarm = caster:FindAbilityByName("special_bonus_unique_silencer"):GetLevel()
	local talentCurse = caster:FindAbilityByName("special_bonus_unique_silencer_6"):GetLevel()
	local talentDamage = caster:FindAbilityByName("special_bonus_unique_silencer_7"):GetLevel()
	local arcaneCurse = caster:FindAbilityByName("silencer_curse_of_the_silent_datadriven")
	local radius = 20000

	if IsServer() then
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					if talentDisarm == 1 then 
						ability:ApplyDataDrivenModifier( caster, enemy, "modifier_global_silence_disarm_datadriven", {duration = duration_disarm})
					end
					if talentCurse == 1 then
						arcaneCurse:ApplyDataDrivenModifier( caster, enemy, "modifier_curse_debuff_datadriven", {duration = 5})
					end
					if talentDamage == 1 then
						ability:ApplyDataDrivenModifier( caster, enemy, "modifier_global_silence_damage_datadriven", {duration = duration})	
					end
					ability:ApplyDataDrivenModifier( caster, enemy, "modifier_global_silence_datadriven", {duration = duration})	
				end
			end
		end
	end
end