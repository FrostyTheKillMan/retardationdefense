

function ManaDrain( keys )

	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local mana_drain = ability:GetLevelSpecialValueFor("damage", (ability:GetLevel() -1))
	local talent = caster:FindAbilityByName("special_bonus_unique_silencer_4"):GetLevel()
	if  talent == 1 then
		target:ReduceMana(mana_drain)
	end
	
end

function Reapply( keys )

	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	
	ability:ApplyDataDrivenModifier( caster, target, "modifier_curse_debuff_datadriven", {duration = 5})

end