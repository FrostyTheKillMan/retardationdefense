function DeathPulseHeal( keys )
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target	
	local heal_talent = caster:FindAbilityByName("special_bonus_unique_necrophos_4"):GetLevel() 
	local heal = ability:GetLevelSpecialValueFor("heal", (ability:GetLevel() - 1))
	
	if heal_talent == 1 then	
		target:Heal(target:GetMaxHealth() * 0.1, caster)	
	end
	
	target:Heal(heal, caster)
end