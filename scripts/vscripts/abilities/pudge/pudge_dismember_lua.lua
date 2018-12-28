pudge_dismember_lua = class({})
LinkLuaModifier( "modifier_dismember_lua", "abilities/pudge/modifiers/modifier_dismember_lua.lua" ,LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------

function pudge_dismember_lua:GetConceptRecipientType()
	return DOTA_SPEECH_USER_ALL
end

--------------------------------------------------------------------------------

function pudge_dismember_lua:SpeakTrigger()
	return DOTA_ABILITY_SPEAK_CAST
end

--------------------------------------------------------------------------------

function pudge_dismember_lua:GetChannelTime()
	self.creep_duration = self:GetSpecialValueFor( "creep_duration" )
	self.hero_duration = self:GetSpecialValueFor( "hero_duration" )

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_pudge_8")
	
	if talent and talent:GetLevel() > 0 then
		self.hero_duration = self.hero_duration + talent:GetSpecialValueFor( "value" ) 
	end 
	
	if IsServer() then
		if self.hVictim ~= nil then
			if self.hVictim:IsHero() then
				return self.hero_duration
			else
				return self.creep_duration
			end
		end

		return 0.0
	end
	
	return self.hero_duration

end

--------------------------------------------------------------------------------

function pudge_dismember_lua:OnAbilityPhaseStart()
	if IsServer() then
		self.hVictim = self:GetCursorTarget()
	end

	return true
end

--------------------------------------------------------------------------------

function pudge_dismember_lua:OnSpellStart()
	if self.hVictim == nil then
		return
	end

	if self.hVictim:TriggerSpellAbsorb( self ) then
		self.hVictim = nil
		self:GetCaster():Interrupt()
	else
		self.hVictim:AddNewModifier( self:GetCaster(), self, "modifier_dismember_lua", { duration = self:GetChannelTime() } )
		self.hVictim:Interrupt()
	end
	
	EmitSoundOn( "Hero_Pudge.Dismember.Cast", self:GetCaster() )	
end


--------------------------------------------------------------------------------

function pudge_dismember_lua:OnChannelFinish( bInterrupted )
	if self.hVictim ~= nil then
		self.hVictim:RemoveModifierByName( "modifier_dismember_lua" )
	end
end

--------------------------------------------------------------------------------