--[[Last Word stop loop sound
	Author: chrislotix
	Date: 11.1.2015.]]

function LastWordStopSound( keys )

	local sound_name = "Hero_Silencer.LastWord.Target"
	local target = keys.target

	StopSoundEvent(sound_name, target)
end

function LastWordSilence( keys )

	local ability = keys.ability
	local caster = keys.caster
	local target = keys.target
	local talent = caster:FindAbilityByName("special_bonus_unique_silencer_3"):GetLevel()
	local radius = ability:GetLevelSpecialValueFor("radius", (ability:GetLevel())) 
	local duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel()))
	
	if talent == 1 then
		if IsServer() then
			local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetAbsOrigin(), caster, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

			if #enemies > 0 then
				for _,enemy in pairs(enemies) do
					if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
						ability:ApplyDataDrivenModifier( caster, enemy, "modifier_last_word_silence_datadriven", {duration = duration})
					end
				end
			end
		end
	
	else
		ability:ApplyDataDrivenModifier( caster, target, "modifier_last_word_silence_datadriven", {duration = duration})
	end
end