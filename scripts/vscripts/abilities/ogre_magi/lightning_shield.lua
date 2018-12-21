function LightningShield(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local multicast_level = caster:FindAbilityByName("ogre_magi_multicast_datadriven"):GetLevel()
	--Different Effect Per Level of Multicast	
	if multicast_level == 0 then
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield", {duration = 20})	
	elseif multicast_level == 1 then
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield", {duration = 20})
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield_multicast_1", {duration = 20})
	elseif multicast_level == 2 then
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield", {duration = 20})
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield_multicast_2", {duration = 20})
	elseif multicast_level == 3 then
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield", {duration = 20})
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield_multicast_3", {duration = 20})
	elseif multicast_level == 4 then
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield", {duration = 20})
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield_multicast_4", {duration = 20})
	elseif multicast_level == 5 then
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield", {duration = 20})
		ability:ApplyDataDrivenModifier( caster, target, "modifier_lightning_shield_multicast_5", {duration = 20})
	end
end