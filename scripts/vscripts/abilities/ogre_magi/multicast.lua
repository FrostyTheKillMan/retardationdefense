function Multicast(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_cast
	local two_times = ability:GetLevelSpecialValueFor( "multicast_2_times", ability:GetLevel() - 1 )
	local three_times = ability:GetLevelSpecialValueFor( "multicast_3_times", ability:GetLevel() - 1 )
	local four_times = ability:GetLevelSpecialValueFor( "multicast_4_times", ability:GetLevel() - 1 )
	local eight_times = ability:GetLevelSpecialValueFor( "multicast_8_times", ability:GetLevel() - 1 )
	local rand = math.random(1,100)
	local multicast = 1
	
	-- Determines the mulicast multiplier
	if rand < two_times then
		multicast = 2
	elseif rand < two_times + three_times then
		multicast = 3
	elseif rand < two_times + three_times + four_times then	
		multicast = 4
	elseif rand < two_times + three_times + four_times + eight_times then
		multicast = 5
	end
	
	-- Small delay
	Timers:CreateTimer(0.01,
    	function()
	
	-- Ensures the caster and ability still exist after the delay
	if IsValidEntity(caster) and IsValidEntity(ability) then
		-- Finds the ability that caused the event trigger by checking if the cooldown is equal to the full cooldown
		for i=0, 15 do
			if caster:GetAbilityByIndex(i) ~= null then
				local cd = caster:GetAbilityByIndex(i):GetCooldownTimeRemaining()
				local full_cd = caster:GetAbilityByIndex(i):GetCooldown(caster:GetAbilityByIndex(i):GetLevel()-1)
				-- There is a delay after the ability cast event and before the ability goes on cooldown
				-- If the ability is on cooldown and the cooldown is within a small buffer of the full cooldown
				-- We set ability_cast
				if cd > 0 and full_cd - cd < 0.1 then
					ability_cast = caster:GetAbilityByIndex(i)
				end
			end
		end
	
		local fireblast_mana_cost = ability:GetLevelSpecialValueFor( "fireblast_mana_cost", ability:GetLevel() - 1 )
		local fireblast_cooldown = ability:GetLevelSpecialValueFor( "fireblast_cooldown", ability:GetLevel() - 1 )
		local bloodlust_cooldown = ability:GetLevelSpecialValueFor( "bloodlust_cooldown", ability:GetLevel() - 1 )
		local ignite_range = ability:GetLevelSpecialValueFor( "ignite_range", ability:GetLevel() - 1 )
		local distance = math.sqrt((caster:GetAbsOrigin().x - target:GetAbsOrigin().x)^2 + (caster:GetAbsOrigin().y - target:GetAbsOrigin().y)^2)
		
		if ability_cast ~= nil then
			if multicast ~= 1 then
				-- Not sure how to get the particle to show the proper multiplier
				-- local particle = ParticleManager:CreateParticle(keys.particle, PATTACH_OVERHEAD_FOLLOW, caster) 
				-- ParticleManager:SetParticleControlEnt(particle, 1, caster, PATTACH_OVERHEAD_FOLLOW, "follow_overhead", caster:GetAbsOrigin(), true)
				-- Fireblast
				if ability_cast:GetAbilityName() == "ogre_magi_fireblast_datadriven" then
					local stun_duration = ability_cast:GetLevelSpecialValueFor( "stun_duration", ability_cast:GetLevel() - 1 )
					local multicast_delay = ability_cast:GetLevelSpecialValueFor( "multicast_delay", ability_cast:GetLevel() - 1 )
					-- Second instance of stun and damage
					ability_cast:ApplyDataDrivenModifier( caster, target, "modifier_fireblast_multicast2", {Duration = stun_duration + multicast_delay} )
					if multicast == 2 then
						EmitSoundOn(keys.sound1, target)
					end
					-- Third instance of stun and damage
					if multicast > 2 then
						ability_cast:ApplyDataDrivenModifier( caster, target, "modifier_fireblast_multicast3", {Duration = stun_duration + 2*multicast_delay} )
						if multicast == 3 then
							EmitSoundOn(keys.sound2, target)
						end
					end
					-- Fourth instance of stun and damage
					if multicast > 3 then
						ability_cast:ApplyDataDrivenModifier( caster, target, "modifier_fireblast_multicast4", {Duration = stun_duration + 3*multicast_delay} )
						EmitSoundOn(keys.sound3, target)
					end
					-- Fifth
					if multicast > 4 then
						ability_cast:ApplyDataDrivenModifier( caster, target, "modifier_fireblast_multicast5", {Duration = stun_duration + 4*multicast_delay} )
						ability_cast:ApplyDataDrivenModifier( caster, target, "modifier_fireblast_multicast6", {Duration = stun_duration + 5*multicast_delay} )
						ability_cast:ApplyDataDrivenModifier( caster, target, "modifier_fireblast_multicast7", {Duration = stun_duration + 6*multicast_delay} )
						ability_cast:ApplyDataDrivenModifier( caster, target, "modifier_fireblast_multicast8", {Duration = stun_duration + 7*multicast_delay} )
						EmitSoundOn(keys.sound3, target)
						EmitSoundOn(keys.sound2, target)
					end
					--
				-- Ignite
				-- Ensures the target is in range
				elseif ability_cast:GetAbilityName() == "ogre_magi_ignite_datadriven" and caster:HasModifier("modifier_check_distance") == false then
					local multicast_delay = ability_cast:GetLevelSpecialValueFor( "multicast_delay", ability_cast:GetLevel() - 1 )
					-- Second projectile
					ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_ignite_multicast_action", {Duration = multicast_delay} )
					if multicast == 2 then
						EmitSoundOn(keys.sound1, caster)
					end
					-- Third projectile
					if multicast > 2 then
						ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_ignite_multicast_action", {Duration = 2*multicast_delay} )
						if multicast == 3 then
							EmitSoundOn(keys.sound2, caster)
						end
					end
					-- Fourth projectile
					if multicast > 3 then
						ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_ignite_multicast_action", {Duration = 3*multicast_delay} )
						EmitSoundOn(keys.sound3, caster)
					end
					--Fifth
					if multicast > 4 then
						ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_ignite_multicast_action", {Duration = 4*multicast_delay} )
						ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_ignite_multicast_action", {Duration = 5*multicast_delay} )
						ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_ignite_multicast_action", {Duration = 6*multicast_delay} )
						ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_ignite_multicast_action", {Duration = 7*multicast_delay} )
						ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_ignite_multicast_action", {Duration = 8*multicast_delay} )
						EmitSoundOn(keys.sound3, caster)
						EmitSoundOn(keys.sound2, caster)
					end
				-- Bloodlust
				elseif ability_cast:GetAbilityName() == "ogre_magi_bloodlust" then
					-- Applies bloodlust to the multicast number of recipients
					for i=2,multicast do
						ability_cast:ApplyDataDrivenModifier( caster, caster, "modifier_bloodlust_multicast_action", {} )
					end
				--
				elseif ability_cast:GetAbilityName() == "ogre_magi_unrefined_fireblast" then
					local stun_duration = ability_cast:GetLevelSpecialValueFor( "stun_duration", ability_cast:GetLevel() - 1 )
					local multicast_delay = ability_cast:GetLevelSpecialValueFor( "multicast_delay", ability_cast:GetLevel() - 1 )
					-- Second instance of stun and damage
					ability_cast:CastAbilityOnTarget( target, ability_cast, 1);
					if multicast == 2 then
						EmitSoundOn(keys.sound1, target)
					end
					-- Third instance of stun and damage
					if multicast > 2 then
						ability_cast:CastAbilityOnTarget( target, ability_cast, 1);
						if multicast == 3 then
							EmitSoundOn(keys.sound2, target)
						end
					end
					-- Fourth instance of stun and damage
					if multicast > 3 then
						ability_cast:CastAbilityOnTarget( target, ability_cast, 1);
						EmitSoundOn(keys.sound3, target)
					end
					-- Fifth
					if multicast > 4 then
						ability_cast:CastAbilityOnTarget( target, ability_cast, 1);
						ability_cast:CastAbilityOnTarget( target, ability_cast, 1);
						ability_cast:CastAbilityOnTarget( target, ability_cast, 1);
						ability_cast:CastAbilityOnTarget( target, ability_cast, 1);
						EmitSoundOn(keys.sound3, target)
						EmitSoundOn(keys.sound2, target)
					end
				end
			end
			local cd = ability_cast:GetCooldownTimeRemaining()
			-- Shortens fireblast cooldown and increases its manacost
			if ability_cast:GetAbilityName() == "ogre_magi_fireblast_datadriven" then
				-- Must first end cooldown to shorten it
				ability_cast:EndCooldown()
				ability_cast:StartCooldown(cd -	fireblast_cooldown)
				caster:SetMana(caster:GetMana() - fireblast_mana_cost)
			-- Shortens bloodlust cooldown
			elseif ability_cast:GetAbilityName() == "ogre_magi_bloodlust_datadriven" then
				ability_cast:EndCooldown()
				ability_cast:StartCooldown(cd - bloodlust_cooldown)
			end
		end	
	end
	end)
end
