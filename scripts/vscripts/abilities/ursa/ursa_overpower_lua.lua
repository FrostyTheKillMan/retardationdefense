ursa_overpower_lua = class({})
LinkLuaModifier( "modifier_overpower_lua", "abilities/ursa/modifiers/modifier_overpower_lua.lua" ,LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function ursa_overpower_lua:GetConceptRecipientType()
	return DOTA_SPEECH_USER_ALL
end

--------------------------------------------------------------------------------

function ursa_overpower_lua:SpeakTrigger()
	return DOTA_ABILITY_SPEAK_CAST
end

--------------------------------------------------------------------------------

function ursa_overpower_lua:OnSpellStart()

	self.duration = self:GetSpecialValueFor( "duration" )
	
	hBuff = self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_overpower_lua", { duration = self.duration } )
	
	EmitSoundOn( "Hero_Ursa.Overpower", self:GetCaster() )	

end