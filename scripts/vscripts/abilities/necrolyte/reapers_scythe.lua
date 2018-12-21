--[[Author: Pizzalol
	Date: 06.01.2015.
	Deals damage depending on missing hp
	If the target dies then it increases the respawn time]]
function ReapersScythe( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local target_missing_hp = target:GetMaxHealth() - target:GetHealth()
	local damage_per_health = ability:GetLevelSpecialValueFor("damage_per_health", (ability:GetLevel() - 1))
	local damage_per_health_scepter = ability:GetLevelSpecialValueFor("damage_per_health_scepter", (ability:GetLevel() - 1))
	local target_regen = target:GetHealthRegen();
	local regen_reduction = ability:GetLevelSpecialValueFor("regen_reduction_scepter", (ability:GetLevel() - 1))
	local respawn_time = ability:GetLevelSpecialValueFor("respawn_constant", (ability:GetLevel() - 1))
	local talent = caster:FindAbilityByName("special_bonus_unique_necrophos_2"):GetLevel()
	
	if not caster:HasScepter() then
		local damage_table = {}

		damage_table.attacker = caster
		damage_table.victim = target
		damage_table.ability = ability
		damage_table.damage_type = ability:GetAbilityDamageType()
		damage_table.damage = target_missing_hp * damage_per_health

		ApplyDamage(damage_table)
		
		if  talent == 1 then
			target:ReduceMana(damage_table.damage)
		end
		
	elseif caster:HasScepter() then
		local damage_table = {}
		
		damage_table.attacker = caster
		damage_table.victim = target
		damage_table.ability = ability
		damage_table.damage_type = ability:GetAbilityDamageType()
		damage_table.damage = target_missing_hp * damage_per_health_scepter

		ApplyDamage(damage_table)
		
		target:SetBaseHealthRegen( target_regen - regen_reduction )
		
		if  talent == 1 then
			target:ReduceMana(damage_table.damage)
		end
		
	end

	-- Checking if target is alive to decide if it needs to increase respawn time
	if target:IsHero() then
		if not target:IsAlive() then
			target:SetTimeUntilRespawn(target:GetRespawnTime() + respawn_time)
		end
	end
end